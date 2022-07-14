{ config, lib, nomad, pkgs, ... }:

with lib;

{
  options.job = mkOption {
    type = with types; attrsOf config._module.types.Job;
    description = "An attrset of Nomad jobs, where attrset keys are the job name.";
    default = {};
    example = {
      jobs.foo = {
        # ...
      };
    };
  };
}
