{ config, lib, nomad, pkgs, ... }:

with lib;

{
  options.nomad.build = {
    apiJob = mkOption {
      description = "An attrset containing raw Nix job definitions formatted for the Nomad JSON API.";
      type = with types; attrsOf raw;
    };
    apiJobFile = mkOption {
      description = "An attrset of Nix derivations that output Nomad JSON API compliant job files.";
      type = with types; attrsOf package;
    };
    apiJobFarm = mkOption {
      description = "A derivation that outputs a folder containing all of the Nomad JSON API compliant job files.";
      type = with types; package;
    };
  };

  config.nomad.build = rec {
    apiJob = mapAttrs nomad.mkJobAPI config.job;
    apiJobFile = mapAttrs (name: job:
      pkgs.writeText "${name}.json" (builtins.toJSON job)
    ) apiJob;
    apiJobFarm = pkgs.linkFarmFromDrvs "nomad-jobs" (builtins.attrValues apiJobFile);
  };
}