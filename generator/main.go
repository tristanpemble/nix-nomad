package main

import (
	"fmt"
	"io"
	"os"
	"reflect"

	"github.com/hashicorp/nomad/api"
)

func main() {
	if err := generate(reflect.TypeOf(api.Job{}), os.Stdout); err != nil {
		_, _ = fmt.Fprintf(os.Stderr, "nix-nomad generator: %v\n", err)
		os.Exit(1)
	}
}

func generate(root reflect.Type, output io.Writer) error {
	schema, err := analyzeSchema(root)
	if err != nil {
		return fmt.Errorf("analyze Nomad schema: %w", err)
	}

	if err := writeNixModule(output, schema); err != nil {
		return fmt.Errorf("write Nix module: %w", err)
	}

	return nil
}
