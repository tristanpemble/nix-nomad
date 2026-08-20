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
		if field.deprecationMessage != "" {
			message := fmt.Sprintf(
				"The option %s.%s is deprecated. %s",
				typeModel.name,
				field.name,
				field.deprecationMessage,
			)
			output.WriteString(fmt.Sprintf(
				"    apply = value: warnIf (value != null) %q value;\n",
				message,
			))
		}
		if field.label {
			output.WriteString("    default = name;\n")
			output.WriteString("    internal = true;\n")
			output.WriteString("    visible = false;\n")
		} else if field.defaultExpr != "" {
			output.WriteString(fmt.Sprintf("    default = %s;\n", field.defaultExpr))
		}
		if field.deprecationMessage != "" {
			output.WriteString(fmt.Sprintf("    description = %q;\n", "Deprecated: "+field.deprecationMessage))
		}
		output.WriteString("  };\n")
	}
	output.WriteString(renderVirtualOptions(typeModel))
	output.WriteString("})")
	return output.String()
}

func renderVirtualOptions(typeModel *nixType) string {
	switch {
	case isNomadAPIType(typeModel, "Job"):
		return `  options.secret = mkOption {
    type = (nullOr (attrsOf Secret));
    default = null;
    description = "Secrets that are added to each task in the job. Task and group secrets are also kept.";
  };
  options.vault = mkOption {
    type = (nullOr Vault);
    default = null;
    description = "Vault configuration for each task in the job. A group or task vault block overrides this value.";
  };
`
	case isNomadAPIType(typeModel, "TaskGroup"):
		return `  options.secret = mkOption {
    type = (nullOr (attrsOf Secret));
    default = null;
    description = "Secrets that are added to each task in the group. Task secrets are also kept.";
  };
  options.vault = mkOption {
    type = (nullOr Vault);
    default = null;
    description = "Vault configuration for each task in the group. A task vault block overrides this value.";
  };
`
	case isNomadAPIType(typeModel, "Task"):
		return `  options.scaling = mkOption {
    type = (nullOr (submodule ({
      options.cpu = mkOption {
        type = (nullOr ScalingPolicy);
        default = null;
        description = "CPU scaling policy. It is emitted with the Nomad type vertical_cpu.";
      };
      options.mem = mkOption {
        type = (nullOr ScalingPolicy);
        default = null;
        description = "Memory scaling policy. It is emitted with the Nomad type vertical_mem.";
      };
    })));
    default = null;
    description = "Task scaling policies, indexed by the HCL labels cpu and mem.";
  };
`
	default:
		return ""
	}
}

