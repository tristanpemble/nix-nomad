{ lib, nomad, ... }:

with lib;
with types;

{
  options.jobs = mkOption {
    type = attrsOf (submodule nomad.Job);
    description = "An attrset of Nomad jobs, where attrset keys are the job name.";
    default = {};
    example = {
      jobs.foo = {
        # ...
      };
    };
  };
}
