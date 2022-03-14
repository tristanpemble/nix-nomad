{ pkgs }:

let
  inherit (pkgs) lib;
  inherit (pkgs.lib) evalModules;

  evaluateConfiguration = configuration:
    evalModules {
      modules = [
        { imports = [ ../modules/nomad ]; }
        { _module.args = { inherit pkgs; }; }
      ] ++ (lib.toList configuration);
    };

  nomad = import ../modules/nomad/lib.nix { inherit lib; overrides = {}; };
in
rec {
  mkNomadJobSet = configuration: lib.mapAttrs (name: v: v.toJSON name) (evaluateConfiguration configuration).config.jobs;
}
