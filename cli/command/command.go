package command

import (
	"bytes"
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"os"
	"os/exec"
	"path/filepath"
	"sort"
	"strconv"
	"strings"

	"github.com/alecthomas/kong"
)

type cli struct {
	Version kong.VersionFlag `name:"version" help:"Print the version."`
	Flake   string           `default:".#default" help:"Flake reference and nomadConfigurations name." placeholder:"URI#NAME"`
	Nix     string           `default:"nix" help:"Nix executable." hidden:""`

	Build    buildCommand    `cmd:"" help:"Build the selected Nomad job files."`
	Validate validateCommand `cmd:"" help:"Validate the selected Nomad jobs."`
	Plan     planCommand     `cmd:"" help:"Plan the selected Nomad jobs against the cluster."`
	Run      runCommand      `cmd:"" help:"Run the selected Nomad jobs."`
	Help     helpCommand     `cmd:"" hidden:""`
}

type jobTarget struct {
	All bool   `help:"Use all configured jobs instead of <job_name>."`
	Job string `arg:"" optional:"" name:"job_name" help:"Name of one generated job. Required unless --all is specified."`
}

type buildCommand struct {
	Target  jobTarget `embed:""`
	OutLink string    `default:"result" help:"Path for the result symlink." placeholder:"PATH"`
}

type validateCommand struct {
	Target jobTarget `embed:""`
}

type planCommand struct {
	Target jobTarget `embed:""`
}

type runCommand struct {
	Target jobTarget `embed:""`
	Detach bool      `help:"Return after each job is submitted instead of monitoring it."`
}

type helpCommand struct{}

// ExitError requests a specific process exit code. A nil Err suppresses an
// additional diagnostic because the child command already wrote one.
type ExitError struct {
	Code int
	Err  error
}

func (e *ExitError) Error() string {
	if e.Err == nil {
		return fmt.Sprintf("exit status %d", e.Code)
	}
	return e.Err.Error()
}

type runtime struct {
	config         *cli
	nomadArguments []string
	stdin          io.Reader
	stdout         io.Writer
	stderr         io.Writer
}

func Run(ctx context.Context, version string, args []string, stdin io.Reader, stdout, stderr io.Writer) error {
	if len(args) == 0 {
		args = []string{"help"}
	}
	cliArguments, nomadArguments := splitNomadArguments(args)

	configuration := &cli{}
	parser, err := kong.New(
		configuration,
		kong.Name("nix-nomad"),
		kong.Description("Build and deploy Nomad jobs from a nix-nomad flake."),
		kong.UsageOnError(),
		kong.Help(nomadStyleHelp),
		kong.Vars{"version": version},
		kong.Writers(stdout, stderr),
	)
	if err != nil {
		return fmt.Errorf("create command parser: %w", err)
	}

	parsed, err := parser.Parse(cliArguments)
	if err != nil {
		return &ExitError{Code: 2}
	}

	execution := &runtime{
		config:         configuration,
		nomadArguments: nomadArguments,
		stdin:          stdin,
		stdout:         stdout,
		stderr:         stderr,
	}
	parsed.BindTo(ctx, (*context.Context)(nil))
	if err := parsed.Run(execution); err != nil {
		return err
	}
	return nil
}

func (*helpCommand) Run(context *kong.Context) error {
	context.Path = context.Path[:1]
	return context.PrintUsage(false)
}

func nomadStyleHelp(options kong.HelpOptions, context *kong.Context) error {
	var output bytes.Buffer
	stdout := context.Stdout
	context.Stdout = &output
	err := kong.DefaultHelpPrinter(options, context)
	context.Stdout = stdout
	if err != nil {
		return err
	}

	help := output.String()
	if command := context.Selected(); command != nil && len(command.Positional) != 0 {
		oldUsage := "Usage: " + context.Model.Name + " " + command.Summary()
		newUsage := "Usage: " + context.Model.Name + " " + flagsBeforeArguments(command)
		help = strings.Replace(help, oldUsage, newUsage, 1)
	}
	for _, command := range context.Model.Leaves(true) {
		oldSummary := "\n  " + command.Summary() + "\n"
		newSummary := "\n  " + flagsBeforeArguments(command) + "\n"
		help = strings.Replace(help, oldSummary, newSummary, 1)
	}
	help = strings.ReplaceAll(help, "[<job_name>]", "<job_name>")
	_, err = io.WriteString(stdout, help)
	return err
}

func flagsBeforeArguments(command *kong.Command) string {
	summary := command.Summary()
	const flags = " [flags]"
	if !strings.HasSuffix(summary, flags) {
		return summary
	}

	summary = strings.TrimSuffix(summary, flags)
	path := command.Path()
	return path + flags + strings.TrimPrefix(summary, path)
}

func (command *buildCommand) Run(ctx context.Context, runtime *runtime) error {
	if err := command.Target.validate(); err != nil {
		return err
	}
	if len(runtime.nomadArguments) != 0 {
		return usageError("build does not run Nomad and cannot accept arguments after '--'")
	}
	selection, err := runtime.selection(ctx)
	if err != nil {
		return err
	}

	if err := runtime.run(ctx, runtime.config.Nix, "build", "--out-link", command.OutLink, command.Target.installable(selection)); err != nil {
		return preserveExitCode(err, "build selected jobs")
	}
	return nil
}

