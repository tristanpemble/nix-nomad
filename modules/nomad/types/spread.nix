{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;

  target = types.submodule {
    # TODO: nomad docs not clear here.. is this the block label?
    options.value = mkOption {
      type = types.str;
      default = "";
      description = ''
        Specifies a target value of the attribute from a spread stanza.
      '';
    };

    options.percent = mkOption {
      type = types.ints.between 0 100;
      default = 0;
      description = ''
        Specifies the percentage associated with the target value.
      '';
    };
  };
in
{
  options.attribute = mkOption {
    type = types.str;
    default = "";
    description = ''
      Specifies the name or reference of the attribute to use. This can be any of the Nomad interpolated values.
    '';
  };

  options.targets = mkOption {
    type = types.attrsOf target;
    default = {};
    description = ''
      Specifies one or more target percentages for each value of the attribute in the spread stanza. If this is omitted,
      Nomad will spread allocations evenly across all values of the attribute.
    '';
  };

  options.weight = mkOption {
    type = types.ints.between 0 100;
    default = 0;
    description = ''
      Specifies a weight for the spread stanza. The weight is used during scoring and must be an integer between 0 to
      100. Weights can be used when there is more than one spread or affinity stanza to express relative preference
      across them.
    '';
  };
}
