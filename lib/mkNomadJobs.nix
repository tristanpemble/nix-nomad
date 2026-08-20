{ pkgs }:

jobs:

let
  jobFiles = pkgs.lib.mapAttrs
    (name: job: pkgs.writeText "${name}.json" (builtins.toJSON job))
    jobs;
in
pkgs.linkFarm "nomad-jobs" (pkgs.lib.mapAttrsToList
  (name: path: {
    name = "${name}.json";
    inherit path;
  })
  jobFiles)
