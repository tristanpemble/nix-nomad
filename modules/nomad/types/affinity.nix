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
      Specifies the name or reference of the attribute to examine for the affinity. This can be any of the Nomad
      interpolated values.
    '';
  };

  options.operator = mkOption {
    type = types.enum ["=" "!=" ">" ">=" "<" "<=" "regexp" "set_contains_all" "set_contains_any" "version"];
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

  options.weight = mkOption {
    type = types.ints.between (-100) 100;
    default = 50;
    description = ''
      Specifies a weight for the affinity. The weight is used during scoring and must be an integer between -100 to 100.
      Negative weights act as anti affinities, causing nodes that match them to be scored lower. Weights can be used
      when there is more than one affinity to express relative preference across them.
    '';
  };
}
