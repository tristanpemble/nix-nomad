{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;

  consul = types.submodule {
    options.namespace = mkOption {
      type = types.str;
      default = "";
      description = ''
        The Consul namespace in which group and task-level services within the group will be registered. Use of template
        to access Consul KV will read from the specified Consul namespace. Specifying namespace takes precedence over
        the -consul-namespace command line argument in job run.
      '';
    };
  };
in
{
  options.constraints = mkOption {
    type = types.listOf nomad.constraint;
    default = [];
    description = ''
      A list to define additional constraints where a task group can be run.
    '';
    example = {
      constraints = [{
        operator = "distinct_hosts";
        value = "true";
      }];
    };
  };

  options.affinities = mkOption {
    type = types.listOf nomad.affinity;
    default = [];
    description = ''
      A list to define placement preferences on nodes where a task group can be run.
    '';
    example = {

    };
  };

  options.spreads = mkOption {
    type = types.listOf nomad.spread;
    default = [];
    description = ''
      A list to define allocation spread across attributes.
    '';
    example = {

    };
  };

  options.count = mkOption {
    type = types.ints.unsigned;
    default = 1;
    description = ''
      Specifies the number of the task groups that should be running. Must be non-negative, defaults to one.
    '';
    example = {
      count = 3;
    };
  };

  options.consul = mkOption {
    type = types.nullOr consul;
    default = null;
    description = ''
      Specifies Consul configuration options specific to the group.
    '';
  };

  options.ephemeralDisk = mkOption {
    type = types.nullOr nomad.ephemeralDisk;
    default = null;
    description = ''
      Specifies the group's ephemeral disk requirements.
    '';
    example = {

    };
  };

  options.meta = mkOption {
    type = types.attrs;
    default = {};
    description = ''
      Annotates the task group with opaque metadata.
    '';
    example = {
      meta = {
        foo = "bar";
      };
    };
  };

  options.migrate = mkOption {
    type = types.nullOr nomad.migrate;
    default = null;
    description = ''
      Specifies a migration strategy to be applied during node drains.
    '';
    example = {

    };
  };

  options.networks = mkOption {
    type = types.listOf nomad.network;
    default = [];
    description = ''
      Specifies the network requirements and configuration, including static and dynamic port allocations, for the
      group.
    '';
  };

  options.reschedule = mkOption {
    type = types.nullOr nomad.reschedule;
    default = null;
    description = ''
      Specifies the reschedule policy to be applied to tasks in this group. If omitted, a default policy is used for
      batch and service jobs. System jobs are not eligible for rescheduling.
    '';
    example = {

    };
  };

  options.restart = mkOption {
    type = types.nullOr nomad.restart;
    default = null;
    description = ''
      Specifies the restart policy to be applied to tasks in this group. If omitted, a default policy for batch and
      non-batch jobs is used based on the job type.
    '';
    example = {

    };
  };

  options.scaling = mkOption {
    type = types.nullOr nomad.scaling;
    default = null;
    description = ''
      Specifies the autoscaling policy for the task group. This is primarily for supporting external autoscalers.
    '';
    example = {

    };
  };

  options.services = mkOption {
    type = types.listOf nomad.service;
    default = [];
    description = ''
      Specifies integrations with Consul for service discovery. Nomad automatically registers each service when an
      allocation is started and de-registers them when the allocation is destroyed.
    '';
  };

  options.shutdownDelay = mkOption {
    type = types.ints.unsigned;
    default = 0;
    description = ''
      Specifies the duration to wait when stopping a group's tasks. The delay occurs between Consul deregistration and
      sending each task a shutdown signal. Ideally, services would fail healthchecks once they receive a shutdown
      signal. Alternatively shutdown_delay may be set to give in-flight requests time to complete before shutting down.
      A group level shutdown_delay will run regardless if there are any defined group services. In addition, tasks may
      have their own shutdown_delay which waits between deregistering task services and stopping the task.
    '';
  };

  options.stopAfterClientDisconnect = mkOption {
    type = types.nullOr types.ints.unsigned;
    default = null;
    description = ''
      Specifies a duration after which a Nomad client that cannot communicate with the servers will stop allocations
      based on this task group. By default, a client will not stop an allocation until explicitly told to by a server. A
      client that fails to heartbeat to a server within the heartbeat_grace window and any allocations running on it
      will be marked "lost" and Nomad will schedule replacement allocations. However, these replaced allocations will
      continue to run on the non-responsive client; an operator may desire that these replaced allocations are also
      stopped in this case — for example, allocations requiring exclusive access to an external resource. When
      specified, the Nomad client will stop them after this duration. The Nomad client process must be running for this
      to occur.
    '';
  };

  options.tasks = mkOption {
    type = types.attrsOf nomad.task;
    description = ''
      A list of tasks that are part of the task group.
    '';
    example = {

    };
  };

  options.update = mkOption {
    type = types.nullOr nomad.update;
    default = null;
    description = ''
      Specifies an update strategy to be applied to all task groups within the job. When specified both at the job
      level and the task group level, the update blocks are merged with the task group's taking precedence.
    '';
  };

  options.vault = mkOption {
    type = types.nullOr nomad.vault;
    default = null;
    description = ''
      Specifies the set of Vault policies required by all tasks in this group. Overrides a vault block set at the job
      level.
    '';
  };

  options.volumes = mkOption {
    type = types.attrsOf nomad.volume;
    default = {};
    description = ''
      Specifies the volumes that are required by tasks within the group.
    '';
  };
}
