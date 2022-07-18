{ lib, ... }:

{
  imports = [
    (lib.importNomadModule ./docs.hcl {})
  ];

  job.docs.region = lib.mkForce "global";
}
