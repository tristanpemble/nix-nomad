package main

import (
	"errors"
	"io"
	"reflect"
	"strings"
	"testing"

	"github.com/hashicorp/nomad/api"
)

func TestRenderNixModule(t *testing.T) {
	t.Parallel()

	schema, err := analyzeSchema(reflect.TypeOf(fixtureRoot{}))
	if err != nil {
		t.Fatalf("analyzeSchema() error = %v", err)
	}
	generated := renderNixModule(schema)

	fragments := []string{
		"{ config, lib, ... }:\n\n{\n",
		"_module.types.FixtureTask = with lib; with config._module.types; with lib.types; submodule ({ name, ... }: {",
		"options.task = mkOption {\n      type = (nullOr (attrsOf FixtureTask));\n      default = null;",
		"Tasks = mapAttrsToList (_: FixtureTask.toJSON) attrs.task;",
		"task = builtins.listToAttrs (builtins.map (v: nameValuePair v.Name (FixtureTask.fromJSON v)) attrs.Tasks);",
	}
	for _, fragment := range fragments {
		if !strings.Contains(generated, fragment) {
			t.Errorf("generated module does not contain %q", fragment)
		}
	}

	rootIndex := strings.Index(generated, "_module.types.FixtureRoot")
	stepIndex := strings.Index(generated, "_module.types.FixtureStep")
	taskIndex := strings.Index(generated, "_module.types.FixtureTask")
	if !(rootIndex >= 0 && rootIndex < stepIndex && stepIndex < taskIndex) {
		t.Errorf("type definitions are not sorted: root=%d step=%d task=%d", rootIndex, stepIndex, taskIndex)
	}
}

func TestRenderNomadNetworkResourcePorts(t *testing.T) {
	t.Parallel()

	schema, err := analyzeSchema(reflect.TypeOf(api.Job{}))
	if err != nil {
		t.Fatalf("analyzeSchema() error = %v", err)
	}
	networkResource := requireType(t, schema, "NetworkResource")

	toJSON := renderToJSON(networkResource)
	for _, fragment := range []string{
		"dynamicPortAttrs = filterAttrs (_: port: (port.static or null) == null) ports;",
		"reservedPortAttrs = filterAttrs (_: port: (port.static or null) != null) ports;",
		"DynamicPorts = dynamicPorts;",
		"ReservedPorts = reservedPorts;",
		"CIDR = attrs.cidr;",
	} {
		if !strings.Contains(toJSON, fragment) {
			t.Errorf("NetworkResource.toJSON does not contain %q", fragment)
		}
	}
	if strings.Contains(toJSON, "DynamicPorts = mapAttrsToList (_: Port.toJSON) attrs.port") {
		t.Error("NetworkResource.toJSON still sends every port to DynamicPorts")
	}

	fromJSON := renderFromJSON(networkResource)
	for _, fragment := range []string{
		"(Port.fromJSON v) // { static = null; }",
		"port = dynamicPorts // reservedPorts;",
		"cidr = attrs.CIDR;",
	} {
		if !strings.Contains(fromJSON, fragment) {
			t.Errorf("NetworkResource.fromJSON does not contain %q", fragment)
		}
	}
	if strings.Contains(fromJSON, "{ reservedPorts =") {
		t.Error("NetworkResource.fromJSON still exposes ReservedPorts as a separate Nix option")
	}
}

func TestRenderMapBackedLabeledBlocksFromJSON(t *testing.T) {
	t.Parallel()

	schema, err := analyzeSchema(reflect.TypeOf(api.Job{}))
	if err != nil {
		t.Fatalf("analyzeSchema() error = %v", err)
	}

	tests := []struct {
		typeName string
		fragment string
	}{
		{
			typeName: "TaskGroup",
			fragment: "if attrs ? Volumes && builtins.isAttrs attrs.Volumes then { volume = mapAttrs (_: VolumeRequest.fromJSON) attrs.Volumes; } else {}",
		},
		{
			typeName: "ConsulGatewayProxy",
			fragment: "if attrs ? EnvoyGatewayBindAddresses && builtins.isAttrs attrs.EnvoyGatewayBindAddresses then { envoyGatewayBindAddresses = mapAttrs (_: ConsulGatewayBindAddress.fromJSON) attrs.EnvoyGatewayBindAddresses; } else {}",
		},
	}

	for _, test := range tests {
		test := test
		t.Run(test.typeName, func(t *testing.T) {
			t.Parallel()
			generated := renderFromJSON(requireType(t, schema, test.typeName))
			if !strings.Contains(generated, test.fragment) {
				t.Errorf("%s.fromJSON does not contain %q", test.typeName, test.fragment)
			}
		})
	}
}

func TestRenderNomadTaskIdentityAndScalingCompatibility(t *testing.T) {
	t.Parallel()

	schema, err := analyzeSchema(reflect.TypeOf(api.Job{}))
	if err != nil {
		t.Fatalf("analyzeSchema() error = %v", err)
	}
	task := requireType(t, schema, "Task")

	renderedType := renderType(task)
	for _, fragment := range []string{
		"options.scaling = mkOption",
		"options.cpu = mkOption",
		"options.mem = mkOption",
		"The option Task.scalings is deprecated.",
	} {
		if !strings.Contains(renderedType, fragment) {
			t.Errorf("Task type does not contain %q", fragment)
		}
	}

	toJSON := renderToJSON(task)
	for _, fragment := range []string{
		"defaultIdentities = builtins.filter isDefaultIdentity identityValues;",
		"Identity = WorkloadIdentity.toJSON (builtins.head defaultIdentities);",
		"Identities = builtins.map WorkloadIdentity.toJSON namedIdentities;",
		`type = "vertical_cpu";`,
		`type = "vertical_mem";`,
		"Task CPU scaling is defined in both scaling.cpu and scalings",
	} {
		if !strings.Contains(toJSON, fragment) {
			t.Errorf("Task.toJSON does not contain %q", fragment)
		}
	}

	fromJSON := renderFromJSON(task)
	for _, fragment := range []string{
		"attrs ? Identity && attrs.Identity != null",
		"optional hasIdentity (WorkloadIdentity.fromJSON attrs.Identity)",
		`(policy.type or null) == "vertical_cpu"`,
		`(policy.type or null) == "vertical_mem"`,
		`removeAttrs (builtins.head cpuPolicies) [ "type" ]`,
		"scalings = compatibilityPolicies;",
	} {
		if !strings.Contains(fromJSON, fragment) {
			t.Errorf("Task.fromJSON does not contain %q", fragment)
		}
	}
}

