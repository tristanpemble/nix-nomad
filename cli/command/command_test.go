package command

import (
	"bytes"
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"path/filepath"
	"reflect"
	"strings"
	"testing"

	"github.com/alecthomas/kong"
)

func TestSplitFlakeReference(t *testing.T) {
	t.Parallel()

	tests := []struct {
		name      string
		reference string
		flake     string
		config    string
		wantError bool
	}{
		{name: "defaults configuration", reference: ".", flake: ".", config: "default"},
		{name: "local configuration", reference: ".#production", flake: ".", config: "production"},
		{name: "URL", reference: "github:example/jobs#staging", flake: "github:example/jobs", config: "staging"},
		{name: "empty reference", wantError: true},
		{name: "empty flake", reference: "#production", wantError: true},
		{name: "empty configuration", reference: ".#", wantError: true},
	}

	for _, test := range tests {
		test := test
		t.Run(test.name, func(t *testing.T) {
			t.Parallel()
			flake, config, err := splitFlakeReference(test.reference)
			if test.wantError {
				if err == nil {
					t.Fatal("expected an error")
				}
				return
			}
			if err != nil {
				t.Fatalf("split flake reference: %v", err)
			}
			if flake != test.flake || config != test.config {
				t.Fatalf("got (%q, %q), want (%q, %q)", flake, config, test.flake, test.config)
			}
		})
	}
}

func TestSelectionAttributes(t *testing.T) {
	t.Parallel()

	selection := selection{flake: ".", name: "production", system: "x86_64-linux"}
	if got, want := selection.jobsPackage(), `.#nomadConfigurations."production"."x86_64-linux".jobsPackage`; got != want {
		t.Fatalf("jobs package selector = %q, want %q", got, want)
	}
	if got, want := selection.jobPackage(`api.v2`), `.#nomadConfigurations."production"."x86_64-linux".jobsPackages."api.v2"`; got != want {
		t.Fatalf("job package selector = %q, want %q", got, want)
	}
	if got, want := selection.nomad(), `.#nomadConfigurations."production"."x86_64-linux".nomad`; got != want {
		t.Fatalf("Nomad selector = %q, want %q", got, want)
	}
}

func TestJobTarget(t *testing.T) {
	t.Parallel()

	tests := []struct {
		name      string
		target    jobTarget
		wantError bool
	}{
		{name: "one job", target: jobTarget{Job: "api"}},
		{name: "all jobs", target: jobTarget{All: true}},
		{name: "no selection", wantError: true},
		{name: "conflicting selection", target: jobTarget{All: true, Job: "api"}, wantError: true},
	}

	for _, test := range tests {
		test := test
		t.Run(test.name, func(t *testing.T) {
			t.Parallel()
			err := test.target.validate()
			if test.wantError {
				var exitError *ExitError
				if !errors.As(err, &exitError) || exitError.Code != 2 {
					t.Fatalf("target error = %v, want usage error", err)
				}
				return
			}
			if err != nil {
				t.Fatalf("validate target: %v", err)
			}
		})
	}
}

func TestSplitNomadArguments(t *testing.T) {
	t.Parallel()

	tests := []struct {
		name      string
		arguments []string
		cli       []string
		nomad     []string
	}{
		{name: "no separator", arguments: []string{"run", "api"}, cli: []string{"run", "api"}},
		{name: "arguments", arguments: []string{"run", "api", "--", "-namespace=prod", "-detach"}, cli: []string{"run", "api"}, nomad: []string{"-namespace=prod", "-detach"}},
		{name: "empty arguments", arguments: []string{"validate", "api", "--"}, cli: []string{"validate", "api"}},
	}

	for _, test := range tests {
		test := test
		t.Run(test.name, func(t *testing.T) {
			t.Parallel()
			cli, nomad := splitNomadArguments(test.arguments)
			if !reflect.DeepEqual(cli, test.cli) || !reflect.DeepEqual(nomad, test.nomad) {
				t.Fatalf("split arguments = (%q, %q), want (%q, %q)", cli, nomad, test.cli, test.nomad)
			}
		})
	}
}

