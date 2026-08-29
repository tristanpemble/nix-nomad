{ pkgs }:

jobs:

let
  jobsPackages = pkgs.lib.mapAttrs
    (name: job: pkgs.writeText "${name}.json" (builtins.toJSON job))
    jobs;
  jobsPackage = pkgs.linkFarm "nomad-jobs" (pkgs.lib.mapAttrsToList
    (name: path: {
      name = "${name}.json";
      inherit path;
    })
    jobsPackages);
in
{
  inherit jobsPackage jobsPackages;
}
