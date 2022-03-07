{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;

  meshGateway = types.submodule {
    options.mode = mkOption {
      type = types.nullOr (types.enum ["local" "remote" "none"]);
      default = null;
      description = ''
        The mode of operation in which to use Connect Mesh Gateways. If left unset, the mode will default to the mode as
        determined by the Consul service-defaults configuration for the service. Can be configured with the following
        modes:
          - local - In this mode the Connect proxy makes its outbound connection to a gateway running in the same
            datacenter. That gateway is then responsible for ensuring the data gets forwarded along to gateways in the
            destination datacenter.
          - remote - In this mode the Connect proxy makes its outbound connection to a gateway running in the
            destination datacenter. That gateway will then forward the data to the final destination service.
          - none - In this mode, no gateway is used and a Connect proxy makes its outbound connections directly to the
            destination services.
      '';
    };
  };
in
{
  options.destinationName = mkOption {
    type = types.str;
    description = ''
      Name of the upstream service.
    '';
  };

  options.localBindPort = mkOption {
    type = types.port;
    description = ''
      The port the proxy will receive connections for the upstream on.
    '';
  };

  options.datacenter = mkOption {
    type = types.str;
    default = "";
    description = ''
      The Consul datacenter in which to issue the discovery query. Defaults to the empty string, which Consul interprets
      as the local Consul datacenter.
    '';
  };

  options.localBindAddress = mkOption {
    type = types.str;
    default = "";
    description = ''
      The address the proxy will receive connections for the upstream on.
    '';
  };

  options.meshGateway = mkOption {
    type = types.nullOr meshGateway;
    default = null;
    description = ''
      Configures the mesh gateway behavior for connecting to this upstream.
    '';
  };
}