func TestJobFilesAreJSONAndSorted(t *testing.T) {
	t.Parallel()

	directory := t.TempDir()
	for _, name := range []string{"zeta.json", "alpha.json", "README"} {
		if err := os.WriteFile(filepath.Join(directory, name), nil, 0o600); err != nil {
			t.Fatalf("write fixture: %v", err)
		}
	}

	got, err := jobFiles(directory)
	if err != nil {
		t.Fatalf("list job files: %v", err)
	}
	want := []string{
		filepath.Join(directory, "alpha.json"),
		filepath.Join(directory, "zeta.json"),
	}
	if !reflect.DeepEqual(got, want) {
		t.Fatalf("job files = %q, want %q", got, want)
	}
}

func TestJobFilesRejectsEmptyPackage(t *testing.T) {
	t.Parallel()

	if _, err := jobFiles(t.TempDir()); err == nil {
		t.Fatal("expected an error")
	}
}

func TestSelectedJobFile(t *testing.T) {
	t.Parallel()

	path := filepath.Join(t.TempDir(), "api.json")
	if err := os.WriteFile(path, []byte("{}"), 0o600); err != nil {
		t.Fatalf("write fixture: %v", err)
	}
	got, err := selectedJobFiles(path, false)
	if err != nil {
		t.Fatalf("select job file: %v", err)
	}
	if want := []string{path}; !reflect.DeepEqual(got, want) {
		t.Fatalf("selected job files = %q, want %q", got, want)
	}
	if _, err := selectedJobFiles(filepath.Dir(path), false); err == nil {
		t.Fatal("expected a directory error")
	}
}

func TestHelpCommandMatchesDefaultAndIsHidden(t *testing.T) {
	t.Parallel()

	run := func(arguments ...string) string {
		t.Helper()
		var stdout bytes.Buffer
		var stderr bytes.Buffer
		if err := Run(context.Background(), "test", arguments, strings.NewReader(""), &stdout, &stderr); err != nil {
			t.Fatalf("run %q: %v\nstderr: %s", arguments, err, stderr.String())
		}
		return stdout.String()
	}

	defaultHelp := run()
	commandHelp := run("help")
	if defaultHelp != commandHelp {
		t.Fatalf("default help and help command differ:\n--- default ---\n%s\n--- command ---\n%s", defaultHelp, commandHelp)
	}
	if strings.Contains(defaultHelp, "\n  help") {
		t.Fatalf("hidden help command is listed:\n%s", defaultHelp)
	}
	if !strings.Contains(defaultHelp, "\n  run [flags] <job_name>") || strings.Contains(defaultHelp, "\n  apply") {
		t.Fatalf("help does not show the run command rename:\n%s", defaultHelp)
	}
}

func TestNomadStyleCommandHelp(t *testing.T) {
	t.Parallel()

	var stdout bytes.Buffer
	var stderr bytes.Buffer
	parser, err := kong.New(&cli{}, kong.Name("nix-nomad"), kong.Writers(&stdout, &stderr))
	if err != nil {
		t.Fatalf("create parser: %v", err)
	}
	context, err := parser.Parse([]string{"run", "api"})
	if err != nil {
		t.Fatalf("parse command: %v", err)
	}
	if err := nomadStyleHelp(kong.HelpOptions{}, context); err != nil {
		t.Fatalf("print help: %v", err)
	}
	help := stdout.String()
	if !strings.HasPrefix(help, "Usage: nix-nomad run [flags] <job_name>\n") {
		t.Fatalf("run usage is not Nomad-style:\n%s", help)
	}
	if !strings.Contains(help, "\n  <job_name>    Name of one generated job.") {
		t.Fatalf("run argument is shown as optional:\n%s", help)
	}
	if !strings.Contains(help, "Required unless --all is specified.") {
		t.Fatalf("run help does not explain when job_name is required:\n%s", help)
	}
	if !strings.Contains(help, "Use all configured jobs instead of <job_name>.") {
		t.Fatalf("run help does not explain --all:\n%s", help)
	}
}

