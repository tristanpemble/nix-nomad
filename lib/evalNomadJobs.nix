{ lib, nixpkgs, nomad }:

{ system ? null
, pkgs ? import nixpkgs { inherit system; }
, config
}:

let evaluated = lib.evalModules {
  modules = [
    ({ _module.args = { inherit nomad pkgs; }; })
    ../modules/core.nix
  ] ++ (lib.toList config);
}; in
evaluated.config
