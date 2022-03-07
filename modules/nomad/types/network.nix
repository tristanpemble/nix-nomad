{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;

  portDecl = types.submodule {
    options.static = mkOption {
      type = types.nullOr types.port;
      default = null;
      description = ''
        Specifies the static TCP/UDP port to allocate. If omitted, a dynamic port is chosen. We do not recommend using
        static ports, except for system or specialized jobs like load balancers.
      '';
    };

    options.to = mkOption {
      type = types.nullOr types.port;
      default = null;
      description = ''
        Applicable when using "bridge" mode to configure port to map to inside the task's network namespace. Omitting
        this field or setting it to -1 sets the mapped port equal to the dynamic port allocated by the scheduler. The
        NOMAD_PORT_[label] environment variable will contain the to value.
      '';
    };

    options.hostNetwork = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = ''
        Designates the host network name to use when allocating the port. When port mapping the host port will only
        forward traffic to the matched host network address.
      '';
    };
  };

  dnsConfig = types.submodule {
    options.servers = mkOption {
      type = types.listOf types.str;
      default = [];
      description = ''
        Sets the DNS nameservers the allocation uses for name resolution.
      '';
    };

    options.searches = mkOption {
      type = types.listOf types.str;
      default = [];
      description = ''
        Sets the search list for hostname lookup.
      '';
    };

    options.options = mkOption {
      type = types.listOf types.str;
      default = [];
      description = ''
        Sets internal resolver variables.
      '';
    };
  };
in
{
  options.mbits = mkOption {
    type = types.ints.unsigned;
    default = 10;
    description = ''
      Specifies the bandwidth required in MBits.
    '';
  };

  options.ports = mkOption {
    type = types.attrsOf portDecl;
    default = {};
    description = ''
      An attribute set that specifies TCP/UDP port allocations that can be used to specify both dynamic ports and
      reserved ports.
    '';
  };

  options.mode = mkOption {
    # TODO: validate "cni/[networkname]" syntax
    type = types.either (types.enum ["none" "bridge" "host"]) types.str;
    default = "host";
    description = ''
      Mode of the network. This option is only supported on Linux clients. The following modes are available:
        - none - Task group will have an isolated network without any network interfaces.
        - bridge - Task group will have an isolated network namespace with an interface that is bridged with the host.
          Note that bridge networking is only currently supported for the docker, exec, raw_exec, and java task drivers.
        - host - Each task will join the host network namespace and a shared network namespace is not created. This
          matches the current behavior in Nomad 0.9.
        - cni/[cni network name] - Task group will have an isolated network namespace with the network configured by
          CNI.
    '';
  };

  options.hostname = mkOption {
    type = types.str;
    default = "";
    description = ''
      The hostname assigned to the network namespace. This is currently only supported using the Docker driver and when
      the mode is set to bridge. This parameter supports interpolation.
    '';
  };

  options.dns = mkOption {
    type = types.nullOr dnsConfig;
    default = null;
    description = ''
      Sets the DNS configuration for the allocations. By default all DNS configuration is inherited from the client
      host. DNS configuration is only supported on Linux clients at this time.
    '';
  };
}
