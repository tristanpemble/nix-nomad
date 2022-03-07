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
      Specifies the number of allocations within a task group that can be updated at the same time. The task groups
      themselves are updated in parallel. A value of 0 specifies that the allocation should use forced updates instead
      of deployments.
    '';
  };

  options.healthCheck = mkOption {
    type = types.enum ["checks" "task_states" "manual"];
    default = "checks";
    description = ''
      Specifies the mechanism in which allocations health is determined. The potential values are:
        - "checks" - Specifies that the allocation should be considered healthy when all of its tasks are running and
          their associated checks are healthy, and unhealthy if any of the tasks fail or not all checks become healthy.
          This is a superset of "task_states" mode.
        - "task_states" - Specifies that the allocation should be considered healthy when all its tasks are running and
          unhealthy if tasks fail.
        - "manual" - Specifies that Nomad should not automatically determine health and that the operator will specify
          allocation health using the HTTP API.
    '';
  };

  options.minHealthyTime = mkOption {
    type = types.ints.unsigned;
    default = 10*1000000000;
    description = ''
      Specifies the minimum time the allocation must be in the healthy state before it is marked as healthy and unblocks
      further allocations from being updated. This is specified in nanoseconds.
    '';
  };

  options.healthyDeadline = mkOption {
    type = types.ints.unsigned;
    default = 5*60*1000000000;
    description = ''
      Specifies the deadline in which the allocation must be marked as healthy after which the allocation is
      automatically transitioned to unhealthy. This is specified in nanoseconds. If progress_deadline is non-zero, it
      must be greater than healthy_deadline. Otherwise the progress_deadline may fail a deployment before an allocation
      reaches its healthy_deadline.
    '';
  };

  options.progressDeadline = mkOption {
    type = types.ints.unsigned;
    default = 10*60*1000000000;
    description = ''
      Specifies the deadline in which an allocation must be marked as healthy. The deadline begins when the first
      allocation for the deployment is created and is reset whenever an allocation as part of the deployment transitions
      to a healthy state or when a deployment is manually promoted. If no allocation transitions to the healthy state
      before the progress deadline, the deployment is marked as failed. If the progress_deadline is set to 0, the first
      allocation to be marked as unhealthy causes the deployment to fail. This is specified in nanoseconds.
    '';
  };

  options.autoRevert = mkOption {
    type = types.bool;
    default = false;
    description = ''
      Specifies if the job should auto-revert to the last stable job on deployment failure. A job is marked as stable if
      all the allocations as part of its deployment were marked healthy.
    '';
  };

  options.autoPromote = mkOption {
    type = types.bool;
    default = false;
    description = ''
      Specifies if the job should auto-promote to the canary version when all canaries become healthy during a
      deployment. Defaults to false which means canaries must be manually updated with the nomad deployment promote
      command. If a job has multiple task groups, all must be set to auto_promote = true in order for the deployment to
      be promoted automatically.
    '';
  };

  options.canary = mkOption {
    type = types.ints.unsigned;
    default = 0;
    description = ''
      Specifies that changes to the job that would result in destructive updates should create the specified number of
      canaries without stopping any previous allocations. Once the operator determines the canaries are healthy, they
      can be promoted which unblocks a rolling update of the remaining allocations at a rate of max_parallel. Canary
      deployments cannot be used with CSI volumes when per_alloc = true.
    '';
  };

  options.stagger = mkOption {
    type = types.ints.unsigned;
    default = 30*1000000000;
    description = ''
      Specifies the delay between each set of max_parallel updates when updating system jobs. This setting no longer
      applies to service jobs which use deployments.
    '';
  };
}
