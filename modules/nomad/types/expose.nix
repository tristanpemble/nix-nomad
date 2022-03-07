{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;

  path = types.submodule {
    options.path = mkOption {
      type = types.str;
      description = ''
        The HTTP or gRPC path to expose. The path must be prefixed with a slash.
      '';
    };

    options.protocol = mkOption {
      type = types.enum ["http" "http2"];
      description = ''
        Sets the protocol of the listener. Must be http or http2. For gRPC use http2.
      '';
    };

    options.localPathPort = mkOption {
      type = types.port;
      description = ''
        The port the service is listening to for connections to the configured path. Typically this will be the same as
        the service.port value, but could be different if for example the exposed path is intended to resolve to another
        task in the task group.
      '';
    };

    options.listenerPort = mkOption {
      type = types.str;
      description = ''
        The name of the port to use for the exposed listener. The port should be configured to map inside the task's
        network namespace.
      '';
    };
 };
in
{
  options.paths = mkOption {
    type = types.listOf path;
    default = [];
    description = ''
        A list of [Envoy Expose Path Configurations][expose_path] to expose through Envoy.
    '';
  };
}
