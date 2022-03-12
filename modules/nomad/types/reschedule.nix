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
      Specifies the number of reschedule attempts allowed in the configured interval. Defaults vary by job type.
    '';
  };

  options.interval = mkOption {
    type = types.nullOr types.ints.unsigned;
    default = null;
    description = ''
      Specifies the sliding window which begins when the first reschedule attempt starts and ensures that only attempts
      number of reschedule happen within it. If more than attempts number of failures happen with this interval, Nomad
      will not reschedule any more. Specified in nanoseconds.
    '';
  };

  options.delay = mkOption {
    type = types.nullOr (types.addCheck types.ints.unsigned (x: x >= 5000000000) // {
      name = "intAtLeast";
      description = "interval must be greater than or equal to 5s";
    });
    default = null;
    description = ''
       Specifies the duration to wait before attempting to reschedule a failed task. This is specified using a label
       suffix like "30s" or "1h". Delay cannot be less than 5 seconds. Specified in nanoseconds.
    '';
  };

  options.delayFunction = mkOption {
    type = types.nullOr (types.enum ["constant" "exponential" "fibonacci"]);
    default = null;
    description = ''
      Specifies the function that is used to calculate subsequent reschedule delays. The initial delay is specified by
      the delay parameter. delay_function has three possible values which are described below:
        - constant - The delay between reschedule attempts stays constant at the delay value.
        - exponential - The delay between reschedule attempts doubles.
        - fibonacci - The delay between reschedule attempts is calculated by adding the two most recent delays applied.
          For example if delay is set to 5 seconds, the next five reschedule attempts will be delayed by 5 seconds, 5
          seconds, 10 seconds, 15 seconds, and 25 seconds respectively.
    '';
  };

  options.maxDelay = mkOption {
    type = types.nullOr types.ints.unsigned;
    default = null;
    description = ''
      An upper bound on the delay beyond which it will not increase. This parameter is used when delay_function is
      exponential or fibonacci, and is ignored when constant delay is used.
    '';
  };

  options.unlimited = mkOption {
    type = types.nullOr types.bool;
    default = null;
    description = ''
     Enables unlimited reschedule attempts. If this is set to true the attempts and interval fields are not used.
    '';
  };
}