func TestCommandSelectionUsageErrors(t *testing.T) {
	t.Parallel()

	tests := [][]string{
		{"validate"},
		{"plan", "--all", "api"},
		{"build", "api", "--", "-unused"},
	}
	for _, arguments := range tests {
		var stdout bytes.Buffer
		var stderr bytes.Buffer
		err := Run(context.Background(), "test", arguments, strings.NewReader(""), &stdout, &stderr)
		var exitError *ExitError
		if !errors.As(err, &exitError) || exitError.Code != 2 {
			t.Fatalf("run %q error = %v, want usage error", arguments, err)
		}
	}
}

func TestRunAllJobsAndCommandExitCodes(t *testing.T) {
	t.Parallel()

	directory := t.TempDir()
	jobsDirectory := filepath.Join(directory, "jobs")
	nomadDirectory := filepath.Join(directory, "nomad")
	if err := os.MkdirAll(filepath.Join(nomadDirectory, "bin"), 0o700); err != nil {
		t.Fatalf("create fixture directories: %v", err)
	}
	if err := os.MkdirAll(jobsDirectory, 0o700); err != nil {
		t.Fatalf("create jobs directory: %v", err)
	}
	for _, name := range []string{"zeta.json", "alpha.json"} {
		if err := os.WriteFile(filepath.Join(jobsDirectory, name), []byte("{}"), 0o600); err != nil {
			t.Fatalf("write job fixture: %v", err)
		}
	}
	alphaPath := filepath.Join(jobsDirectory, "alpha.json")

	logPath := filepath.Join(directory, "nomad.log")
	failPath := filepath.Join(directory, "fail-nomad")
	planChangesPath := filepath.Join(directory, "plan-changes")
	nomadPath := filepath.Join(nomadDirectory, "bin", "nomad")
	nomadScript := fmt.Sprintf("#!/bin/sh\nprintf '%%s\\n' \"$*\" >> %q\nif [ -e %q ]; then exit 7; fi\nif [ \"$2\" = plan ] && [ -e %q ]; then exit 1; fi\n", logPath, failPath, planChangesPath)
	if err := os.WriteFile(nomadPath, []byte(nomadScript), 0o700); err != nil {
		t.Fatalf("write Nomad fixture: %v", err)
	}

	nixPath := filepath.Join(directory, "nix")
	nixLogPath := filepath.Join(directory, "nix.log")
	jobsBuildOutput, err := json.Marshal([]nixBuildResult{{Outputs: map[string]string{"out": jobsDirectory}}})
	if err != nil {
		t.Fatalf("marshal jobs build output: %v", err)
	}
	jobBuildOutput, err := json.Marshal([]nixBuildResult{{Outputs: map[string]string{"out": alphaPath}}})
	if err != nil {
		t.Fatalf("marshal job build output: %v", err)
	}
	nomadBuildOutput, err := json.Marshal([]nixBuildResult{{Outputs: map[string]string{"out": nomadDirectory}}})
	if err != nil {
		t.Fatalf("marshal Nomad build output: %v", err)
	}
	nixScript := fmt.Sprintf(`#!/bin/sh
printf '%%s\n' "$*" >> %q
case "$1" in
  eval)
    printf 'x86_64-linux'
    ;;
  build)
    case "$*" in
      *jobsPackages*) ln -s %q "$4"; printf '%%s' %q ;;
      *jobsPackage*) ln -s %q "$4"; printf '%%s' %q ;;
      *nomad*) ln -s %q "$4"; printf '%%s' %q ;;
      *) exit 2 ;;
    esac
    ;;
  *) exit 2 ;;
esac
`, nixLogPath, alphaPath, jobBuildOutput, jobsDirectory, jobsBuildOutput, nomadDirectory, nomadBuildOutput)
	if err := os.WriteFile(nixPath, []byte(nixScript), 0o700); err != nil {
		t.Fatalf("write Nix fixture: %v", err)
	}

	var stdout bytes.Buffer
	var stderr bytes.Buffer
	if err := Run(context.Background(), "test", []string{"--nix", nixPath, "run", "--all", "--detach", "--", "-policy-override"}, strings.NewReader(""), &stdout, &stderr); err != nil {
		t.Fatalf("run all jobs: %v\nstderr: %s", err, stderr.String())
	}

	log, err := os.ReadFile(logPath)
	if err != nil {
		t.Fatalf("read Nomad log: %v", err)
	}
	want := strings.Join([]string{
		"job run -json -detach -policy-override " + filepath.Join(jobsDirectory, "alpha.json"),
		"job run -json -detach -policy-override " + filepath.Join(jobsDirectory, "zeta.json"),
		"",
	}, "\n")
	if string(log) != want {
		t.Fatalf("Nomad calls:\n%s\nwant:\n%s", log, want)
	}
	assertTemporaryRootsRemoved(t, nixLogPath)

	if err := os.WriteFile(failPath, nil, 0o600); err != nil {
		t.Fatalf("enable Nomad failure: %v", err)
	}
	if err := os.WriteFile(nixLogPath, nil, 0o600); err != nil {
		t.Fatalf("reset Nix log: %v", err)
	}
	if err := os.WriteFile(logPath, nil, 0o600); err != nil {
		t.Fatalf("reset Nomad log: %v", err)
	}
	stderr.Reset()
	err = Run(context.Background(), "test", []string{"--nix", nixPath, "validate", "alpha", "--", "-namespace=prod"}, strings.NewReader(""), &stdout, &stderr)
	var exitError *ExitError
	if !errors.As(err, &exitError) || exitError.Code != 7 {
		t.Fatalf("validate error = %v, want exit code 7", err)
	}
	assertTemporaryRootsRemoved(t, nixLogPath)
	log, err = os.ReadFile(logPath)
	if err != nil {
		t.Fatalf("read Nomad log: %v", err)
	}
	if want := "job validate -json -namespace=prod " + alphaPath + "\n"; string(log) != want {
		t.Fatalf("validate call = %q, want %q", log, want)
	}

	if err := os.Remove(failPath); err != nil {
		t.Fatalf("disable Nomad failure: %v", err)
	}
	if err := os.WriteFile(planChangesPath, nil, 0o600); err != nil {
		t.Fatalf("enable plan changes: %v", err)
	}
	if err := os.WriteFile(nixLogPath, nil, 0o600); err != nil {
		t.Fatalf("reset Nix log: %v", err)
	}
	stderr.Reset()
	err = Run(context.Background(), "test", []string{"--nix", nixPath, "plan", "--all"}, strings.NewReader(""), &stdout, &stderr)
	exitError = nil
	if !errors.As(err, &exitError) || exitError.Code != 1 || exitError.Err != nil {
		t.Fatalf("plan error = %#v, want quiet exit code 1", err)
	}
	assertTemporaryRootsRemoved(t, nixLogPath)
}

