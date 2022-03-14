let
  pkgs = import <nixpkgs> {};
  lib = (import ../.).lib.${builtins.currentSystem};
in

lib.mkNomadJobSet [ ./job.nix ./overrides.nix ]
