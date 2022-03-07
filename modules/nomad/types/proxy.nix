{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.localServiceAddress = mkOption {
    type = types.str;
    default = "127.0.0.1";
    description = ''
      The address the local service binds to. Useful to customize in clusters with mixed Connect and non-Connect
      services.
    '';
  };

  options.localServicePort = mkOption {
    type = types.nullOr types.port;
    default = null;
    description = ''
      The port the local service binds to. Usually the same as the parent service's port, it is useful to customize in
      clusters with mixed Connect and non-Connect services.
    '';
  };

  options.upstreams = mkOption {
    # TODO: proxy.upstreams option
  };

  options.expose = mkOption {
    # TODO: proxy.expose option
  };

  options.config = mkOption {
    # TODO: proxy.config option
  };
}
