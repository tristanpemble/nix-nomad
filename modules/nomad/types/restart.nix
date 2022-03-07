{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.attempts = mkOption {
    type = types.nullOr types.ints.unsigned;
    default = null;
    description = ''
      Specifies the number of restarts allowed in the configured interval. Defaults vary by job type, see below for more
      information.
    '';
  };

  options.delay = mkOption {
    type = types.ints.unsigned;
    default = 15 * 1000000000;
    description = ''
       Specifies the duration to wait before restarting a task. This is specified using a label suffix like "30s" or
       "1h". A random jitter of up to 25% is added to the delay.
    '';
  };

  options.interval = mkOption {
    type = types.nullOr types.ints.unsigned;
    default = null;
    description = ''
      Specifies the duration which begins when the first task starts and ensures that only attempts number of restarts
      happens within it. If more than attempts number of failures happen, behavior is controlled by mode. This is
      specified using a label suffix like "30s" or "1h". Defaults vary by job type, see below for more information.
    '';
  };

  options.mode = mkOption {
    type = types.enum ["delay" "fail"];
    default = "fail";
    description = ''
       Controls the behavior when the task fails more than attempts times in an interval.
        - "delay" - Instructs the scheduler to delay the next restart until the next interval is reached.
        - "fail" - Instructs the scheduler to not attempt to restart the task on failure. This is the default behavior. This mode is useful for non-idempotent jobs which are unlikely to succeed after a few failures. Failed jobs will be restarted according to the reschedule stanza.
    '';
  };
}
