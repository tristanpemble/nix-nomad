{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.attribute = mkOption {
    type = types.str;
    default = "";
    description = ''
      Specifies the name or reference of the attribute to examine for the constraint. This can be any of the Nomad
      interpolated values.
    '';
  };

  options.operator = mkOption {
    type = types.enum ["=" "!=" ">" ">=" "<" "<=" "distinct_hosts" "distinct_property" "regexp" "set_contains"
      "version" "semver" "is_set" "is_not_set"];
    default = "=";
    description = ''
      Specifies the comparison operator. The ordering is compared lexically.
    '';
  };

  options.value = mkOption {
    type = types.str;
    default = "";
    description = ''
      Specifies the value to compare the attribute against using the specified operation. This can be a literal value,
      another attribute, or any Nomad interpolated values.
    '';
  };
}
