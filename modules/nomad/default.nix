{ lib, ... }:

let
  inherit (lib) mkOption;
  inherit (lib.types) attrsOf;
  nomad = import ./lib.nix { inherit lib; overrides = {}; };
in
{
  options.jobs = mkOption {
    type = attrsOf nomad.Job;
    description = ''
      An attribute set to define job descriptions.
    '';
    example = {
      jobs.my-app = {
        type = "batch";
        datacenters = ["dc1"];
        groups = {};
      };
    };
  };
}
