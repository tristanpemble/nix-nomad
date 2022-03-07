{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.allAtOnce = mkOption {
    type = types.bool;
    default = false;
    description = ''
      Controls whether the scheduler can make partial placements if optimistic scheduling resulted in a
      oversubscribed node. This does not control whether all allocations for the job, where all would be the desired
      count for each task group, must be placed atomically. This should only be used for special circumstances.
    '';
  };

  options.constraints = mkOption {
    type = types.listOf nomad.constraint;
    default = [];
    description = ''
      A list to define additional constraints where a job can be run.
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
      A list to define placement preferences on nodes where a job can be run.
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

  options.datacenters = mkOption {
    type = types.listOf types.str;
    description = ''
      A list of datacenters in the region which are eligible for task placement. This must be provided, and does not
      have a default.
    '';
    example = {
      type = "dc1";
    };
  };

  options.groups = mkOption {
    type = types.attrsOf nomad.group;
    description = ''
      An attribute set to define additional task groups.
    '';
    example = {
      type = "dc1";
    };
  };

  options.meta = mkOption {
    type = types.attrs;
    default = {};
    description = ''
      Annotates the job with opaque metadata.
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
      Specifies the groups strategy for migrating off of draining nodes. If omitted, a default migration strategy is
      applied. Only service jobs with a count greater than 1 support migrate stanzas.
    '';
    example = {

    };
  };

  options.namespace = mkOption {
    type = types.str;
    default = "default";
    description = ''
      The namespace to execute the job in, defaults to "default".
    '';
    example = {
      namespace = "production";
    };
  };

  #options.parameterized = mkOption {
  #
  #};

  options.periodic = mkOption {
    type = types.nullOr nomad.periodic;
    default = null;
    description = ''
      Periodic allows the job to be scheduled at fixed times, dates or intervals. The periodic expression is always
      evaluated in the UTC timezone to ensure consistent evaluation when Nomad Servers span multiple time zones.
    '';
    example = {
      periodic = {
        enabled = true;
        timeZone = "Europe/Berlin";
        specType = "cron";
        spec = "*/15 - *";
        prohibitOverlap = true;
      };
    };
  };

  options.priority = mkOption {
    type = types.ints.between 1 100;
    default = 50;
    description = ''
      Specifies the job priority which is used to prioritize scheduling and access to resources. Must be between 1 and
      100 inclusively, and defaults to 50.
    '';
    example = {
      priority = 10;
    };
  };

  options.region = mkOption {
    type = types.str;
    default = "global";
    description = ''
      The region to run the job in, defaults to "global".
    '';
    example = {
      region = "us-west";
    };
  };

  options.reschedule = mkOption {
    type = types.nullOr nomad.reschedule;
    default = null;
    description = ''
      Specifies a reschedule policy to be applied to all task groups within the job. When specified both at the job
      level and the task group level, the reschedule blocks are merged, with the task group's taking precedence.
    '';
    example = {

    };
  };

  options.type = mkOption {
    type = types.enum ["service" "system" "batch" "sysbatch"];
    default = "service";
    description = ''
      Specifies the Nomad scheduler to use. Nomad provides the service, system, batch, and sysbatch (new in Nomad 1.2)
      schedulers.
    '';
    example = {
      type = "batch";
    };
  };

  options.update = mkOption {
    type = types.nullOr nomad.update;
    default = null;
    description = ''
      Specifies the task group update strategy. When omitted, rolling updates are disabled. The update stanza can be
      specified at the job or task group level. When specified at the job, the update stanza is inherited by all task
      groups. When specified in both the job and in a task group, the stanzas are merged with the task group's taking
      precedence.
    '';
    example = {
      maxParallel = 3;
      healthCheck = "checks";
      minHealthyTime = 15000000000;
      healthyDeadline = 180000000000;
      autoRevert = false;
      autoPromote = false;
      canary = 1;
    };
  };

  options.vault = mkOption {
    type = types.nullOr nomad.vault;
    default = null;
    description = ''
      Specifies the set of Vault policies required by all tasks in this job.
    '';
  };

  options.vaultToken = mkOption {
    type = types.str;
    default = "";
    description = ''
      Specifies the Vault token that proves the submitter of the job has access to the specified policies in the vault
      stanza. This field is only used to transfer the token and is not stored after job submission.

      It is strongly discouraged to place the token as a configuration parameter like this, since the token could be
      checked into source control accidentally. Users should set the VAULT_TOKEN environment variable when running the
      job instead.
    '';
  };

 options.consulToken = mkOption {
   type = types.str;
   default = "";
   description = ''
     Specifies the Consul token that proves the submitter of the job has access to the Service Identity policies
     associated with the job's Consul Connect enabled services. This field is only used to transfer the token and is not
     stored after job submission.

     It is strongly discouraged to place the token as a configuration parameter like this, since the token could be
     checked into source control accidentally. Users should set the CONSUL_HTTP_TOKEN environment variable when running
     the job instead.
   '';
 };
}
