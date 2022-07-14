{ lib, nixpkgs, nomad }:

{ system ? builtins.currentSystem
, pkgs ? import nixpkgs { inherit system; }
, config
}:

let evaluated = lib.evalModules {
  modules = [
    ({ _module.args = { inherit nomad pkgs; inherit (nomad) time; }; })
    ../modules
  ] ++ (lib.toList config);
}; in
evaluated.config
