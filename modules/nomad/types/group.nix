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

  options.network = mkOption {
    type = types.nullOr nomad.network;
    default = null;
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

  # TODO: options.shutdown_delay
  # TODO: options.stop_after_client_connect

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

  # TODO: options.vault
  # TODO: options.volume
}
