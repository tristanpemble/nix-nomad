{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.disableDefaultTcpCheck = mkOption {
    type = types.bool;
    default = false;
    description = ''
      Disable the default TCP health check.
    '';
  };

  options.port = mkOption {
    type = types.either types.str types.port;
    default = "";
    description = ''
      Port label for sidecar service.
    '';
  };

  options.proxy = mkOption {
    type = types.nullOr nomad.proxy;
    default = null;
    description = ''
      This is used to configure the sidecar proxy service.
    '';
  };

  options.tags = mkOption {
    type = types.listOf types.str;
    default = [];
    description = ''
      Custom Consul service tags for the sidecar service.
    '';
  };
}
