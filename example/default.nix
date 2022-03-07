let
  pkgs = import <nixpkgs> {};
  lib = (import ../.).lib.${builtins.currentSystem};
in

(lib.mkNomadJob ({
  imports = [ ./example.nix ];
})).config
