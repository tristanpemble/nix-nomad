{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;

  check = types.submodule {
    # TODO: service check type
    options.foo = mkOption {};
  };
in
{
  options.checks = mkOption {
    type = types.listOf check;
    default = [];
    description = ''
      Specifies health checks associated with the service. At this time, Nomad supports the grpc, http, script1, and
      tcp checks.
    '';
  };

  options.connect = mkOption {
    type = types.nullOr nomad.connect;
    default = null;
    description = ''
      Configures the Consul Connect integration. Only available on group services.
    '';
  };

  options.name = mkOption {
    type = types.str;
    default = "$${BASE}";
    description = ''
      Specifies the name this service will be advertised as in Consul. If not supplied, this will default to the name of
      the job, group, and task concatenated together with a dash, like "docs-example-server". Each service must have a
      unique name within the cluster. Names must adhere to RFC-1123 §2.1 and are limited to alphanumeric and hyphen
      characters (i.e. [a-z0-9\-]), and be less than 64 characters in length.

      In addition to the standard Nomad interpolation, the following keys are also available:

        - $${JOB} - the name of the job
        - $${GROUP} - the name of the group
        - $${TASK} - the name of the task
        - $${BASE} - shorthand for $${JOB}-$${GROUP}-$${TASK}

      Validation of the name occurs in two parts. When the job is registered, an initial validation pass checks that the
      service name adheres to RFC-1123 §2.1 and the length limit, excluding any variables requiring interpolation. Once
      the client receives the service and all interpretable values are available, the service name will be interpolated
      and revalidated. This can cause certain service names to pass validation at submit time but fail at runtime.
    '';
  };

  options.port = mkOption {
    type = types.either types.port types.str;
    default = "";
    description = ''
      Specifies the port to advertise for this service. The value of port depends on which address_mode is being used:
        - alloc - Advertise the mapped to value of the labeled port and the allocation address. If a to value is not set, the port falls back to using the allocated host port. The port field may be a numeric port or a port label specified in the same group's network stanza.
        - driver - Advertise the port determined by the driver (e.g. Docker or rkt). The port may be a numeric port or a port label specified in the driver's ports field.
        - host - Advertise the host port for this service. port must match a port label specified in the network stanza.
    '';
  };

  options.tags = mkOption {
    type = types.listOf types.str;
    default = [];
    description = ''
      Specifies the list of tags to associate with this service. If this is not supplied, no tags will be assigned to
      the service when it is registered.
    '';
  };

  options.canaryTags = mkOption {
    type = types.listOf types.str;
    default = [];
    description = ''
      Specifies the list of tags to associate with this service when the service is part of an allocation that is
      currently a canary. Once the canary is promoted, the registered tags will be updated to those specified in the
      tags parameter. If this is not supplied, the registered tags will be equal to that of the tags parameter.
    '';
  };

  options.enableTagOverride = mkOption {
    type = types.bool;
    default = false;
    description = ''
      Enables users of Consul's Catalog API to make changes to the tags of a service without having those changes be
      overwritten by Consul's anti-entropy mechanism. See Consul documentation for more information.
    '';
  };

  options.addressMode = mkOption {
    type = types.enum ["alloc" "auto" "driver" "host"];
    default = "auto";
    description = ''
      Specifies which address (host, alloc or driver-specific) this service should advertise. This setting is supported
      in Docker since Nomad 0.6 and rkt since Nomad 0.7. See below for examples. Valid options are:
        - alloc - For allocations which create a network namespace, this address mode uses the IP address inside the
          namespace. Can only be used with "bridge" and "cni" networking modes. A numeric port may be specified for
          situations where no port mapping is necessary. This mode can only be set for services which are defined in a
          "group" block.
        - auto - Allows the driver to determine whether the host or driver address should be used. Defaults to host and
          only implemented by Docker. If you use a Docker network plugin such as weave, Docker will automatically use
          its address.
        - driver - Use the IP specified by the driver, and the port specified in a port map. A numeric port may be
          specified since port maps aren't required by all network plugins. Useful for advertising SDN and overlay
          network addresses. Task will fail if driver network cannot be determined. Only implemented for Docker and rkt.
          This mode can only be set for services which are defined in a "task" block.
        - host - Use the host IP and port.
    '';
  };

  options.task = mkOption {
    type = types.str;
    default = "";
    description = ''
      Specifies the name of the Nomad task associated with this service definition. Only available on group services.
      Must be set if this service definition represents a Consul Connect-native service and there is more than one task
      in the task group.
    '';
  };

  options.meta = mkOption {
    type = types.attrsOf types.str;
    default = {};
    description = ''
      Specifies a key-value map that annotates the Consul service with user-defined metadata.
    '';
  };

  options.canaryMeta = mkOption {
    type = types.attrsOf types.str;
    default = {};
    description = ''
      Specifies a key-value map that annotates the Consul service with user-defined metadata when the service is part of
      an allocation that is currently a canary. Once the canary is promoted, the registered meta will be updated to
      those specified in the meta parameter. If this is not supplied, the registered meta will be set to that of the
      meta parameter.
    '';
  };

  options.onUpdate = mkOption {
    type = types.enum ["require_healthy" "ignore_warnings" "ignore"];
    default = "require_healthy";
    description = ''
      Specifies how checks should be evaluated when determining deployment health (including a job's initial
      deployment). This allows job submitters to define certain checks as readiness checks, progressing a deployment
      even if the Service's checks are not yet healthy. Checks inherit the Service's value by default. The check status
      is not altered in Consul and is only used to determine the check's health during an update.

        - require_healthy - In order for Nomad to consider the check healthy during an update it must report as healthy.
        - ignore_warnings - If a Service Check reports as warning, Nomad will treat the check as healthy. The Check will
          still be in a warning state in Consul.
        - ignore - Any status will be treated as healthy.

      Caveat: on_update is only compatible with certain check_restart configurations. on_update = "ignore_warnings"
      requires that check_restart.ignore_warnings = true. check_restart can however specify ignore_warnings = true with
      on_update = "require_healthy". If on_update is set to ignore, check_restart must be omitted entirely.
    '';
  };
}
