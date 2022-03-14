{ pkgs }:

let
  inherit (pkgs) lib;
  inherit (pkgs.lib) evalModules;

  evaluateConfiguration = configuration:
    evalModules {
      modules = [
        { imports = [ ../modules/nomad ]; }
        { _module.args = { inherit pkgs; }; }
        configuration
      ];
    };

  nomad = import ../modules/nomad/lib.nix { inherit lib; overrides = {}; };
in
rec {
  mkNomadJobSet = configuration:
    if builtins.isPath configuration
    then mkNomadJobSet (import configuration)
    else lib.mapAttrs (name: v: v.toJSON name) (evaluateConfiguration configuration).config.jobs;
}
