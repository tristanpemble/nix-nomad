{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.volume = mkOption {
    type = types.str;
    description = ''
      Specifies the group volume that the mount is going to access.
    '';
  };

  options.destination = mkOption {
    type = types.str;
    description = ''
       Specifies where the volume should be mounted inside the task's allocation.
    '';
  };

  options.readOnly = mkOption {
    type = types.bool;
    default = false;
    description = ''
      When a group volume is writeable, you may specify that it is read_only on a per mount level using the read_only
      option here.
    '';
  };
}
