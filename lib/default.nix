{ lib
, pkgsFor
, systems
}:

let
  time = rec {
    nanosecond = 1;
    microsecond = 1000 * nanosecond;
    millisecond = 1000 * microsecond;
    second = 1000 * millisecond;
    minute = 60 * second;
    hour = 60 * minute;
    day = 24 * hour;
    week = 7 * day;
  };

  configurationForSystem = lib.genAttrs systems
    (system:
      let
        pkgs = pkgsFor system;
        defaultNomad = pkgs.nomad;
        hcl = import ./hcl.nix {
          inherit lib pkgs;
        };

        schemaFor = nomad:
          let
            generator = pkgs.callPackage ../generator { inherit nomad; };
            generated = pkgs.runCommand "nix-nomad-schema-${lib.getVersion nomad}.nix" {
              nativeBuildInputs = [ generator ];
            } ''
              nix-nomad-generator > "$out"
            '';
          in
          import generated;

        evalNomadJobs = import ./evalNomadJobs.nix {
          inherit defaultNomad hcl lib schemaFor time;
          coreModule = ../modules/core.nix;
        };
        mkNomadJobsFromJobs = import ./mkNomadJobs.nix {
          inherit pkgs;
        };
        nomadConfiguration =
          args@{ nomad ? defaultNomad, ... }:
          let
            withJobsPackage = evaluated:
              builtins.removeAttrs evaluated [ "jobs" ] // {
                inherit nomad;
                jobsPackage = mkNomadJobsFromJobs evaluated.jobs;
                extendModules = extendArgs:
                  withJobsPackage (evaluated.extendModules extendArgs);
              };
          in
          withJobsPackage (evalNomadJobs (args // { inherit nomad; }));
      in
      nomadConfiguration
    );

  nomadConfiguration =
    { modules
    , nomad ? null
    , extraSpecialArgs ? { }
    }:
    assert lib.assertMsg
      (nomad == null || builtins.isFunction nomad)
      "nomadConfiguration nomad must be a function";
    lib.genAttrs systems
      (system:
        configurationForSystem.${system}
          ({ inherit extraSpecialArgs modules; }
            // lib.optionalAttrs (nomad != null) {
              nomad = nomad system;
            }));
in
{
  inherit nomadConfiguration time;
}