func (command *validateCommand) Run(ctx context.Context, runtime *runtime) error {
	if err := command.Target.validate(); err != nil {
		return err
	}
	return runtime.withArtifacts(ctx, command.Target, func(artifacts commandArtifacts) error {
		for _, job := range artifacts.jobs {
			arguments := append([]string{"job", "validate", "-json"}, runtime.nomadArguments...)
			arguments = append(arguments, job)
			if err := runtime.run(ctx, artifacts.nomad, arguments...); err != nil {
				return preserveExitCode(err, "validate %s", filepath.Base(job))
			}
		}
		return nil
	})
}

func (command *planCommand) Run(ctx context.Context, runtime *runtime) error {
	if err := command.Target.validate(); err != nil {
		return err
	}
	return runtime.withArtifacts(ctx, command.Target, func(artifacts commandArtifacts) error {
		changed := false
		for _, job := range artifacts.jobs {
			arguments := append([]string{"job", "plan", "-json"}, runtime.nomadArguments...)
			arguments = append(arguments, job)
			err := runtime.run(ctx, artifacts.nomad, arguments...)
			if err == nil {
				continue
			}

			var exitError *exec.ExitError
			if errors.As(err, &exitError) && exitError.ExitCode() == 1 {
				changed = true
				continue
			}
			return preserveExitCode(err, "plan %s", filepath.Base(job))
		}

		if changed {
			return &ExitError{Code: 1}
		}
		return nil
	})
}

func (command *runCommand) Run(ctx context.Context, runtime *runtime) error {
	if err := command.Target.validate(); err != nil {
		return err
	}
	return runtime.withArtifacts(ctx, command.Target, func(artifacts commandArtifacts) error {
		for _, job := range artifacts.jobs {
			arguments := []string{"job", "run", "-json"}
			if command.Detach {
				arguments = append(arguments, "-detach")
			}
			arguments = append(arguments, runtime.nomadArguments...)
			arguments = append(arguments, job)
			if err := runtime.run(ctx, artifacts.nomad, arguments...); err != nil {
				return preserveExitCode(err, "run %s", filepath.Base(job))
			}
		}
		return nil
	})
}

func splitNomadArguments(arguments []string) ([]string, []string) {
	for index, argument := range arguments {
		if argument == "--" {
			return arguments[:index], append([]string(nil), arguments[index+1:]...)
		}
	}
	return arguments, nil
}

func (target jobTarget) validate() error {
	if target.All && target.Job != "" {
		return usageError("--all cannot be used with <job_name>")
	}
	if !target.All && target.Job == "" {
		return usageError("provide <job_name> or use --all")
	}
	return nil
}

func usageError(format string, arguments ...any) error {
	return &ExitError{Code: 2, Err: fmt.Errorf(format, arguments...)}
}

func preserveExitCode(err error, format string, arguments ...any) error {
	context := fmt.Sprintf(format, arguments...)
	message := fmt.Errorf("%s: %w", context, err)
	var exitError *exec.ExitError
	if !errors.As(err, &exitError) {
		return message
	}

	code := exitError.ExitCode()
	if code < 1 || code > 255 {
		code = 1
	}
	return &ExitError{Code: code, Err: message}
}

type selection struct {
	flake  string
	name   string
	system string
}

func (runtime *runtime) selection(ctx context.Context) (selection, error) {
	flake, name, err := splitFlakeReference(runtime.config.Flake)
	if err != nil {
		return selection{}, err
	}

	var output bytes.Buffer
	if err := runtime.runWithOutput(ctx, &output, runtime.config.Nix, "eval", "--impure", "--raw", "--expr", "builtins.currentSystem"); err != nil {
		return selection{}, fmt.Errorf("determine current system: %w", err)
	}
	system := strings.TrimSpace(output.String())
	if system == "" {
		return selection{}, errors.New("current system is empty")
	}

	return selection{flake: flake, name: name, system: system}, nil
}

func splitFlakeReference(reference string) (string, string, error) {
	if reference == "" {
		return "", "", errors.New("flake reference is empty")
	}

	index := strings.LastIndexByte(reference, '#')
	if index == -1 {
		return reference, "default", nil
	}

	flake := reference[:index]
	name := reference[index+1:]
	if flake == "" {
		return "", "", errors.New("flake URI before '#' is empty")
	}
	if name == "" {
		return "", "", errors.New("configuration name after '#' is empty")
	}
	return flake, name, nil
}

func (selection selection) attribute(field string) string {
	return selection.flake + "#nomadConfigurations." + strconv.Quote(selection.name) + "." + strconv.Quote(selection.system) + "." + field
}

func (selection selection) jobsPackage() string {
	return selection.attribute("jobsPackage")
}

func (selection selection) jobPackage(name string) string {
	return selection.attribute("jobsPackages." + strconv.Quote(name))
}

func (selection selection) nomad() string {
	return selection.attribute("nomad")
}

