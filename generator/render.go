package main

import (
	"fmt"
	"io"
	"strings"
)

func writeNixModule(output io.Writer, schema *nixSchema) error {
	if output == nil {
		return fmt.Errorf("output writer is nil")
	}
	if schema == nil {
		return fmt.Errorf("schema is nil")
	}

	generated := renderNixModule(schema)
	written, err := io.WriteString(output, generated)
	if err != nil {
		return err
	}
	if written != len(generated) {
		return io.ErrShortWrite
	}
	return nil
}

func renderNixModule(schema *nixSchema) string {
	var output strings.Builder
	output.WriteString("{ config, lib, ... }:\n\n")
	output.WriteString("{\n")

	for _, typeModel := range schema.types {
		output.WriteString(fmt.Sprintf(
			"  _module.types.%s = with lib; with config._module.types; %s;\n",
			typeModel.name,
			strings.TrimSpace(indent(renderType(typeModel), 2)),
		))
	}
	for _, typeModel := range schema.types {
		output.WriteString(fmt.Sprintf("\n  # Convert a %s Nix module into a JSON object.\n", typeModel.name))
		output.WriteString(fmt.Sprintf(
			"  _module.transformers.%s.toJSON = with lib; with config._module.transformers; %s;\n",
			typeModel.name,
			strings.TrimSpace(indent(renderToJSON(typeModel), 2)),
		))
		output.WriteString(fmt.Sprintf("\n  # Convert a %s JSON object into a Nix module.\n", typeModel.name))
		output.WriteString(fmt.Sprintf(
			"  _module.transformers.%s.fromJSON = with lib; with config._module.transformers; %s;\n",
			typeModel.name,
			strings.TrimSpace(indent(renderFromJSON(typeModel), 2)),
		))
	}

	output.WriteString("}\n")
	return output.String()
}

func renderType(typeModel *nixType) string {
	var output strings.Builder
	if typeModel.labeled {
		output.WriteString("with lib.types; submodule ({ name, ... }: {\n")
	} else {
		output.WriteString("with lib.types; submodule ({\n")
	}

	for _, field := range typeModel.fields {
		output.WriteString(fmt.Sprintf("  options.%s = mkOption {\n", field.name))
		output.WriteString(fmt.Sprintf("    type = %s;\n", field.typeExpr))
		if field.label {
			output.WriteString("    default = name;\n")
			output.WriteString("    internal = true;\n")
			output.WriteString("    visible = false;\n")
		} else if field.defaultExpr != "" {
			output.WriteString(fmt.Sprintf("    default = %s;\n", field.defaultExpr))
		}
		output.WriteString("  };\n")
	}
	output.WriteString("})")
	return output.String()
}

func renderToJSON(typeModel *nixType) string {
	var output strings.Builder
	output.WriteString("attrs: if !(builtins.isAttrs attrs) then null else (\n")
	output.WriteString("  {}\n")
	for _, field := range typeModel.fields {
		output.WriteString(fmt.Sprintf("  // (%s)\n", renderFieldToJSON(field)))
	}
	output.WriteString(")")
	return output.String()
}

func renderFieldToJSON(field nixField) string {
	if field.referencesLabeledType() && field.container == goContainerSlice {
		return fmt.Sprintf(
			"if attrs ? %s && builtins.isAttrs attrs.%s then { %s = mapAttrsToList (_: %s.toJSON) attrs.%s; } else {}",
			field.name,
			field.name,
			field.goName,
			field.nestedType.name,
			field.name,
		)
	}

	if field.referencesLabeledType() && field.container == goContainerMap {
		return fmt.Sprintf(
			"if attrs ? %s && builtins.isAttrs attrs.%s then { %s = mapAttrs (_: %s.toJSON) attrs.%s; } else {}",
			field.name,
			field.name,
			field.goName,
			field.nestedType.name,
			field.name,
		)
	}

	if field.collection == nixCollectionList && field.nestedType != nil {
		return fmt.Sprintf(
			"if attrs ? %s && builtins.isList attrs.%s then { %s = builtins.map %s.toJSON attrs.%s; } else {}",
			field.name,
			field.name,
			field.goName,
			field.nestedType.name,
			field.name,
		)
	}

	if field.nestedType != nil {
		return fmt.Sprintf(
			"if attrs ? %s && attrs.%s != null then { %s = %s.toJSON attrs.%s; } else {}",
			field.name,
			field.name,
			field.goName,
			field.nestedType.name,
			field.name,
		)
	}

	return fmt.Sprintf(
		"if attrs ? %s && attrs.%s != null then { %s = attrs.%s; } else {}",
		field.name,
		field.name,
		field.goName,
		field.name,
	)
}

func renderFromJSON(typeModel *nixType) string {
	var output strings.Builder
	output.WriteString("attrs: (\n")
	output.WriteString("  {}\n")
	for _, field := range typeModel.fields {
		output.WriteString(fmt.Sprintf("  // (%s)\n", renderFieldFromJSON(field)))
	}
	output.WriteString(")")
	return output.String()
}

func renderFieldFromJSON(field nixField) string {
	if field.referencesLabeledType() {
		label := field.nestedType.labelField()
		return fmt.Sprintf(
			"if attrs ? %s && builtins.isList attrs.%s then { %s = builtins.listToAttrs (builtins.map (v: nameValuePair v.%s (%s.fromJSON v)) attrs.%s); } else {}",
			field.goName,
			field.goName,
			field.name,
			label.goName,
			field.nestedType.name,
			field.goName,
		)
	}

	if field.collection == nixCollectionList && field.nestedType != nil {
		return fmt.Sprintf(
			"if attrs ? %s && builtins.isList attrs.%s then { %s = builtins.map %s.fromJSON attrs.%s; } else {}",
			field.goName,
			field.goName,
			field.name,
			field.nestedType.name,
			field.goName,
		)
	}

	if field.nestedType != nil {
		return fmt.Sprintf(
			"if attrs ? %s && attrs.%s != null then { %s = %s.fromJSON attrs.%s; } else {}",
			field.goName,
			field.goName,
			field.name,
			field.nestedType.name,
			field.goName,
		)
	}

	return fmt.Sprintf(
		"if attrs ? %s && attrs.%s != null then { %s = attrs.%s; } else {}",
		field.goName,
		field.goName,
		field.name,
		field.goName,
	)
}

func indent(value string, spaces int) string {
	prefix := strings.Repeat(" ", spaces)
	lines := strings.Split(value, "\n")
	for i := range lines {
		lines[i] = prefix + lines[i]
	}
	return strings.Join(lines, "\n")
}