func TestRenderNomadPeriodicConfigAddsSpecType(t *testing.T) {
	t.Parallel()

	schema, err := analyzeSchema(reflect.TypeOf(api.Job{}))
	if err != nil {
		t.Fatalf("analyzeSchema() error = %v", err)
	}
	periodic := requireType(t, schema, "PeriodicConfig")
	rendered := renderToJSON(periodic)
	for _, fragment := range []string{
		"hasCron = attrs ? cron && attrs.cron != null;",
		"hasCrons = attrs ? crons && attrs.crons != null;",
		"PeriodicConfig cannot set both cron and crons",
		`SpecType = "cron";`,
	} {
		if !strings.Contains(rendered, fragment) {
			t.Errorf("PeriodicConfig.toJSON does not contain %q", fragment)
		}
	}
}

func TestRenderNomadJobAndGroupScopes(t *testing.T) {
	t.Parallel()

	schema, err := analyzeSchema(reflect.TypeOf(api.Job{}))
	if err != nil {
		t.Fatalf("analyzeSchema() error = %v", err)
	}

	jobType := renderType(requireType(t, schema, "Job"))
	groupType := renderType(requireType(t, schema, "TaskGroup"))
	for name, rendered := range map[string]string{"Job": jobType, "TaskGroup": groupType} {
		for _, fragment := range []string{"options.secret = mkOption", "options.vault = mkOption"} {
			if !strings.Contains(rendered, fragment) {
				t.Errorf("%s type does not contain %q", name, fragment)
			}
		}
	}

	jobToJSON := renderToJSON(requireType(t, schema, "Job"))
	for _, fragment := range []string{
		"__nixNomadInheritedVault = jobVault;",
		"__nixNomadInheritedSecretScopes = jobSecretScopes;",
	} {
		if !strings.Contains(jobToJSON, fragment) {
			t.Errorf("Job.toJSON does not contain %q", fragment)
		}
	}

	groupToJSON := renderToJSON(requireType(t, schema, "TaskGroup"))
	for _, fragment := range []string{
		"effectiveVault = if attrs ? vault && attrs.vault != null then attrs.vault else inheritedVault;",
		"__nixNomadInheritedSecretScopes = secretScopes;",
	} {
		if !strings.Contains(groupToJSON, fragment) {
			t.Errorf("TaskGroup.toJSON does not contain %q", fragment)
		}
	}

	taskToJSON := renderToJSON(requireType(t, schema, "Task"))
	for _, fragment := range []string{
		"secrets = taskSecrets ++ inheritedSecrets;",
		"Vault = Vault.toJSON effectiveVault;",
	} {
		if !strings.Contains(taskToJSON, fragment) {
			t.Errorf("Task.toJSON does not contain %q", fragment)
		}
	}
}

func TestWriteNixModulePropagatesWriterFailures(t *testing.T) {
	t.Parallel()

	schema, err := analyzeSchema(reflect.TypeOf(fixtureRoot{}))
	if err != nil {
		t.Fatalf("analyzeSchema() error = %v", err)
	}

	sentinel := errors.New("write failed")
	if err := writeNixModule(errorWriter{err: sentinel}, schema); !errors.Is(err, sentinel) {
		t.Fatalf("writeNixModule() error = %v, want %v", err, sentinel)
	}
	if err := writeNixModule(shortWriter{}, schema); !errors.Is(err, io.ErrShortWrite) {
		t.Fatalf("writeNixModule() short-write error = %v, want %v", err, io.ErrShortWrite)
	}
}

func TestWriteNixModuleValidatesArguments(t *testing.T) {
	t.Parallel()

	schema, err := analyzeSchema(reflect.TypeOf(fixtureRoot{}))
	if err != nil {
		t.Fatalf("analyzeSchema() error = %v", err)
	}

	if err := writeNixModule(nil, schema); err == nil {
		t.Error("writeNixModule(nil, schema) error = nil")
	}
	if err := writeNixModule(io.Discard, nil); err == nil {
		t.Error("writeNixModule(output, nil) error = nil")
	}
}

func TestGenerateAddsOperationContext(t *testing.T) {
	t.Parallel()

	sentinel := errors.New("write failed")
	err := generate(reflect.TypeOf(fixtureRoot{}), errorWriter{err: sentinel})
	if !errors.Is(err, sentinel) {
		t.Fatalf("generate() error = %v, want wrapped %v", err, sentinel)
	}
	if !strings.Contains(err.Error(), "write Nix module") {
		t.Fatalf("generate() error = %q, want operation context", err)
	}
}

type errorWriter struct {
	err error
}

func (w errorWriter) Write([]byte) (int, error) {
	return 0, w.err
}

type shortWriter struct{}

func (shortWriter) Write(value []byte) (int, error) {
	return len(value) - 1, nil
}
