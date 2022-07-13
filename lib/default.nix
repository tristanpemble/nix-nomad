{ self, nixpkgs, nixpkgs-lib }:

let generated = import ./generated.nix {
  inherit (nixpkgs-lib) lib;
}; in
let nomad = nixpkgs-lib.lib.recursiveUpdate generated {
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
    inherit nixpkgs nomad;
    inherit (nixpkgs-lib) lib;
  };
  mkNomadJobs = import ./mkNomadJobs.nix {
    inherit nixpkgs nomad;
    inherit (self.lib) evalNomadJobs;
    inherit (nixpkgs-lib) lib;
  };
};
in nomad
