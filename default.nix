{ pkgs }:

let
  system = pkgs.stdenv.hostPlatform.system;
  pkgsFor = requestedSystem:
    if requestedSystem == system then
      pkgs
    else
      throw "nix-nomad was initialized for ${system}, not ${requestedSystem}";

  api = import ./lib {
    inherit pkgsFor;
    inherit (pkgs) lib;
    systems = [ system ];
  };
in
{
  lib = api;
}