func renderToJSON(typeModel *nixType) string {
	switch {
	case isNomadAPIType(typeModel, "NetworkResource"):
		return renderNetworkResourceToJSON(typeModel)
	case isNomadAPIType(typeModel, "PeriodicConfig"):
		return renderPeriodicConfigToJSON(typeModel)
	case isNomadAPIType(typeModel, "Task"):
		return renderTaskToJSON(typeModel)
	case isNomadAPIType(typeModel, "TaskGroup"):
		return renderTaskGroupToJSON(typeModel)
	case isNomadAPIType(typeModel, "Job"):
		return renderJobToJSON(typeModel)
	default:
		return renderGenericToJSON(typeModel)
	}
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

func renderPeriodicConfigToJSON(typeModel *nixType) string {
	var output strings.Builder
	output.WriteString(`attrs: if !(builtins.isAttrs attrs) then null else (
  let
    hasCron = attrs ? cron && attrs.cron != null;
    hasCrons = attrs ? crons && attrs.crons != null;
  in if hasCron && hasCrons then
    throw "PeriodicConfig cannot set both cron and crons"
  else (
    {}
`)
	for _, field := range typeModel.fields {
		output.WriteString(fmt.Sprintf("    // (%s)\n", renderFieldToJSON(field)))
	}
	output.WriteString(`    // (if hasCron || hasCrons then { SpecType = "cron"; } else {})
  )
)`)
	return output.String()
}

func renderTaskToJSON(typeModel *nixType) string {
	var output strings.Builder
	output.WriteString(`attrs: if !(builtins.isAttrs attrs) then null else (
  let
    identityValues = if attrs ? identities && builtins.isList attrs.identities then attrs.identities else [];
    isDefaultIdentity = identity:
      let identityName = identity.name or null;
      in identityName == null || identityName == "" || identityName == "default";
    defaultIdentities = builtins.filter isDefaultIdentity identityValues;
    namedIdentities = builtins.filter (identity: !(isDefaultIdentity identity)) identityValues;

    legacyScalings = if attrs ? scalings && builtins.isList attrs.scalings then attrs.scalings else [];
    legacyCPUPolicies = builtins.filter (policy: (policy.type or null) == "vertical_cpu") legacyScalings;
    legacyMemPolicies = builtins.filter (policy: (policy.type or null) == "vertical_mem") legacyScalings;
    cpuScaling = if attrs ? scaling && builtins.isAttrs attrs.scaling && attrs.scaling ? cpu then attrs.scaling.cpu else null;
    memScaling = if attrs ? scaling && builtins.isAttrs attrs.scaling && attrs.scaling ? mem then attrs.scaling.mem else null;
    cpuScalingType = if cpuScaling == null then null else (cpuScaling.type or null);
    memScalingType = if memScaling == null then null else (memScaling.type or null);
    cpuPolicy = if cpuScaling == null then null else ScalingPolicy.toJSON (cpuScaling // { type = "vertical_cpu"; });
    memPolicy = if memScaling == null then null else ScalingPolicy.toJSON (memScaling // { type = "vertical_mem"; });
    scalingPolicies =
      builtins.map ScalingPolicy.toJSON legacyScalings
      ++ optional (cpuPolicy != null) cpuPolicy
      ++ optional (memPolicy != null) memPolicy;

    inheritedVault = attrs.__nixNomadInheritedVault or null;
    effectiveVault = if attrs ? vault && attrs.vault != null then attrs.vault else inheritedVault;
    inheritedSecretScopes = attrs.__nixNomadInheritedSecretScopes or [];
    taskSecrets = if attrs ? secret && builtins.isAttrs attrs.secret then mapAttrsToList (_: Secret.toJSON) attrs.secret else [];
    inheritedSecrets = concatMap (scope: if builtins.isAttrs scope then mapAttrsToList (_: Secret.toJSON) scope else []) inheritedSecretScopes;
    secrets = taskSecrets ++ inheritedSecrets;
  in if builtins.length defaultIdentities > 1 then
    throw "Task can define only one default identity"
  else if builtins.length legacyCPUPolicies > 1 then
    throw "Task can define only one CPU scaling policy"
  else if builtins.length legacyMemPolicies > 1 then
    throw "Task can define only one memory scaling policy"
  else if cpuScaling != null && legacyCPUPolicies != [] then
    throw "Task CPU scaling is defined in both scaling.cpu and scalings"
  else if memScaling != null && legacyMemPolicies != [] then
    throw "Task memory scaling is defined in both scaling.mem and scalings"
  else if cpuScalingType != null && cpuScalingType != "vertical_cpu" then
    throw "Task scaling.cpu cannot set a type other than vertical_cpu"
  else if memScalingType != null && memScalingType != "vertical_mem" then
    throw "Task scaling.mem cannot set a type other than vertical_mem"
  else (
    {}
`)
	for _, field := range typeModel.fields {
		if isTaskSpecialField(field) {
			continue
		}
		output.WriteString(fmt.Sprintf("    // (%s)\n", renderFieldToJSON(field)))
	}
	output.WriteString(`    // (if defaultIdentities != [] then { Identity = WorkloadIdentity.toJSON (builtins.head defaultIdentities); } else {})
    // (if namedIdentities != [] then { Identities = builtins.map WorkloadIdentity.toJSON namedIdentities; } else {})
    // (if scalingPolicies != [] then { ScalingPolicies = scalingPolicies; } else {})
    // (if secrets != [] then { Secrets = secrets; } else {})
    // (if effectiveVault != null then { Vault = Vault.toJSON effectiveVault; } else {})
  )
)`)
	return output.String()
}

func renderTaskGroupToJSON(typeModel *nixType) string {
	var output strings.Builder
	output.WriteString(`attrs: if !(builtins.isAttrs attrs) then null else (
  let
    inheritedVault = attrs.__nixNomadInheritedVault or null;
    effectiveVault = if attrs ? vault && attrs.vault != null then attrs.vault else inheritedVault;
    inheritedSecretScopes = attrs.__nixNomadInheritedSecretScopes or [];
    secretScopes = (if attrs ? secret && builtins.isAttrs attrs.secret then [ attrs.secret ] else []) ++ inheritedSecretScopes;
  in (
    {}
`)
	for _, field := range typeModel.fields {
		if field.goName == "Tasks" {
			continue
		}
		output.WriteString(fmt.Sprintf("    // (%s)\n", renderFieldToJSON(field)))
	}
	output.WriteString(`    // (if attrs ? task && builtins.isAttrs attrs.task then {
      Tasks = mapAttrsToList (_: task: Task.toJSON (task // {
        __nixNomadInheritedVault = effectiveVault;
        __nixNomadInheritedSecretScopes = secretScopes;
      })) attrs.task;
    } else {})
  )
)`)
	return output.String()
}

func renderJobToJSON(typeModel *nixType) string {
	var output strings.Builder
	output.WriteString(`attrs: if !(builtins.isAttrs attrs) then null else (
  let
    jobVault = if attrs ? vault && attrs.vault != null then attrs.vault else null;
    jobSecretScopes = if attrs ? secret && builtins.isAttrs attrs.secret then [ attrs.secret ] else [];
  in (
    {}
`)
	for _, field := range typeModel.fields {
		if field.goName == "TaskGroups" {
			continue
		}
		output.WriteString(fmt.Sprintf("    // (%s)\n", renderFieldToJSON(field)))
	}
	output.WriteString(`    // (if attrs ? group && builtins.isAttrs attrs.group then {
      TaskGroups = mapAttrsToList (_: group: TaskGroup.toJSON (group // {
        __nixNomadInheritedVault = jobVault;
        __nixNomadInheritedSecretScopes = jobSecretScopes;
      })) attrs.group;
    } else {})
  )
)`)
	return output.String()
}

func isTaskSpecialField(field nixField) bool {
	switch field.goName {
	case "Identities", "ScalingPolicies", "Secrets", "Vault":
		return true
	default:
		return false
	}
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
	switch {
	case isNomadAPIType(typeModel, "NetworkResource"):
		return renderNetworkResourceFromJSON(typeModel)
	case isNomadAPIType(typeModel, "Task"):
		return renderTaskFromJSON(typeModel)
	default:
		return renderGenericFromJSON(typeModel)
	}
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

func renderTaskFromJSON(typeModel *nixType) string {
	var output strings.Builder
	output.WriteString(`attrs: if !(builtins.isAttrs attrs) then {} else (
  let
    hasIdentity = attrs ? Identity && attrs.Identity != null;
    hasIdentities = attrs ? Identities && builtins.isList attrs.Identities;
    identities =
      optional hasIdentity (WorkloadIdentity.fromJSON attrs.Identity)
      ++ (if hasIdentities then builtins.map WorkloadIdentity.fromJSON attrs.Identities else []);

    hasScalingPolicies = attrs ? ScalingPolicies && builtins.isList attrs.ScalingPolicies;
    scalingPolicies = if hasScalingPolicies then builtins.map ScalingPolicy.fromJSON attrs.ScalingPolicies else [];
    cpuPolicies = builtins.filter (policy: (policy.type or null) == "vertical_cpu") scalingPolicies;
    memPolicies = builtins.filter (policy: (policy.type or null) == "vertical_mem") scalingPolicies;
    compatibilityPolicies = builtins.filter (policy:
      let policyType = policy.type or null;
      in policyType != "vertical_cpu" && policyType != "vertical_mem"
    ) scalingPolicies;
    cpuPolicy = if cpuPolicies == [] then null else removeAttrs (builtins.head cpuPolicies) [ "type" ];
    memPolicy = if memPolicies == [] then null else removeAttrs (builtins.head memPolicies) [ "type" ];
  in if builtins.length cpuPolicies > 1 then
    throw "Nomad Task JSON defines more than one vertical_cpu scaling policy"
  else if builtins.length memPolicies > 1 then
    throw "Nomad Task JSON defines more than one vertical_mem scaling policy"
  else (
    {}
`)
	for _, field := range typeModel.fields {
		if field.goName == "Identities" || field.goName == "ScalingPolicies" {
			continue
		}
		output.WriteString(fmt.Sprintf("    // (%s)\n", renderFieldFromJSON(field)))
	}
	output.WriteString(`    // (if hasIdentity || hasIdentities then { inherit identities; } else {})
    // (if cpuPolicy != null || memPolicy != null then {
      scaling = optionalAttrs (cpuPolicy != null) { cpu = cpuPolicy; }
        // optionalAttrs (memPolicy != null) { mem = memPolicy; };
    } else {})
    // (if compatibilityPolicies != [] then { scalings = compatibilityPolicies; } else {})
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
	if field.referencesLabeledType() && field.container == goContainerMap {
		return fmt.Sprintf(
			"if attrs ? %s && builtins.isAttrs attrs.%s then { %s = mapAttrs (_: %s.fromJSON) attrs.%s; } else {}",
			field.goName,
			field.goName,
			field.name,
			field.nestedType.name,
			field.goName,
		)
	}

	if field.referencesLabeledType() && field.container == goContainerSlice {
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
