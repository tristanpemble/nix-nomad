{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.native = mkOption {
    type = types.bool;
    default = false;
    description = ''
      This is used to configure the service as supporting Connect Native applications.
    '';
  };

  options.sidecarService = mkOption {
    type = types.nullOr nomad.sidecarService;
    default = null;
    description = ''
      This is used to configure the sidecar service created by Nomad for Consul Connect.
    '';
  };

  options.sidecarTask = mkOption {
    type = types.nullOr nomad.sidecarTask;
    default = null;
    description = ''
      This modifies the task configuration of the Envoy proxy created as a sidecar or gateway.
    '';
  };

  options.gateway = mkOption {
    type = types.nullOr nomad.gateway;
    default = null;
    description = ''
      This is used to configure the gateway service created by Nomad for Consul Connect.
    '';
  };
}
