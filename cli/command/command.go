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

	Build    buildCommand    `cmd:"" help:"Build the generated Nomad job files."`
	Validate validateCommand `cmd:"" help:"Validate every generated job."`
	Plan     planCommand     `cmd:"" help:"Plan every generated job against the cluster."`
	Apply    applyCommand    `cmd:"" help:"Validate and submit every generated job."`
	Help     helpCommand     `cmd:"" hidden:""`
}

type buildCommand struct {
	OutLink string `default:"result" help:"Path for the result symlink." placeholder:"PATH"`
}

type validateCommand struct{}

type planCommand struct{}

type applyCommand struct {
	Detach bool `help:"Return after each job is submitted instead of monitoring it."`
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
	config *cli
	stdin  io.Reader
	stdout io.Writer
	stderr io.Writer
}

func Run(ctx context.Context, version string, args []string, stdin io.Reader, stdout, stderr io.Writer) error {
	if len(args) == 0 {
		args = []string{"help"}
	}

	configuration := &cli{}
	parser, err := kong.New(
		configuration,
		kong.Name("nix-nomad"),
		kong.Description("Build and deploy Nomad jobs from a nix-nomad flake."),
		kong.UsageOnError(),
		kong.Vars{"version": version},
		kong.Writers(stdout, stderr),
	)
	if err != nil {
		return fmt.Errorf("create command parser: %w", err)
	}

	parsed, err := parser.Parse(args)
	if err != nil {
		return &ExitError{Code: 2}
	}

	execution := &runtime{
		config: configuration,
		stdin:  stdin,
		stdout: stdout,
		stderr: stderr,
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

func (command *buildCommand) Run(ctx context.Context, runtime *runtime) error {
	selection, err := runtime.selection(ctx)
	if err != nil {
		return err
	}

	if err := runtime.run(ctx, runtime.config.Nix, "build", "--out-link", command.OutLink, selection.jobsPackage()); err != nil {
		return preserveExitCode(err, "build jobs package")
	}
	return nil
}

func (*validateCommand) Run(ctx context.Context, runtime *runtime) error {
	return runtime.withArtifacts(ctx, func(artifacts commandArtifacts) error {
		for _, job := range artifacts.jobs {
			if err := runtime.run(ctx, artifacts.nomad, "job", "validate", "-json", job); err != nil {
				return preserveExitCode(err, "validate %s", filepath.Base(job))
			}
		}
		return nil
	})
}

func (*planCommand) Run(ctx context.Context, runtime *runtime) error {
	return runtime.withArtifacts(ctx, func(artifacts commandArtifacts) error {
		changed := false
		for _, job := range artifacts.jobs {
			err := runtime.run(ctx, artifacts.nomad, "job", "plan", "-json", job)
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

func (command *applyCommand) Run(ctx context.Context, runtime *runtime) error {
	return runtime.withArtifacts(ctx, func(artifacts commandArtifacts) error {
		for _, job := range artifacts.jobs {
			if err := runtime.run(ctx, artifacts.nomad, "job", "validate", "-json", job); err != nil {
				return preserveExitCode(err, "validate %s", filepath.Base(job))
			}
		}

		for _, job := range artifacts.jobs {
			arguments := []string{"job", "run", "-json"}
			if command.Detach {
				arguments = append(arguments, "-detach")
			}
			arguments = append(arguments, job)
			if err := runtime.run(ctx, artifacts.nomad, arguments...); err != nil {
				return preserveExitCode(err, "apply %s", filepath.Base(job))
			}
		}
		return nil
	})
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

func (selection selection) nomad() string {
	return selection.attribute("nomad")
}

type commandArtifacts struct {
	jobs  []string
	nomad string
}

func (runtime *runtime) withArtifacts(ctx context.Context, action func(commandArtifacts) error) (err error) {
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

	artifacts, err := runtime.artifacts(ctx, rootDirectory)
	if err != nil {
		return err
	}
	return action(artifacts)
}

func (runtime *runtime) artifacts(ctx context.Context, rootDirectory string) (commandArtifacts, error) {
	selection, err := runtime.selection(ctx)
	if err != nil {
		return commandArtifacts{}, err
	}

	jobsPackage, err := runtime.buildStorePath(ctx, selection.jobsPackage(), filepath.Join(rootDirectory, "jobs"))
	if err != nil {
		return commandArtifacts{}, fmt.Errorf("build jobs package: %w", err)
	}
	nomadPackage, err := runtime.buildStorePath(ctx, selection.nomad(), filepath.Join(rootDirectory, "nomad"))
	if err != nil {
		return commandArtifacts{}, fmt.Errorf("build Nomad package: %w", err)
	}

	jobs, err := jobFiles(jobsPackage)
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
