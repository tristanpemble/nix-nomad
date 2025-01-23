{ self, nixpkgs, nixpkgs-lib, nomad }:

{ system ? builtins.currentSystem
, pkgs ? import nixpkgs.legacyPackages.${system}
, config
, extraArgs ? {}
}:

let
  inherit (pkgs) lib;
  evaluated = lib.evalModules {
    specialArgs = extraArgs // {
      lib = pkgs.lib
        // (import ./without-pkgs.nix { inherit self nixpkgs nixpkgs-lib; })
        // (import ./with-pkgs.nix { inherit pkgs; inherit (pkgs) lib; })
        // {
          importNomadModule = path: vars: { config, lib, ... }: let
            job = config._module.transformers.Job.fromJSON (lib.importNomadHCL path vars).Job;
          in {
            job.${job.name} = builtins.removeAttrs job ["id" "name"];
          };
        };
      };

    modules = [
      ({ _module.args = { inherit pkgs; inherit (nomad) time; }; })
      ../modules
    ] ++ (lib.toList config);
  };
in evaluated.config
