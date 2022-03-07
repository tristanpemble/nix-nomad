{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.min = mkOption {
    type = types.nullOr types.ints.unsigned;
    default = null;
    description = ''
      The minimum acceptable count for the task group. This should be honored by the external autoscaler. It will also
      be honored by Nomad during job updates and scaling operations. Defaults to the specified task group count.
    '';
  };

  options.max = mkOption {
    type = types.ints.unsigned;
    description = ''
      The maximum acceptable count for the task group. This should be honored by the external autoscaler. It will also
      be honored by Nomad during job updates and scaling operations.
    '';
  };

  options.enabled = mkOption {
    type = types.bool;
    default = false;
    description = ''
      Whether the scaling policy is enabled. This is intended to allow temporarily disabling an autoscaling policy, and
      should be honored by the external autoscaler.
    '';
  };

  options.policy = mkOption {
    type = types.attrsOf types.anything;
    default = {};
    description = ''
      The autoscaling policy. This is opaque to Nomad, consumed and parsed only by the external autoscaler. Therefore,
      its contents are specific to the autoscaler; consult the Nomad Autoscaler documentation for more details.
    '';
  };
}
