{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.type = mkOption {
    type = types.enum ["host" "csi"];
    description = ''
      Specifies the type of a given volume. The valid volume types are "host" and "csi".
    '';
  };

  options.source = mkOption {
    type = types.str;
    description = ''
      The name of the volume to request. When using host_volume's this should match the published name of the host
      volume. When using csi volumes, this should match the ID of the registered volume.
    '';
  };

  options.readOnly = mkOption {
    type = types.bool;
    default = false;
    description = ''
      Specifies that the group only requires read only access to a volume and is used as the default value for the
      volume_mount -> read_only configuration. This value is also used for validating host_volume ACLs and for
      scheduling when a matching host_volume requires read_only usage.
    '';
  };

  # TODO: CSI volume options
}
