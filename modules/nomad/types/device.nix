{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.count = mkOption {
    type = types.ints.unsigned;
    default = 1;
    description = ''
      Specifies the number of instances of the given device that are required.
    '';
    example = {
      count = 3;
    };
  };

  options.constraints = mkOption {
    type = types.listOf nomad.constraint;
    default = [];
    description = ''
      A list to define additional constraints to restrict which devices are eligible.
    '';
    example = {
      constraints = [{
        attribute = "$${device.attr.memory}";
        operator = ">=";
        value = "2 GiB";
      }];
    };
  };

  options.affinities = mkOption {
    type = types.listOf nomad.affinity;
    default = [];
    description = ''
      A list to specify preferences for which devices get selected.
    '';
  };
}