func (target jobTarget) installable(selection selection) string {
	if target.All {
		return selection.jobsPackage()
	}
	return selection.jobPackage(target.Job)
}

type commandArtifacts struct {
	jobs  []string
	nomad string
}

func (runtime *runtime) withArtifacts(ctx context.Context, target jobTarget, action func(commandArtifacts) error) (err error) {
	rootDirectory, err := os.MkdirTemp("", "nix-nomad-")
	if err != nil {
		return fmt.Errorf("create temporary GC roots: %w", err)
	}
	defer func() {
		if cleanupErr := os.RemoveAll(rootDirectory); cleanupErr != nil {
			cleanupErr = fmt.Errorf("remove temporary GC roots: %w", cleanupErr)
			var exitError *ExitError
			if errors.As(err, &exitError) {
				err = &ExitError{Code: exitError.Code, Err: errors.Join(exitError.Err, cleanupErr)}
			} else {
				err = errors.Join(err, cleanupErr)
			}
		}
	}()

	artifacts, err := runtime.artifacts(ctx, rootDirectory, target)
	if err != nil {
		return err
	}
	return action(artifacts)
}

func (runtime *runtime) artifacts(ctx context.Context, rootDirectory string, target jobTarget) (commandArtifacts, error) {
	selection, err := runtime.selection(ctx)
	if err != nil {
		return commandArtifacts{}, err
	}

	jobsPackage, err := runtime.buildStorePath(ctx, target.installable(selection), filepath.Join(rootDirectory, "jobs"))
	if err != nil {
		return commandArtifacts{}, fmt.Errorf("build selected jobs: %w", err)
	}
	nomadPackage, err := runtime.buildStorePath(ctx, selection.nomad(), filepath.Join(rootDirectory, "nomad"))
	if err != nil {
		return commandArtifacts{}, fmt.Errorf("build Nomad package: %w", err)
	}

	jobs, err := selectedJobFiles(jobsPackage, target.All)
	if err != nil {
		return commandArtifacts{}, err
	}
	nomad := filepath.Join(nomadPackage, "bin", "nomad")
	info, err := os.Stat(nomad)
	if err != nil {
		return commandArtifacts{}, fmt.Errorf("find selected Nomad executable: %w", err)
	}
	if info.IsDir() || info.Mode()&0o111 == 0 {
		return commandArtifacts{}, fmt.Errorf("selected Nomad executable is not executable: %s", nomad)
	}

	return commandArtifacts{jobs: jobs, nomad: nomad}, nil
}

func selectedJobFiles(path string, all bool) ([]string, error) {
	if all {
		return jobFiles(path)
	}

	info, err := os.Stat(path)
	if err != nil {
		return nil, fmt.Errorf("find selected job file: %w", err)
	}
	if info.IsDir() || filepath.Ext(path) != ".json" {
		return nil, fmt.Errorf("selected job is not a JSON file: %s", path)
	}
	return []string{path}, nil
}

type nixBuildResult struct {
	Outputs map[string]string `json:"outputs"`
}

func (runtime *runtime) buildStorePath(ctx context.Context, installable, outLink string) (string, error) {
	var output bytes.Buffer
	if err := runtime.runWithOutput(ctx, &output, runtime.config.Nix, "build", "--json", "--out-link", outLink, installable); err != nil {
		return "", err
	}

	var results []nixBuildResult
	if err := json.Unmarshal(output.Bytes(), &results); err != nil {
		return "", fmt.Errorf("parse Nix build output: %w", err)
	}
	if len(results) != 1 {
		return "", fmt.Errorf("Nix build returned %d results, expected 1", len(results))
	}
	path, ok := results[0].Outputs["out"]
	if !ok || path == "" {
		return "", errors.New("Nix build result has no 'out' output")
	}
	return path, nil
}

func jobFiles(directory string) ([]string, error) {
	entries, err := os.ReadDir(directory)
	if err != nil {
		return nil, fmt.Errorf("read jobs package: %w", err)
	}

	jobs := make([]string, 0, len(entries))
	for _, entry := range entries {
		if entry.IsDir() || filepath.Ext(entry.Name()) != ".json" {
			continue
		}
		jobs = append(jobs, filepath.Join(directory, entry.Name()))
	}
	sort.Strings(jobs)
	if len(jobs) == 0 {
		return nil, fmt.Errorf("jobs package contains no JSON files: %s", directory)
	}
	return jobs, nil
}

func (runtime *runtime) run(ctx context.Context, name string, arguments ...string) error {
	command := exec.CommandContext(ctx, name, arguments...)
	command.Stdin = runtime.stdin
	command.Stdout = runtime.stdout
	command.Stderr = runtime.stderr
	if err := command.Run(); err != nil {
		return err
	}
	return nil
}

func (runtime *runtime) runWithOutput(ctx context.Context, stdout io.Writer, name string, arguments ...string) error {
	command := exec.CommandContext(ctx, name, arguments...)
	command.Stdin = runtime.stdin
	command.Stdout = stdout
	command.Stderr = runtime.stderr
	if err := command.Run(); err != nil {
		return err
	}
	return nil
}