func assertTemporaryRootsRemoved(t *testing.T, logPath string) {
	t.Helper()

	log, err := os.ReadFile(logPath)
	if err != nil {
		t.Fatalf("read Nix log: %v", err)
	}
	lines := strings.Split(strings.TrimSpace(string(log)), "\n")
	if len(lines) != 3 {
		t.Fatalf("Nix calls = %q, want one eval and two builds", lines)
	}

	var roots []string
	for _, line := range lines[1:] {
		fields := strings.Fields(line)
		if len(fields) < 5 || fields[0] != "build" || fields[1] != "--json" || fields[2] != "--out-link" {
			t.Fatalf("Nix build call does not create an output link: %q", line)
		}
		roots = append(roots, fields[3])
	}
	if filepath.Dir(roots[0]) != filepath.Dir(roots[1]) {
		t.Fatalf("temporary roots do not share an owner directory: %q", roots)
	}
	if filepath.Base(roots[0]) != "jobs" || filepath.Base(roots[1]) != "nomad" {
		t.Fatalf("temporary roots = %q, want jobs and nomad", roots)
	}
	for _, root := range roots {
		if _, err := os.Lstat(root); !os.IsNotExist(err) {
			t.Fatalf("temporary root still exists after command: %s", root)
		}
	}
}
