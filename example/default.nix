let
  pkgs = import <nixpkgs> {};
  lib = (import ../.).lib.${builtins.currentSystem};
in

lib.mkNomadJobSet ./example.nix
