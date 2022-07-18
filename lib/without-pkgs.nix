{ self, nixpkgs, nixpkgs-lib }:

let
  time = rec {
    nanosecond = 1;
    microsecond = 1000 * nanosecond;
    millisecond = 1000 * microsecond;
    second = 1000 * millisecond;
    minute = 60 * second;
    hour = 60 * minute;
    day = 24 * hour;
    week = 7 * day;
  };

  evalNomadJobs = import ./evalNomadJobs.nix {
    inherit nixpkgs nixpkgs-lib nomad self;
  };

  mkNomadJobs = args: (nomad.evalNomadJobs args).nomad.build.apiJobFarm;

  nomad = {
    inherit evalNomadJobs mkNomadJobs time;
  };
in nomad
