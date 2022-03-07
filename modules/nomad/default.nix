{ lib, ... }:

let
  inherit (lib) mkMerge mkOption types;
  nomad = import ./types types;
in
{
  options.jobs = mkOption {
    type = types.attrsOf nomad.job;
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
