{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  # TODO: verify batch or sysbatch job type
  options.cron = mkOption {
    type = types.str;
    description = ''
      Specifies a cron expression configuring the interval to launch the job. In addition to cron-specific formats, this
      option also includes predefined expressions such as @daily or @weekly.
    '';
  };

  options.prohibitOverlap = mkOption {
    type = types.bool;
    default = false;
    description = ''
      Specifies if this job should wait until previous instances of this job have completed. This only applies to this
      job; it does not prevent other periodic jobs from running at the same time.
    '';
  };

  options.timeZone = mkOption {
    type = types.str;
    default = "UTC";
    description = ''
      Specifies the time zone to evaluate the next launch interval against. Daylight Saving Time affects scheduling, so
      please ensure the behavior below meets your needs. The time zone must be parsable by Golang's LoadLocation.
    '';
  };
}
