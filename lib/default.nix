{ pkgs }:

let
  inherit (pkgs.lib) evalModules mkOption types;

  evaluateConfiguration = configuration:
    evalModules {
      modules = [
        { imports = [ ../modules/nomad ]; }
        { _module.args = { inherit pkgs; }; }
        configuration
      ];
    };
in
{
  mkNomadJob = configuration: evaluateConfiguration configuration;
}
