{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.limit = mkOption {
    type = types.ints.unsigned;
    default = 0;
    description = ''
      Restart task when a health check has failed limit times. For example 1 causes a restart on the first failure. The
      default, 0, disables health check based restarts. Failures must be consecutive. A single passing check will reset
      the count, so flapping services may not be restarted.
    '';
  };

  options.grace = mkOption {
    type = types.ints.unsigned;
    default = 1000000000;
    description = ''
      Duration to wait after a task starts or restarts before checking its health.
    '';
  };

  options.ignoreWarnings = mkOption {
    type = types.bool;
    default = false;
    description = ''
      By default checks with both critical and warning statuses are considered unhealthy. Setting ignore_warnings = true
      treats a warning status like passing and will not trigger a restart.
    '';
  };
}
