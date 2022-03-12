{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.maxParallel = mkOption {
    type = types.ints.unsigned;
    default = 1;
    description = ''
      Specifies the number of allocations that can be migrated at the same time. This number must be less than the total
      count for the group as count - max_parallel will be left running during migrations.
    '';
  };

  options.healthCheck = mkOption {
    type = types.enum ["checks" "task_states"];
    default = "checks";
    description = ''
      Specifies the mechanism in which allocations health is determined. The potential values are:
        - "checks" - Specifies that the allocation should be considered healthy when all of its tasks are running and
          their associated checks are healthy, and unhealthy if any of the tasks fail or not all checks become healthy.
          This is a superset of "task_states" mode.
        - "task_states" - Specifies that the allocation should be considered healthy when all its tasks are running and
          unhealthy if tasks fail.
    '';
  };

  options.minHealthyTime = mkOption {
    type = types.ints.unsigned;
    default = 10000000000;
    description = ''
      Specifies the minimum time the allocation must be in the healthy state before it is marked as healthy and unblocks
      further allocations from being migrated. This is specified in nanoseconds.
    '';
  };

  options.healthyDeadline = mkOption {
    type = types.ints.unsigned;
    default = 300000000000;
    description = ''
      Specifies the minimum time the allocation must be in the healthy state before it is marked as healthy and unblocks
      further allocations from being migrated. This is specified in nanoseconds.
    '';
  };
}
