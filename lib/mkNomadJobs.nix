{ nixpkgs, lib, nomad, evalNomadJobs }:

{ system ? null
, pkgs ? import nixpkgs.legacyPackages.${system}
, config
}:

let evaluatedConfig = evalNomadJobs { inherit config pkgs system; }; in
let jobs = lib.mapAttrs (_: job: job.drv) evaluatedConfig.job; in
jobs
