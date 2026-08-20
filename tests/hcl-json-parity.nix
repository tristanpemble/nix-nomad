{ api, nomad, pkgs, system }:

let
  evaluate = modules:
    (api.nomadConfiguration {
      inherit modules;
      nomad = _: nomad;
    }).${system};

  readJob = evaluated: name:
    builtins.fromJSON (builtins.readFile "${evaluated.jobsPackage}/${name}.json");

  evaluated = evaluate [ ({ config, lib, ... }: {
      options.audit = {
        importedGroup = lib.mkOption { type = lib.types.raw; };
        importedGateway = lib.mkOption { type = lib.types.raw; };
        importedTask = lib.mkOption { type = lib.types.raw; };
      };

      config = {
        audit.importedGroup = config._module.transformers.TaskGroup.fromJSON {
          Volumes.data = {
            Name = "data";
            Source = "data-source";
            Type = "host";
          };
        };
        audit.importedGateway = config._module.transformers.ConsulGatewayProxy.fromJSON {
          EnvoyGatewayBindAddresses.public = {
            Address = "0.0.0.0";
            Name = "public";
            Port = 8443;
          };
        };
        audit.importedTask = config._module.transformers.Task.fromJSON {
          Identity = {
            Env = true;
            Name = "default";
          };
          Identities = [{
            Audience = [ "metrics" ];
            Name = "metrics";
          }];
          ScalingPolicies = [
            {
              Enabled = true;
              Type = "vertical_cpu";
            }
            {
              Enabled = false;
              Type = "vertical_mem";
            }
            {
              Enabled = true;
              Type = "future_type";
            }
          ];
        };

        jobs.audit = {
          datacenters = [ "dc1" ];
          periodic.crons = [ "0 0 * * *" ];
          secret.job = {
            path = "job/path";
            provider = "nomad";
          };
          vault.changeMode = "restart";

          group.jobScope.task.jobScope = {
            driver = "raw_exec";
          };

          group.groupScope = {
            secret.group = {
              path = "group/path";
              provider = "nomad";
            };
            vault = {
              changeMode = "signal";
              changeSignal = "SIGHUP";
            };

            task.audit = {
              driver = "raw_exec";
              identities = [
                { env = true; }
                {
                  aud = [ "metrics" ];
                  name = "metrics";
                }
              ];
              scaling = {
                cpu.enabled = true;
                mem.enabled = false;
              };
              secret.task = {
                path = "task/path";
                provider = "nomad";
              };
              services = [{
                checks = [{
                  header."X-Test" = [ "one" "two" ];
                  name = "headers";
                  type = "http";
                }];
                name = "audit";
              }];
            };

            task.override = {
              driver = "raw_exec";
              vault.changeMode = "noop";
            };
          };
        };
      };
    }) ];

  job = readJob evaluated "audit";
  groups = builtins.listToAttrs (map
    (group: {
      name = group.Name;
      value = group;
    })
    job.TaskGroups);
  groupTasks = builtins.listToAttrs (map
    (task: {
      name = task.Name;
      value = task;
    })
    groups.groupScope.Tasks);
  jobScopeTask = builtins.head groups.jobScope.Tasks;
  task = groupTasks.audit;

  evalInvalidTask = taskConfig:
    readJob (evaluate [{
        jobs.invalid.group.invalid.task.invalid = taskConfig;
      }]) "invalid";
  duplicateDefaultIdentity = builtins.tryEval (builtins.deepSeq
    (evalInvalidTask {
      identities = [{ } { name = "default"; }];
    })
    true);
  invalidCPUScalingType = builtins.tryEval (builtins.deepSeq
    (evalInvalidTask {
      scaling.cpu.type = "horizontal";
    })
    true);
  conflictingPeriodicForms = builtins.tryEval (builtins.deepSeq
    (
      readJob (evaluate [{
          jobs.invalid.periodic = {
            cron = "0 0 * * *";
            crons = [ "0 1 * * *" ];
          };
        }]) "invalid"
    )
    true);
in
assert job.Periodic.SpecType == "cron";
assert job.Periodic.Specs == [ "0 0 * * *" ];
assert !(job ? Vault);
assert !(job ? Secrets);
assert !(groups.groupScope ? Vault);
assert !(groups.groupScope ? Secrets);
assert jobScopeTask.Vault.ChangeMode == "restart";
assert map (secret: secret.Name) jobScopeTask.Secrets == [ "job" ];
assert (task.Identity.Name or null) == null || task.Identity.Name == "default";
assert task.Identity.Env;
assert map (identity: identity.Name) task.Identities == [ "metrics" ];
assert map (policy: policy.Type) task.ScalingPolicies == [ "vertical_cpu" "vertical_mem" ];
assert task.Vault.ChangeMode == "signal";
assert task.Vault.ChangeSignal == "SIGHUP";
assert groupTasks.override.Vault.ChangeMode == "noop";
assert map (secret: secret.Name) task.Secrets == [ "task" "group" "job" ];
assert (builtins.head (builtins.head task.Services).Checks).Header."X-Test" == [ "one" "two" ];
assert evaluated.config.audit.importedGroup.volume.data.source == "data-source";
assert evaluated.config.audit.importedGateway.envoyGatewayBindAddresses.public.address == "0.0.0.0";
assert evaluated.config.audit.importedGateway.envoyGatewayBindAddresses.public.port == 8443;
assert map (identity: identity.name) evaluated.config.audit.importedTask.identities == [ "default" "metrics" ];
assert evaluated.config.audit.importedTask.scaling.cpu.enabled;
assert !evaluated.config.audit.importedTask.scaling.mem.enabled;
assert map (policy: policy.type) evaluated.config.audit.importedTask.scalings == [ "future_type" ];
assert !duplicateDefaultIdentity.success;
assert !invalidCPUScalingType.success;
assert !conflictingPeriodicForms.success;
"ok"
