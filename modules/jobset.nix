{ lib, nomad, pkgs, ... }:

with lib;

{
  options.job = mkOption {
    type = with types; attrsOf (submodule nomad.Job);
    description = "An attrset of Nomad jobs, where attrset keys are the job name.";
    default = {};
    example = {
      jobs.foo = {
        # ...
      };
    };
  };
}
