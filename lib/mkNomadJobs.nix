{ nixpkgs, evalNomadJobs }:

{ system, config }:

let pkgs = import nixpkgs { inherit system; }; in
let jobs = evalNomadJobs config; in
let mkJobDrv = name: job: pkgs.writeText "${name}.json" (builtins.toJSON job); in
let drvs = builtins.mapAttrs mkJobDrv jobs; in
drvs
