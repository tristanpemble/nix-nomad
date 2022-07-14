{ lib, ... }:

with lib;

{
  options.nomad.build = mkOption {
    default = {};
    description = ''
      Attribute set of derivations used to set up the Nomad server.
    '';
    type = with types; submoduleWith {
      modules = [{
        freeformType = lazyAttrsOf (uniq unspecified);
      }];
    };
  };
}
