{ coreModule
, defaultNomad
, hcl
, lib
, schemaFor
, time
}:

{ modules
, nomad ? defaultNomad
, extraSpecialArgs ? { }
}:

assert lib.assertMsg (builtins.isList modules) "evalNomadJobs modules must be a list";

let
  schemaModule = schemaFor nomad;
  normalize = evaluated:
    evaluated // {
      config = builtins.removeAttrs evaluated.config [ "_nix-nomad" ];
      jobs = evaluated.config._nix-nomad.jobs;
      extendModules = args: normalize (evaluated.extendModules args);
    };
  evaluated = lib.evalModules {
    class = "nomad";
    specialArgs = extraSpecialArgs // {
      inherit nomad;
      nix-nomad = {
        inherit hcl time;
      };
    };
    modules = [
      coreModule
      schemaModule
      ({ config, lib, ... }: {
        options._nix-nomad.jobs = lib.mkOption {
          type = with lib.types; attrsOf raw;
          internal = true;
          visible = false;
          readOnly = true;
        };

        config._nix-nomad.jobs = lib.mapAttrs
          (_: config._module.transformers.Job.toJSON)
          config.jobs;
      })
    ] ++ modules;
  };
in
normalize evaluated
