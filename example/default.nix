let
  pkgs = import <nixpkgs> {};
  lib = (import ../.).lib.${builtins.currentSystem};
in

(lib.mkNomadJob ({
  imports = [ ./example.nix ];
  jobs.myjob.groups.foo.count = pkgs.lib.mkForce 5;
})).config
