{ api
, nomad
, pkgs
, system
}:

let
  modules = [
    {
      job.test = {
        type = "batch";
        datacenters = [ "dc1" ];
        group.test.task.test = {
          driver = "raw_exec";
          config.command = "/bin/true";
        };
      };
    }
    ({ lib, testValue, ... }: {
      options.testValue = lib.mkOption { type = lib.types.str; };
      config.testValue = testValue;
    })
  ];

  configuration = api.nomadConfiguration {
    inherit modules;
    extraSpecialArgs.testValue = "passed";
    nomad = _: nomad;
  };
  evaluated = configuration.${system};
  extended = evaluated.extendModules {
    modules = [{ job.test.priority = 10; }];
  };
in
assert builtins.attrNames api == [ "nomadConfiguration" "time" ];
assert evaluated.config.job.test.type == "batch";
assert evaluated.config.testValue == "passed";
assert !(evaluated.config ? _nix-nomad);
assert evaluated.jobs.test.Type == "batch";
assert evaluated.nomad == nomad;
assert builtins.attrNames evaluated.jobsPackages == [ "test" ];
assert pkgs.lib.isDerivation evaluated.jobsPackages.test;
assert pkgs.lib.isDerivation evaluated.jobsPackage;
assert extended.config.job.test.priority == 10;
assert extended.jobs.test.Priority == 10;
assert extended.nomad == nomad;
assert pkgs.lib.isDerivation extended.jobsPackages.test;
assert pkgs.lib.isDerivation extended.jobsPackage;
"ok"
