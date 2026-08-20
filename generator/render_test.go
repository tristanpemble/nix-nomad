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
