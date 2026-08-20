{ lib, nix-nomad, nomad, ... }:

{
  imports = [
    (nix-nomad.hcl.importModule {
      inherit nomad;
      path = ./docs.hcl;
    })
  ];

  jobs.docs.region = lib.mkForce "global";
}
