{ self, nixpkgs, nixpkgs-lib }:

let generated = import ./generated.nix {
  inherit (nixpkgs-lib) lib;
}; in
let nomad = nixpkgs-lib.lib.recursiveUpdate generated {
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
