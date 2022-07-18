{ self, nixpkgs, nixpkgs-lib, nomad }:

{ system ? builtins.currentSystem
, pkgs ? import nixpkgs { inherit system; }
, config
}:

let
  inherit (pkgs) lib;
  evaluated = lib.evalModules {
    specialArgs.lib = pkgs.lib
      // (import ./without-pkgs.nix { inherit self nixpkgs nixpkgs-lib; })
      // (import ./with-pkgs.nix { inherit pkgs; inherit (pkgs) lib; });

    modules = [
      ({ _module.args = { inherit pkgs; inherit (nomad) time; }; })
      ../modules
    ] ++ (lib.toList config);
  };
in evaluated.config
