{ lib, nomad, pkgs, ... }:

with lib;
with types;

let Job = { name, config, ... }: {
  imports = [ nomad.Job ];

  options.json = mkOption {
    type = attrs;
    readOnly = true;
    visible = false;
    default = nomad.mkJobAPI name config;
  };
  options.drv = mkOption {
    type = attrs;
    readOnly = true;
    visible = false;
    default = pkgs.writeText "${name}.json" (builtins.toJSON config.json);
  };
}; in

{
  options.job = mkOption {
    type = attrsOf (submodule Job);
    description = "An attrset of Nomad jobs, where attrset keys are the job name.";
    default = {};
    example = {
      jobs.foo = {
        # ...
      };
    };
  };
}
