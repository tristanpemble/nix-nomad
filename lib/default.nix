{ self, nixpkgs, nixpkgs-lib }:

let nomad = import ./nomad.nix {
  inherit (nixpkgs-lib) lib;
}; in

nomad // {
  evalNomadJobs = import ./evalNomadJobs.nix {
    inherit nomad;
    inherit (nixpkgs-lib) lib;
  };
  mkNomadJobs = import ./mkNomadJobs.nix {
    inherit nixpkgs;
    inherit (self.lib) evalNomadJobs;
  };
}
