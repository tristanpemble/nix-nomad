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
	if isNomadAPIType(typeModel, "NetworkResource") {
		return renderNetworkResourceToJSON(typeModel)
	}
	return renderGenericToJSON(typeModel)
}

func renderGenericToJSON(typeModel *nixType) string {
	var output strings.Builder
	output.WriteString("attrs: if !(builtins.isAttrs attrs) then null else (\n")
	output.WriteString("  {}\n")
	for _, field := range typeModel.fields {
		output.WriteString(fmt.Sprintf("  // (%s)\n", renderFieldToJSON(field)))
	}
	output.WriteString(")")
	return output.String()
}

func renderNetworkResourceToJSON(typeModel *nixType) string {
	var output strings.Builder
	output.WriteString(`attrs: if !(builtins.isAttrs attrs) then null else (
  let
    ports = if attrs ? port && builtins.isAttrs attrs.port then attrs.port else {};
    legacyReservedPorts = if attrs ? reservedPorts && builtins.isAttrs attrs.reservedPorts then attrs.reservedPorts else {};
    duplicateLabels = builtins.attrNames (builtins.intersectAttrs ports legacyReservedPorts);
    invalidReservedLabels = builtins.attrNames (filterAttrs (_: port: (port.static or null) == null) legacyReservedPorts);
    dynamicPortAttrs = filterAttrs (_: port: (port.static or null) == null) ports;
    reservedPortAttrs = filterAttrs (_: port: (port.static or null) != null) ports;
    dynamicPorts = mapAttrsToList (_: Port.toJSON) dynamicPortAttrs;
    reservedPorts = mapAttrsToList (_: Port.toJSON) (reservedPortAttrs // legacyReservedPorts);
  in if duplicateLabels != [] then
    throw ("NetworkResource port labels are defined in both port and reservedPorts: " + concatStringsSep ", " duplicateLabels)
  else if invalidReservedLabels != [] then
    throw ("NetworkResource reservedPorts entries must set static: " + concatStringsSep ", " invalidReservedLabels)
  else (
    {}
`)
	for _, field := range typeModel.fields {
		if isNetworkResourcePortField(field) {
			continue
		}
		output.WriteString(fmt.Sprintf("    // (%s)\n", renderFieldToJSON(field)))
	}
	output.WriteString(`    // (if dynamicPorts != [] then { DynamicPorts = dynamicPorts; } else {})
    // (if reservedPorts != [] then { ReservedPorts = reservedPorts; } else {})
  )
)`)
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
	if isNomadAPIType(typeModel, "NetworkResource") {
		return renderNetworkResourceFromJSON(typeModel)
	}
	return renderGenericFromJSON(typeModel)
}

func renderGenericFromJSON(typeModel *nixType) string {
	var output strings.Builder
	output.WriteString("attrs: (\n")
	output.WriteString("  {}\n")
	for _, field := range typeModel.fields {
		output.WriteString(fmt.Sprintf("  // (%s)\n", renderFieldFromJSON(field)))
	}
	output.WriteString(")")
	return output.String()
}

func renderNetworkResourceFromJSON(typeModel *nixType) string {
	var output strings.Builder
	output.WriteString(`attrs: (
  let
    hasDynamicPorts = attrs ? DynamicPorts && builtins.isList attrs.DynamicPorts;
    hasReservedPorts = attrs ? ReservedPorts && builtins.isList attrs.ReservedPorts;
    dynamicPortValues = if hasDynamicPorts then attrs.DynamicPorts else [];
    reservedPortValues = if hasReservedPorts then attrs.ReservedPorts else [];
    dynamicPorts = builtins.listToAttrs (builtins.map (v: nameValuePair v.Label ((Port.fromJSON v) // { static = null; })) dynamicPortValues);
    reservedPorts = builtins.listToAttrs (builtins.map (v: nameValuePair v.Label (Port.fromJSON v)) reservedPortValues);
    duplicateLabels = builtins.attrNames (builtins.intersectAttrs dynamicPorts reservedPorts);
  in if duplicateLabels != [] then
    throw ("Nomad NetworkResource JSON defines port labels in both DynamicPorts and ReservedPorts: " + concatStringsSep ", " duplicateLabels)
  else (
    {}
`)
	for _, field := range typeModel.fields {
		if isNetworkResourcePortField(field) {
			continue
		}
		output.WriteString(fmt.Sprintf("    // (%s)\n", renderFieldFromJSON(field)))
	}
	output.WriteString(`    // (if hasDynamicPorts || hasReservedPorts then { port = dynamicPorts // reservedPorts; } else {})
  )
)`)
	return output.String()
}

func isNomadAPIType(typeModel *nixType, name string) bool {
	return typeModel.goType.PkgPath() == "github.com/hashicorp/nomad/api" && typeModel.goType.Name() == name
}

func isNetworkResourcePortField(field nixField) bool {
	return field.goName == "DynamicPorts" || field.goName == "ReservedPorts"
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
