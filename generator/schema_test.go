package main

import (
	"reflect"
	"strings"
	"testing"

	"github.com/hashicorp/nomad/api"
)

type fixtureRoot struct {
	Tasks    []*fixtureTask    `hcl:"task,block"`
	Metadata map[string]string `hcl:"meta,optional"`
	Lock     *string           `hcl:",lock,optional"`
	Skipped  string            `hcl:"-"`
	Untagged string
}

type fixtureTask struct {
	Name  string         `hcl:",label"`
	Root  *fixtureRoot   `hcl:"root,block"`
	Steps []*fixtureStep `hcl:"step,block"`
}

type fixtureStep struct {
	Command string `hcl:"command"`
}

type duplicateFieldNames struct {
	First  string `hcl:"same_name"`
	Second string `hcl:"same_name"`
}

func TestAnalyzeSchemaCyclesAndCollections(t *testing.T) {
	t.Parallel()

	schema, err := analyzeSchema(reflect.TypeOf(fixtureRoot{}))
	if err != nil {
		t.Fatalf("analyzeSchema() error = %v", err)
	}

	if got, want := typeNames(schema), "FixtureRoot,FixtureStep,FixtureTask"; got != want {
		t.Fatalf("type order = %q, want %q", got, want)
	}

	root := requireType(t, schema, "FixtureRoot")
	task := requireType(t, schema, "FixtureTask")
	step := requireType(t, schema, "FixtureStep")

	if root.labeled {
		t.Error("FixtureRoot unexpectedly marked as labeled")
	}
	if !task.labeled {
		t.Error("FixtureTask was not marked as labeled")
	}

	tasks := requireField(t, root, "task")
	if got, want := tasks.typeExpr, "(nullOr (attrsOf FixtureTask))"; got != want {
		t.Errorf("FixtureRoot.task type = %q, want %q", got, want)
	}
	if tasks.defaultExpr != "null" {
		t.Errorf("FixtureRoot.task default = %q, want null", tasks.defaultExpr)
	}
	if tasks.container != goContainerSlice || tasks.collection != nixCollectionAttrs {
		t.Errorf("FixtureRoot.task collection = (%v, %v), want slice-backed attrs", tasks.container, tasks.collection)
	}
	if tasks.nestedType != task {
		t.Error("FixtureRoot.task does not reference FixtureTask")
	}

	rootField := requireField(t, task, "root")
	if rootField.nestedType != root {
		t.Error("FixtureTask.root does not close the cycle back to FixtureRoot")
	}

	steps := requireField(t, task, "steps")
	if got, want := steps.typeExpr, "(nullOr (listOf FixtureStep))"; got != want {
		t.Errorf("FixtureTask.steps type = %q, want %q", got, want)
	}
	if steps.collection != nixCollectionList || steps.nestedType != step {
		t.Error("FixtureTask.steps was not modeled as a list of FixtureStep")
	}

	lock := requireField(t, root, "lock")
	if got, want := lock.typeExpr, "(nullOr str)"; got != want {
		t.Errorf("FixtureRoot.lock type = %q, want %q", got, want)
	}
	if len(root.fields) != 3 {
		t.Errorf("FixtureRoot field count = %d, want 3; hcl:\"-\" and untagged fields must be skipped", len(root.fields))
	}
}

func TestAnalyzeSchemaRejectsInvalidInput(t *testing.T) {
	t.Parallel()

	for name, root := range map[string]reflect.Type{
		"nil":        nil,
		"non-struct": reflect.TypeOf(0),
		"anonymous":  reflect.TypeOf(struct{}{}),
	} {
		root := root
		t.Run(name, func(t *testing.T) {
			t.Parallel()
			if _, err := analyzeSchema(root); err == nil {
				t.Fatal("analyzeSchema() error = nil, want an input validation error")
			}
		})
	}
}

func TestAnalyzeSchemaRejectsDuplicateNixFieldNames(t *testing.T) {
	t.Parallel()

	_, err := analyzeSchema(reflect.TypeOf(duplicateFieldNames{}))
	if err == nil {
		t.Fatal("analyzeSchema() error = nil, want a duplicate field error")
	}
	if !strings.Contains(err.Error(), "both map to Nix option \"sameName\"") {
		t.Fatalf("analyzeSchema() error = %q, want duplicate Nix option context", err)
	}
}

func TestNomadJobIdentityFieldsAreLabels(t *testing.T) {
	t.Parallel()

	schema, err := analyzeSchema(reflect.TypeOf(api.Job{}))
	if err != nil {
		t.Fatalf("analyzeSchema() error = %v", err)
	}

	job := requireType(t, schema, "Job")
	if !job.labeled {
		t.Fatal("Job was not marked as labeled")
	}
	for _, name := range []string{"id", "name"} {
		if !requireField(t, job, name).label {
			t.Errorf("Job.%s was not marked as a label", name)
		}
	}
}

func TestAnalyzeSchemaPreservesNestedCollectionTypes(t *testing.T) {
	t.Parallel()

	schema, err := analyzeSchema(reflect.TypeOf(api.Job{}))
	if err != nil {
		t.Fatalf("analyzeSchema() error = %v", err)
	}

	header := requireField(t, requireType(t, schema, "ServiceCheck"), "header")
	if got, want := header.typeExpr, "(nullOr (attrsOf (listOf str)))"; got != want {
		t.Errorf("ServiceCheck.header type = %q, want %q", got, want)
	}
}

func typeNames(schema *nixSchema) string {
	names := make([]string, 0, len(schema.types))
	for _, typeModel := range schema.types {
		names = append(names, typeModel.name)
	}
	return strings.Join(names, ",")
}

func requireType(t *testing.T, schema *nixSchema, name string) *nixType {
	t.Helper()
	for _, typeModel := range schema.types {
		if typeModel.name == name {
			return typeModel
		}
	}
	t.Fatalf("schema does not contain type %q", name)
	return nil
}

func requireField(t *testing.T, typeModel *nixType, name string) *nixField {
	t.Helper()
	for i := range typeModel.fields {
		if typeModel.fields[i].name == name {
			return &typeModel.fields[i]
		}
	}
	t.Fatalf("type %s does not contain field %q", typeModel.name, name)
	return nil
}
