{ config, lib, ... }:

let
  nomad = import ./lib.nix { inherit lib; };

  JobJson = { config, ... }: {
    options.toJSON = lib.mkOption {
      internal = true;
      visible = false;
      readOnly = true;
    };
    config.toJSON = name: { Job = nomad.mkJobAPI name config; };
  };
in
with lib; with lib.types; {
  config._module.args = { inherit nomad; };
  options.jobs = mkOption {
    type = attrsOf (submodule [nomad.Job JobJson]);
    description = ''
      An attribute set to define job descriptions.
    '';
    example = {
      jobs.my-app = {
        type = "batch";
        datacenters = ["dc1"];
        groups = {};
      };
    };
  };
}
