{ config, lib, ... }:

{
  _module.types.Affinity = with lib; with config._module.types; with lib.types; submodule ({
    options.attribute = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.operator = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.value = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.weight = mkOption {
      type = (nullOr int);
      default = null;
    };
  });
  _module.types.CSIMountOptions = with lib; with config._module.types; with lib.types; submodule ({
    options.fsType = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.mountFlags = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
  });
  _module.types.CheckRestart = with lib; with config._module.types; with lib.types; submodule ({
    options.grace = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.ignoreWarnings = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.limit = mkOption {
      type = (nullOr int);
      default = null;
    };
  });
  _module.types.Constraint = with lib; with config._module.types; with lib.types; submodule ({
    options.attribute = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.operator = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.value = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.Consul = with lib; with config._module.types; with lib.types; submodule ({
    options.namespace = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.ConsulConnect = with lib; with config._module.types; with lib.types; submodule ({
    options.gateway = mkOption {
      type = (nullOr ConsulGateway);
      default = null;
    };
    options.native = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.sidecarService = mkOption {
      type = (nullOr ConsulSidecarService);
      default = null;
    };
    options.sidecarTask = mkOption {
      type = (nullOr SidecarTask);
      default = null;
    };
  });
  _module.types.ConsulExposeConfig = with lib; with config._module.types; with lib.types; submodule ({
    options.paths = mkOption {
      type = (nullOr (listOf ConsulExposePath));
      default = null;
    };
  });
  _module.types.ConsulExposePath = with lib; with config._module.types; with lib.types; submodule ({
    options.listenerPort = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.localPathPort = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.path = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.protocol = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.ConsulGateway = with lib; with config._module.types; with lib.types; submodule ({
    options.ingress = mkOption {
      type = (nullOr ConsulIngressConfigEntry);
      default = null;
    };
    options.mesh = mkOption {
      type = (nullOr ConsulMeshConfigEntry);
      default = null;
    };
    options.proxy = mkOption {
      type = (nullOr ConsulGatewayProxy);
      default = null;
    };
    options.terminating = mkOption {
      type = (nullOr ConsulTerminatingConfigEntry);
      default = null;
    };
  });
  _module.types.ConsulGatewayBindAddress = with lib; with config._module.types; with lib.types; submodule ({ name, ... }: {
    options.address = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.name = mkOption {
      type = str;
      default = name;
      internal = true;
      readOnly = true;
      visible = false;
    };
    options.port = mkOption {
      type = (nullOr int);
      default = null;
    };
  });
  _module.types.ConsulGatewayProxy = with lib; with config._module.types; with lib.types; submodule ({
    options.config = mkOption {
      type = (nullOr (attrsOf anything));
      default = null;
    };
    options.connectTimeout = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.envoyDnsDiscoveryType = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.envoyGatewayBindAddresses = mkOption {
      type = (nullOr (attrsOf ConsulGatewayBindAddress));
      default = null;
    };
    options.envoyGatewayBindTaggedAddresses = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.envoyGatewayNoDefaultBind = mkOption {
      type = (nullOr bool);
      default = null;
    };
  });
  _module.types.ConsulGatewayTLSConfig = with lib; with config._module.types; with lib.types; submodule ({
    options.enabled = mkOption {
      type = (nullOr bool);
      default = null;
    };
  });
  _module.types.ConsulIngressConfigEntry = with lib; with config._module.types; with lib.types; submodule ({
    options.listeners = mkOption {
      type = (nullOr (listOf ConsulIngressListener));
      default = null;
    };
    options.tls = mkOption {
      type = (nullOr ConsulGatewayTLSConfig);
      default = null;
    };
  });
  _module.types.ConsulIngressListener = with lib; with config._module.types; with lib.types; submodule ({
    options.port = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.protocol = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.services = mkOption {
      type = (nullOr (listOf ConsulIngressService));
      default = null;
    };
  });
  _module.types.ConsulIngressService = with lib; with config._module.types; with lib.types; submodule ({
    options.hosts = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.name = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.ConsulLinkedService = with lib; with config._module.types; with lib.types; submodule ({
    options.caFile = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.certFile = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.keyFile = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.name = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.sni = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.ConsulMeshConfigEntry = with lib; with config._module.types; with lib.types; submodule ({
  });
  _module.types.ConsulMeshGateway = with lib; with config._module.types; with lib.types; submodule ({
    options.mode = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.ConsulProxy = with lib; with config._module.types; with lib.types; submodule ({
    options.config = mkOption {
      type = (nullOr (attrsOf anything));
      default = null;
    };
    options.expose = mkOption {
      type = (nullOr ConsulExposeConfig);
      default = null;
    };
    options.localServiceAddress = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.localServicePort = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.upstreams = mkOption {
      type = (nullOr (listOf ConsulUpstream));
      default = null;
    };
  });
  _module.types.ConsulSidecarService = with lib; with config._module.types; with lib.types; submodule ({
    options.disableDefaultTcpCheck = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.port = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.proxy = mkOption {
      type = (nullOr ConsulProxy);
      default = null;
    };
    options.tags = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
  });
  _module.types.ConsulTerminatingConfigEntry = with lib; with config._module.types; with lib.types; submodule ({
    options.services = mkOption {
      type = (nullOr (listOf ConsulLinkedService));
      default = null;
    };
  });
  _module.types.ConsulUpstream = with lib; with config._module.types; with lib.types; submodule ({
    options.datacenter = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.destinationName = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.localBindAddress = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.localBindPort = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.meshGateway = mkOption {
      type = (nullOr ConsulMeshGateway);
      default = null;
    };
  });
  _module.types.DNSConfig = with lib; with config._module.types; with lib.types; submodule ({
    options.options = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.searches = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.servers = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
  });
  _module.types.DispatchPayloadConfig = with lib; with config._module.types; with lib.types; submodule ({
    options.file = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.EphemeralDisk = with lib; with config._module.types; with lib.types; submodule ({
    options.migrate = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.size = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.sticky = mkOption {
      type = (nullOr bool);
      default = null;
    };
  });
  _module.types.Job = with lib; with config._module.types; with lib.types; submodule ({ name, ... }: {
    options.affinities = mkOption {
      type = (nullOr (listOf Affinity));
      default = null;
    };
    options.allAtOnce = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.constraints = mkOption {
      type = (nullOr (listOf Constraint));
      default = null;
    };
    options.consulToken = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.datacenters = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.group = mkOption {
      type = (nullOr (attrsOf TaskGroup));
      default = null;
    };
    options.id = mkOption {
      type = (nullOr str);
      default = name;
      internal = true;
      readOnly = true;
      visible = false;
    };
    options.meta = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.migrate = mkOption {
      type = (nullOr MigrateStrategy);
      default = null;
    };
    options.multiregion = mkOption {
      type = (nullOr Multiregion);
      default = null;
    };
    options.name = mkOption {
      type = (nullOr str);
      default = name;
      internal = true;
      readOnly = true;
      visible = false;
    };
    options.namespace = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.parameterized = mkOption {
      type = (nullOr ParameterizedJobConfig);
      default = null;
    };
    options.periodic = mkOption {
      type = (nullOr PeriodicConfig);
      default = null;
    };
    options.priority = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.region = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.reschedule = mkOption {
      type = (nullOr ReschedulePolicy);
      default = null;
    };
    options.spreads = mkOption {
      type = (nullOr (listOf Spread));
      default = null;
    };
    options.type = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.update = mkOption {
      type = (nullOr UpdateStrategy);
      default = null;
    };
    options.vaultToken = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.LogConfig = with lib; with config._module.types; with lib.types; submodule ({
    options.maxFileSize = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.maxFiles = mkOption {
      type = (nullOr int);
      default = null;
    };
  });
  _module.types.MigrateStrategy = with lib; with config._module.types; with lib.types; submodule ({
    options.healthCheck = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.healthyDeadline = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.maxParallel = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.minHealthyTime = mkOption {
      type = (nullOr int);
      default = null;
    };
  });
  _module.types.Multiregion = with lib; with config._module.types; with lib.types; submodule ({
    options.region = mkOption {
      type = (nullOr (attrsOf MultiregionRegion));
      default = null;
    };
    options.strategy = mkOption {
      type = (nullOr MultiregionStrategy);
      default = null;
    };
  });
  _module.types.MultiregionRegion = with lib; with config._module.types; with lib.types; submodule ({ name, ... }: {
    options.count = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.datacenters = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.meta = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.name = mkOption {
      type = str;
      default = name;
      internal = true;
      readOnly = true;
      visible = false;
    };
  });
  _module.types.MultiregionStrategy = with lib; with config._module.types; with lib.types; submodule ({
    options.maxParallel = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.onFailure = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.NetworkResource = with lib; with config._module.types; with lib.types; submodule ({
    options.cidr = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.device = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.dns = mkOption {
      type = (nullOr DNSConfig);
      default = null;
    };
    options.hostname = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.ip = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.mbits = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.mode = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.port = mkOption {
      type = (nullOr (attrsOf Port));
      default = null;
    };
    options.reservedPorts = mkOption {
      type = (nullOr (attrsOf Port));
      default = null;
    };
  });
  _module.types.ParameterizedJobConfig = with lib; with config._module.types; with lib.types; submodule ({
    options.metaOptional = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.metaRequired = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.payload = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.PeriodicConfig = with lib; with config._module.types; with lib.types; submodule ({
    options.cron = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.enabled = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.prohibitOverlap = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.timeZone = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.Port = with lib; with config._module.types; with lib.types; submodule ({ name, ... }: {
    options.hostNetwork = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.label = mkOption {
      type = str;
      default = name;
      internal = true;
      readOnly = true;
      visible = false;
    };
    options.static = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.to = mkOption {
      type = (nullOr int);
      default = null;
    };
  });
  _module.types.RequestedDevice = with lib; with config._module.types; with lib.types; submodule ({ name, ... }: {
    options.affinities = mkOption {
      type = (nullOr (listOf Affinity));
      default = null;
    };
    options.constraints = mkOption {
      type = (nullOr (listOf Constraint));
      default = null;
    };
    options.count = mkOption {
      type = (nullOr ints.unsigned);
      default = null;
    };
    options.name = mkOption {
      type = str;
      default = name;
      internal = true;
      readOnly = true;
      visible = false;
    };
  });
  _module.types.ReschedulePolicy = with lib; with config._module.types; with lib.types; submodule ({
    options.attempts = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.delay = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.delayFunction = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.interval = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.maxDelay = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.unlimited = mkOption {
      type = (nullOr bool);
      default = null;
    };
  });
  _module.types.Resources = with lib; with config._module.types; with lib.types; submodule ({
    options.cores = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.cpu = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.device = mkOption {
      type = (nullOr (attrsOf RequestedDevice));
      default = null;
    };
    options.disk = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.iops = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.memory = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.memoryMax = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.networks = mkOption {
      type = (nullOr (listOf NetworkResource));
      default = null;
    };
  });
  _module.types.RestartPolicy = with lib; with config._module.types; with lib.types; submodule ({
    options.attempts = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.delay = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.interval = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.mode = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.ScalingPolicy = with lib; with config._module.types; with lib.types; submodule ({
    options.enabled = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.max = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.min = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.policy = mkOption {
      type = (nullOr (attrsOf anything));
      default = null;
    };
    options.type = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.Service = with lib; with config._module.types; with lib.types; submodule ({
    options.addressMode = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.canaryMeta = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.canaryTags = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.checkRestart = mkOption {
      type = (nullOr CheckRestart);
      default = null;
    };
    options.checks = mkOption {
      type = (nullOr (listOf ServiceCheck));
      default = null;
    };
    options.connect = mkOption {
      type = (nullOr ConsulConnect);
      default = null;
    };
    options.enableTagOverride = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.id = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.meta = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.name = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.onUpdate = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.port = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.tags = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.task = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.ServiceCheck = with lib; with config._module.types; with lib.types; submodule ({
    options.addressMode = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.args = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.body = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.checkRestart = mkOption {
      type = (nullOr CheckRestart);
      default = null;
    };
    options.command = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.expose = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.failuresBeforeCritical = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.grpcService = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.grpcUseTls = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.header = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.id = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.initialStatus = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.interval = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.method = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.name = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.onUpdate = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.path = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.port = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.protocol = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.successBeforePassing = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.task = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.timeout = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.tlsSkipVerify = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.type = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.SidecarTask = with lib; with config._module.types; with lib.types; submodule ({
    options.config = mkOption {
      type = (nullOr (attrsOf anything));
      default = null;
    };
    options.driver = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.env = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.killSignal = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.killTimeout = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.logs = mkOption {
      type = (nullOr LogConfig);
      default = null;
    };
    options.meta = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.name = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.resources = mkOption {
      type = (nullOr Resources);
      default = null;
    };
    options.shutdownDelay = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.user = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.Spread = with lib; with config._module.types; with lib.types; submodule ({
    options.attribute = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.target = mkOption {
      type = (nullOr (attrsOf SpreadTarget));
      default = null;
    };
    options.weight = mkOption {
      type = (nullOr int);
      default = null;
    };
  });
  _module.types.SpreadTarget = with lib; with config._module.types; with lib.types; submodule ({ name, ... }: {
    options.percent = mkOption {
      type = (nullOr ints.unsigned);
      default = null;
    };
    options.value = mkOption {
      type = str;
      default = name;
      internal = true;
      readOnly = true;
      visible = false;
    };
  });
  _module.types.Task = with lib; with config._module.types; with lib.types; submodule ({ name, ... }: {
    options.affinities = mkOption {
      type = (nullOr (listOf Affinity));
      default = null;
    };
    options.artifacts = mkOption {
      type = (nullOr (listOf TaskArtifact));
      default = null;
    };
    options.config = mkOption {
      type = (nullOr (attrsOf anything));
      default = null;
    };
    options.constraints = mkOption {
      type = (nullOr (listOf Constraint));
      default = null;
    };
    options.csiPlugin = mkOption {
      type = (nullOr TaskCSIPluginConfig);
      default = null;
    };
    options.dispatchPayload = mkOption {
      type = (nullOr DispatchPayloadConfig);
      default = null;
    };
    options.driver = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.env = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.killSignal = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.killTimeout = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.kind = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.leader = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.lifecycle = mkOption {
      type = (nullOr TaskLifecycle);
      default = null;
    };
    options.logs = mkOption {
      type = (nullOr LogConfig);
      default = null;
    };
    options.meta = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.name = mkOption {
      type = str;
      default = name;
      internal = true;
      readOnly = true;
      visible = false;
    };
    options.resources = mkOption {
      type = (nullOr Resources);
      default = null;
    };
    options.restart = mkOption {
      type = (nullOr RestartPolicy);
      default = null;
    };
    options.scalings = mkOption {
      type = (nullOr (listOf ScalingPolicy));
      default = null;
    };
    options.services = mkOption {
      type = (nullOr (listOf Service));
      default = null;
    };
    options.shutdownDelay = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.templates = mkOption {
      type = (nullOr (listOf Template));
      default = null;
    };
    options.user = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.vault = mkOption {
      type = (nullOr Vault);
      default = null;
    };
    options.volumeMounts = mkOption {
      type = (nullOr (listOf VolumeMount));
      default = null;
    };
  });
  _module.types.TaskArtifact = with lib; with config._module.types; with lib.types; submodule ({
    options.destination = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.headers = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.mode = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.options = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.source = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.TaskCSIPluginConfig = with lib; with config._module.types; with lib.types; submodule ({
    options.id = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.mountDir = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.type = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.TaskGroup = with lib; with config._module.types; with lib.types; submodule ({ name, ... }: {
    options.affinities = mkOption {
      type = (nullOr (listOf Affinity));
      default = null;
    };
    options.constraints = mkOption {
      type = (nullOr (listOf Constraint));
      default = null;
    };
    options.consul = mkOption {
      type = (nullOr Consul);
      default = null;
    };
    options.count = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.ephemeralDisk = mkOption {
      type = (nullOr EphemeralDisk);
      default = null;
    };
    options.meta = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.migrate = mkOption {
      type = (nullOr MigrateStrategy);
      default = null;
    };
    options.name = mkOption {
      type = str;
      default = name;
      internal = true;
      readOnly = true;
      visible = false;
    };
    options.networks = mkOption {
      type = (nullOr (listOf NetworkResource));
      default = null;
    };
    options.reschedule = mkOption {
      type = (nullOr ReschedulePolicy);
      default = null;
    };
    options.restart = mkOption {
      type = (nullOr RestartPolicy);
      default = null;
    };
    options.scaling = mkOption {
      type = (nullOr ScalingPolicy);
      default = null;
    };
    options.services = mkOption {
      type = (nullOr (listOf Service));
      default = null;
    };
    options.shutdownDelay = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.spreads = mkOption {
      type = (nullOr (listOf Spread));
      default = null;
    };
    options.stopAfterClientDisconnect = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.task = mkOption {
      type = (nullOr (attrsOf Task));
      default = null;
    };
    options.update = mkOption {
      type = (nullOr UpdateStrategy);
      default = null;
    };
    options.volume = mkOption {
      type = (nullOr (attrsOf VolumeRequest));
      default = null;
    };
  });
  _module.types.TaskLifecycle = with lib; with config._module.types; with lib.types; submodule ({
    options.hook = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.sidecar = mkOption {
      type = (nullOr bool);
      default = null;
    };
  });
  _module.types.Template = with lib; with config._module.types; with lib.types; submodule ({
    options.changeMode = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.changeSignal = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.data = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.destination = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.env = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.leftDelimiter = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.perms = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.rightDelimiter = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.source = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.splay = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.vaultGrace = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.wait = mkOption {
      type = (nullOr WaitConfig);
      default = null;
    };
  });
  _module.types.UpdateStrategy = with lib; with config._module.types; with lib.types; submodule ({
    options.autoPromote = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.autoRevert = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.canary = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.healthCheck = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.healthyDeadline = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.maxParallel = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.minHealthyTime = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.progressDeadline = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.stagger = mkOption {
      type = (nullOr int);
      default = null;
    };
  });
  _module.types.Vault = with lib; with config._module.types; with lib.types; submodule ({
    options.changeMode = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.changeSignal = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.env = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.namespace = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.policies = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
  });
  _module.types.VolumeMount = with lib; with config._module.types; with lib.types; submodule ({
    options.destination = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.propagationMode = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.readOnly = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.volume = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.VolumeRequest = with lib; with config._module.types; with lib.types; submodule ({ name, ... }: {
    options.accessMode = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.attachmentMode = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.mountOptions = mkOption {
      type = (nullOr CSIMountOptions);
      default = null;
    };
    options.name = mkOption {
      type = str;
      default = name;
      internal = true;
      readOnly = true;
      visible = false;
    };
    options.perAlloc = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.readOnly = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.source = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.type = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.WaitConfig = with lib; with config._module.types; with lib.types; submodule ({
    options.max = mkOption {
      type = int;
    };
    options.min = mkOption {
      type = int;
    };
  });
  _module.transformers.mkAffinityAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attribute && attrs.attribute != null then { LTarget = attrs.attribute; } else {})
    // (if attrs ? operator && attrs.operator != null then { Operand = attrs.operator; } else {})
    // (if attrs ? value && attrs.value != null then { RTarget = attrs.value; } else {})
    // (if attrs ? weight && attrs.weight != null then { Weight = attrs.weight; } else {})
  );
  _module.transformers.mkCSIMountOptionsAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? fsType && attrs.fsType != null then { FSType = attrs.fsType; } else {})
    // (if attrs ? mountFlags && attrs.mountFlags != null then { MountFlags = attrs.mountFlags; } else {})
  );
  _module.transformers.mkCheckRestartAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? grace && attrs.grace != null then { Grace = attrs.grace; } else {})
    // (if attrs ? ignoreWarnings && attrs.ignoreWarnings != null then { IgnoreWarnings = attrs.ignoreWarnings; } else {})
    // (if attrs ? limit && attrs.limit != null then { Limit = attrs.limit; } else {})
  );
  _module.transformers.mkConstraintAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attribute && attrs.attribute != null then { LTarget = attrs.attribute; } else {})
    // (if attrs ? operator && attrs.operator != null then { Operand = attrs.operator; } else {})
    // (if attrs ? value && attrs.value != null then { RTarget = attrs.value; } else {})
  );
  _module.transformers.mkConsulAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? namespace && attrs.namespace != null then { Namespace = attrs.namespace; } else {})
  );
  _module.transformers.mkConsulConnectAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? gateway && attrs.gateway != null then { Gateway = mkConsulGatewayAPI attrs.gateway; } else {})
    // (if attrs ? native && attrs.native != null then { Native = attrs.native; } else {})
    // (if attrs ? sidecarService && attrs.sidecarService != null then { SidecarService = mkConsulSidecarServiceAPI attrs.sidecarService; } else {})
    // (if attrs ? sidecarTask && attrs.sidecarTask != null then { SidecarTask = mkSidecarTaskAPI attrs.sidecarTask; } else {})
  );
  _module.transformers.mkConsulExposeConfigAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? paths && builtins.isList attrs.paths then { Path = builtins.map mkConsulExposePathAPI attrs.paths; } else {})
  );
  _module.transformers.mkConsulExposePathAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? listenerPort && attrs.listenerPort != null then { ListenerPort = attrs.listenerPort; } else {})
    // (if attrs ? localPathPort && attrs.localPathPort != null then { LocalPathPort = attrs.localPathPort; } else {})
    // (if attrs ? path && attrs.path != null then { Path = attrs.path; } else {})
    // (if attrs ? protocol && attrs.protocol != null then { Protocol = attrs.protocol; } else {})
  );
  _module.transformers.mkConsulGatewayAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? ingress && attrs.ingress != null then { Ingress = mkConsulIngressConfigEntryAPI attrs.ingress; } else {})
    // (if attrs ? mesh && attrs.mesh != null then { Mesh = mkConsulMeshConfigEntryAPI attrs.mesh; } else {})
    // (if attrs ? proxy && attrs.proxy != null then { Proxy = mkConsulGatewayProxyAPI attrs.proxy; } else {})
    // (if attrs ? terminating && attrs.terminating != null then { Terminating = mkConsulTerminatingConfigEntryAPI attrs.terminating; } else {})
  );
  _module.transformers.mkConsulGatewayBindAddressAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? address && attrs.address != null then { Address = attrs.address; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? port && attrs.port != null then { Port = attrs.port; } else {})
  );
  _module.transformers.mkConsulGatewayProxyAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? config && attrs.config != null then { Config = attrs.config; } else {})
    // (if attrs ? connectTimeout && attrs.connectTimeout != null then { ConnectTimeout = attrs.connectTimeout; } else {})
    // (if attrs ? envoyDnsDiscoveryType && attrs.envoyDnsDiscoveryType != null then { EnvoyDNSDiscoveryType = attrs.envoyDnsDiscoveryType; } else {})
    // (if attrs ? envoyGatewayBindAddresses && builtins.isAttrs attrs.envoyGatewayBindAddresses then { EnvoyGatewayBindAddresses = mapAttrsToList (_: mkConsulGatewayBindAddressAPI) attrs.envoyGatewayBindAddresses; } else {})
    // (if attrs ? envoyGatewayBindTaggedAddresses && attrs.envoyGatewayBindTaggedAddresses != null then { EnvoyGatewayBindTaggedAddresses = attrs.envoyGatewayBindTaggedAddresses; } else {})
    // (if attrs ? envoyGatewayNoDefaultBind && attrs.envoyGatewayNoDefaultBind != null then { EnvoyGatewayNoDefaultBind = attrs.envoyGatewayNoDefaultBind; } else {})
  );
  _module.transformers.mkConsulGatewayTLSConfigAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? enabled && attrs.enabled != null then { Enabled = attrs.enabled; } else {})
  );
  _module.transformers.mkConsulIngressConfigEntryAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? listeners && builtins.isList attrs.listeners then { Listeners = builtins.map mkConsulIngressListenerAPI attrs.listeners; } else {})
    // (if attrs ? tls && attrs.tls != null then { TLS = mkConsulGatewayTLSConfigAPI attrs.tls; } else {})
  );
  _module.transformers.mkConsulIngressListenerAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? port && attrs.port != null then { Port = attrs.port; } else {})
    // (if attrs ? protocol && attrs.protocol != null then { Protocol = attrs.protocol; } else {})
    // (if attrs ? services && builtins.isList attrs.services then { Services = builtins.map mkConsulIngressServiceAPI attrs.services; } else {})
  );
  _module.transformers.mkConsulIngressServiceAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? hosts && attrs.hosts != null then { Hosts = attrs.hosts; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
  );
  _module.transformers.mkConsulLinkedServiceAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? caFile && attrs.caFile != null then { CAFile = attrs.caFile; } else {})
    // (if attrs ? certFile && attrs.certFile != null then { CertFile = attrs.certFile; } else {})
    // (if attrs ? keyFile && attrs.keyFile != null then { KeyFile = attrs.keyFile; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? sni && attrs.sni != null then { SNI = attrs.sni; } else {})
  );
  _module.transformers.mkConsulMeshConfigEntryAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
  );
  _module.transformers.mkConsulMeshGatewayAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? mode && attrs.mode != null then { Mode = attrs.mode; } else {})
  );
  _module.transformers.mkConsulProxyAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? config && attrs.config != null then { Config = attrs.config; } else {})
    // (if attrs ? expose && attrs.expose != null then { ExposeConfig = mkConsulExposeConfigAPI attrs.expose; } else {})
    // (if attrs ? localServiceAddress && attrs.localServiceAddress != null then { LocalServiceAddress = attrs.localServiceAddress; } else {})
    // (if attrs ? localServicePort && attrs.localServicePort != null then { LocalServicePort = attrs.localServicePort; } else {})
    // (if attrs ? upstreams && builtins.isList attrs.upstreams then { Upstreams = builtins.map mkConsulUpstreamAPI attrs.upstreams; } else {})
  );
  _module.transformers.mkConsulSidecarServiceAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? disableDefaultTcpCheck && attrs.disableDefaultTcpCheck != null then { DisableDefaultTCPCheck = attrs.disableDefaultTcpCheck; } else {})
    // (if attrs ? port && attrs.port != null then { Port = attrs.port; } else {})
    // (if attrs ? proxy && attrs.proxy != null then { Proxy = mkConsulProxyAPI attrs.proxy; } else {})
    // (if attrs ? tags && attrs.tags != null then { Tags = attrs.tags; } else {})
  );
  _module.transformers.mkConsulTerminatingConfigEntryAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? services && builtins.isList attrs.services then { Services = builtins.map mkConsulLinkedServiceAPI attrs.services; } else {})
  );
  _module.transformers.mkConsulUpstreamAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? datacenter && attrs.datacenter != null then { Datacenter = attrs.datacenter; } else {})
    // (if attrs ? destinationName && attrs.destinationName != null then { DestinationName = attrs.destinationName; } else {})
    // (if attrs ? localBindAddress && attrs.localBindAddress != null then { LocalBindAddress = attrs.localBindAddress; } else {})
    // (if attrs ? localBindPort && attrs.localBindPort != null then { LocalBindPort = attrs.localBindPort; } else {})
    // (if attrs ? meshGateway && attrs.meshGateway != null then { MeshGateway = mkConsulMeshGatewayAPI attrs.meshGateway; } else {})
  );
  _module.transformers.mkDNSConfigAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? options && attrs.options != null then { Options = attrs.options; } else {})
    // (if attrs ? searches && attrs.searches != null then { Searches = attrs.searches; } else {})
    // (if attrs ? servers && attrs.servers != null then { Servers = attrs.servers; } else {})
  );
  _module.transformers.mkDispatchPayloadConfigAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? file && attrs.file != null then { File = attrs.file; } else {})
  );
  _module.transformers.mkEphemeralDiskAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? migrate && attrs.migrate != null then { Migrate = attrs.migrate; } else {})
    // (if attrs ? size && attrs.size != null then { SizeMB = attrs.size; } else {})
    // (if attrs ? sticky && attrs.sticky != null then { Sticky = attrs.sticky; } else {})
  );
  _module.transformers.mkJobAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? affinities && builtins.isList attrs.affinities then { Affinities = builtins.map mkAffinityAPI attrs.affinities; } else {})
    // (if attrs ? allAtOnce && attrs.allAtOnce != null then { AllAtOnce = attrs.allAtOnce; } else {})
    // (if attrs ? constraints && builtins.isList attrs.constraints then { Constraints = builtins.map mkConstraintAPI attrs.constraints; } else {})
    // (if attrs ? consulToken && attrs.consulToken != null then { ConsulToken = attrs.consulToken; } else {})
    // (if attrs ? datacenters && attrs.datacenters != null then { Datacenters = attrs.datacenters; } else {})
    // (if attrs ? group && builtins.isAttrs attrs.group then { TaskGroups = mapAttrsToList (_: mkTaskGroupAPI) attrs.group; } else {})
    // (if attrs ? id && attrs.id != null then { ID = attrs.id; } else {})
    // (if attrs ? meta && attrs.meta != null then { Meta = attrs.meta; } else {})
    // (if attrs ? migrate && attrs.migrate != null then { Migrate = mkMigrateStrategyAPI attrs.migrate; } else {})
    // (if attrs ? multiregion && attrs.multiregion != null then { Multiregion = mkMultiregionAPI attrs.multiregion; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? namespace && attrs.namespace != null then { Namespace = attrs.namespace; } else {})
    // (if attrs ? parameterized && attrs.parameterized != null then { ParameterizedJob = mkParameterizedJobConfigAPI attrs.parameterized; } else {})
    // (if attrs ? periodic && attrs.periodic != null then { Periodic = mkPeriodicConfigAPI attrs.periodic; } else {})
    // (if attrs ? priority && attrs.priority != null then { Priority = attrs.priority; } else {})
    // (if attrs ? region && attrs.region != null then { Region = attrs.region; } else {})
    // (if attrs ? reschedule && attrs.reschedule != null then { Reschedule = mkReschedulePolicyAPI attrs.reschedule; } else {})
    // (if attrs ? spreads && builtins.isList attrs.spreads then { Spreads = builtins.map mkSpreadAPI attrs.spreads; } else {})
    // (if attrs ? type && attrs.type != null then { Type = attrs.type; } else {})
    // (if attrs ? update && attrs.update != null then { Update = mkUpdateStrategyAPI attrs.update; } else {})
    // (if attrs ? vaultToken && attrs.vaultToken != null then { VaultToken = attrs.vaultToken; } else {})
  );
  _module.transformers.mkLogConfigAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? maxFileSize && attrs.maxFileSize != null then { MaxFileSizeMB = attrs.maxFileSize; } else {})
    // (if attrs ? maxFiles && attrs.maxFiles != null then { MaxFiles = attrs.maxFiles; } else {})
  );
  _module.transformers.mkMigrateStrategyAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? healthCheck && attrs.healthCheck != null then { HealthCheck = attrs.healthCheck; } else {})
    // (if attrs ? healthyDeadline && attrs.healthyDeadline != null then { HealthyDeadline = attrs.healthyDeadline; } else {})
    // (if attrs ? maxParallel && attrs.maxParallel != null then { MaxParallel = attrs.maxParallel; } else {})
    // (if attrs ? minHealthyTime && attrs.minHealthyTime != null then { MinHealthyTime = attrs.minHealthyTime; } else {})
  );
  _module.transformers.mkMultiregionAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? region && builtins.isAttrs attrs.region then { Regions = mapAttrsToList (_: mkMultiregionRegionAPI) attrs.region; } else {})
    // (if attrs ? strategy && attrs.strategy != null then { Strategy = mkMultiregionStrategyAPI attrs.strategy; } else {})
  );
  _module.transformers.mkMultiregionRegionAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? count && attrs.count != null then { Count = attrs.count; } else {})
    // (if attrs ? datacenters && attrs.datacenters != null then { Datacenters = attrs.datacenters; } else {})
    // (if attrs ? meta && attrs.meta != null then { Meta = attrs.meta; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
  );
  _module.transformers.mkMultiregionStrategyAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? maxParallel && attrs.maxParallel != null then { MaxParallel = attrs.maxParallel; } else {})
    // (if attrs ? onFailure && attrs.onFailure != null then { OnFailure = attrs.onFailure; } else {})
  );
  _module.transformers.mkNetworkResourceAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? cidr && attrs.cidr != null then { CIDR = attrs.cidr; } else {})
    // (if attrs ? device && attrs.device != null then { Device = attrs.device; } else {})
    // (if attrs ? dns && attrs.dns != null then { DNS = mkDNSConfigAPI attrs.dns; } else {})
    // (if attrs ? hostname && attrs.hostname != null then { Hostname = attrs.hostname; } else {})
    // (if attrs ? ip && attrs.ip != null then { IP = attrs.ip; } else {})
    // (if attrs ? mbits && attrs.mbits != null then { MBits = attrs.mbits; } else {})
    // (if attrs ? mode && attrs.mode != null then { Mode = attrs.mode; } else {})
    // (if attrs ? port && builtins.isAttrs attrs.port then { DynamicPorts = mapAttrsToList (_: mkPortAPI) attrs.port; } else {})
    // (if attrs ? reservedPorts && builtins.isAttrs attrs.reservedPorts then { ReservedPorts = mapAttrsToList (_: mkPortAPI) attrs.reservedPorts; } else {})
  );
  _module.transformers.mkParameterizedJobConfigAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? metaOptional && attrs.metaOptional != null then { MetaOptional = attrs.metaOptional; } else {})
    // (if attrs ? metaRequired && attrs.metaRequired != null then { MetaRequired = attrs.metaRequired; } else {})
    // (if attrs ? payload && attrs.payload != null then { Payload = attrs.payload; } else {})
  );
  _module.transformers.mkPeriodicConfigAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? cron && attrs.cron != null then { Spec = attrs.cron; } else {})
    // (if attrs ? enabled && attrs.enabled != null then { Enabled = attrs.enabled; } else {})
    // (if attrs ? prohibitOverlap && attrs.prohibitOverlap != null then { ProhibitOverlap = attrs.prohibitOverlap; } else {})
    // (if attrs ? timeZone && attrs.timeZone != null then { TimeZone = attrs.timeZone; } else {})
  );
  _module.transformers.mkPortAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? hostNetwork && attrs.hostNetwork != null then { HostNetwork = attrs.hostNetwork; } else {})
    // (if attrs ? label && attrs.label != null then { Label = attrs.label; } else {})
    // (if attrs ? static && attrs.static != null then { Value = attrs.static; } else {})
    // (if attrs ? to && attrs.to != null then { To = attrs.to; } else {})
  );
  _module.transformers.mkRequestedDeviceAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? affinities && builtins.isList attrs.affinities then { Affinities = builtins.map mkAffinityAPI attrs.affinities; } else {})
    // (if attrs ? constraints && builtins.isList attrs.constraints then { Constraints = builtins.map mkConstraintAPI attrs.constraints; } else {})
    // (if attrs ? count && attrs.count != null then { Count = attrs.count; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
  );
  _module.transformers.mkReschedulePolicyAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attempts && attrs.attempts != null then { Attempts = attrs.attempts; } else {})
    // (if attrs ? delay && attrs.delay != null then { Delay = attrs.delay; } else {})
    // (if attrs ? delayFunction && attrs.delayFunction != null then { DelayFunction = attrs.delayFunction; } else {})
    // (if attrs ? interval && attrs.interval != null then { Interval = attrs.interval; } else {})
    // (if attrs ? maxDelay && attrs.maxDelay != null then { MaxDelay = attrs.maxDelay; } else {})
    // (if attrs ? unlimited && attrs.unlimited != null then { Unlimited = attrs.unlimited; } else {})
  );
  _module.transformers.mkResourcesAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? cores && attrs.cores != null then { Cores = attrs.cores; } else {})
    // (if attrs ? cpu && attrs.cpu != null then { CPU = attrs.cpu; } else {})
    // (if attrs ? device && builtins.isAttrs attrs.device then { Devices = mapAttrsToList (_: mkRequestedDeviceAPI) attrs.device; } else {})
    // (if attrs ? disk && attrs.disk != null then { DiskMB = attrs.disk; } else {})
    // (if attrs ? iops && attrs.iops != null then { IOPS = attrs.iops; } else {})
    // (if attrs ? memory && attrs.memory != null then { MemoryMB = attrs.memory; } else {})
    // (if attrs ? memoryMax && attrs.memoryMax != null then { MemoryMaxMB = attrs.memoryMax; } else {})
    // (if attrs ? networks && builtins.isList attrs.networks then { Networks = builtins.map mkNetworkResourceAPI attrs.networks; } else {})
  );
  _module.transformers.mkRestartPolicyAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attempts && attrs.attempts != null then { Attempts = attrs.attempts; } else {})
    // (if attrs ? delay && attrs.delay != null then { Delay = attrs.delay; } else {})
    // (if attrs ? interval && attrs.interval != null then { Interval = attrs.interval; } else {})
    // (if attrs ? mode && attrs.mode != null then { Mode = attrs.mode; } else {})
  );
  _module.transformers.mkScalingPolicyAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? enabled && attrs.enabled != null then { Enabled = attrs.enabled; } else {})
    // (if attrs ? max && attrs.max != null then { Max = attrs.max; } else {})
    // (if attrs ? min && attrs.min != null then { Min = attrs.min; } else {})
    // (if attrs ? policy && attrs.policy != null then { Policy = attrs.policy; } else {})
    // (if attrs ? type && attrs.type != null then { Type = attrs.type; } else {})
  );
  _module.transformers.mkServiceAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? addressMode && attrs.addressMode != null then { AddressMode = attrs.addressMode; } else {})
    // (if attrs ? canaryMeta && attrs.canaryMeta != null then { CanaryMeta = attrs.canaryMeta; } else {})
    // (if attrs ? canaryTags && attrs.canaryTags != null then { CanaryTags = attrs.canaryTags; } else {})
    // (if attrs ? checkRestart && attrs.checkRestart != null then { CheckRestart = mkCheckRestartAPI attrs.checkRestart; } else {})
    // (if attrs ? checks && builtins.isList attrs.checks then { Checks = builtins.map mkServiceCheckAPI attrs.checks; } else {})
    // (if attrs ? connect && attrs.connect != null then { Connect = mkConsulConnectAPI attrs.connect; } else {})
    // (if attrs ? enableTagOverride && attrs.enableTagOverride != null then { EnableTagOverride = attrs.enableTagOverride; } else {})
    // (if attrs ? id && attrs.id != null then { Id = attrs.id; } else {})
    // (if attrs ? meta && attrs.meta != null then { Meta = attrs.meta; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? onUpdate && attrs.onUpdate != null then { OnUpdate = attrs.onUpdate; } else {})
    // (if attrs ? port && attrs.port != null then { PortLabel = attrs.port; } else {})
    // (if attrs ? tags && attrs.tags != null then { Tags = attrs.tags; } else {})
    // (if attrs ? task && attrs.task != null then { TaskName = attrs.task; } else {})
  );
  _module.transformers.mkServiceCheckAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? addressMode && attrs.addressMode != null then { AddressMode = attrs.addressMode; } else {})
    // (if attrs ? args && attrs.args != null then { Args = attrs.args; } else {})
    // (if attrs ? body && attrs.body != null then { Body = attrs.body; } else {})
    // (if attrs ? checkRestart && attrs.checkRestart != null then { CheckRestart = mkCheckRestartAPI attrs.checkRestart; } else {})
    // (if attrs ? command && attrs.command != null then { Command = attrs.command; } else {})
    // (if attrs ? expose && attrs.expose != null then { Expose = attrs.expose; } else {})
    // (if attrs ? failuresBeforeCritical && attrs.failuresBeforeCritical != null then { FailuresBeforeCritical = attrs.failuresBeforeCritical; } else {})
    // (if attrs ? grpcService && attrs.grpcService != null then { GRPCService = attrs.grpcService; } else {})
    // (if attrs ? grpcUseTls && attrs.grpcUseTls != null then { GRPCUseTLS = attrs.grpcUseTls; } else {})
    // (if attrs ? header && attrs.header != null then { Header = attrs.header; } else {})
    // (if attrs ? id && attrs.id != null then { Id = attrs.id; } else {})
    // (if attrs ? initialStatus && attrs.initialStatus != null then { InitialStatus = attrs.initialStatus; } else {})
    // (if attrs ? interval && attrs.interval != null then { Interval = attrs.interval; } else {})
    // (if attrs ? method && attrs.method != null then { Method = attrs.method; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? onUpdate && attrs.onUpdate != null then { OnUpdate = attrs.onUpdate; } else {})
    // (if attrs ? path && attrs.path != null then { Path = attrs.path; } else {})
    // (if attrs ? port && attrs.port != null then { PortLabel = attrs.port; } else {})
    // (if attrs ? protocol && attrs.protocol != null then { Protocol = attrs.protocol; } else {})
    // (if attrs ? successBeforePassing && attrs.successBeforePassing != null then { SuccessBeforePassing = attrs.successBeforePassing; } else {})
    // (if attrs ? task && attrs.task != null then { TaskName = attrs.task; } else {})
    // (if attrs ? timeout && attrs.timeout != null then { Timeout = attrs.timeout; } else {})
    // (if attrs ? tlsSkipVerify && attrs.tlsSkipVerify != null then { TLSSkipVerify = attrs.tlsSkipVerify; } else {})
    // (if attrs ? type && attrs.type != null then { Type = attrs.type; } else {})
  );
  _module.transformers.mkSidecarTaskAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? config && attrs.config != null then { Config = attrs.config; } else {})
    // (if attrs ? driver && attrs.driver != null then { Driver = attrs.driver; } else {})
    // (if attrs ? env && attrs.env != null then { Env = attrs.env; } else {})
    // (if attrs ? killSignal && attrs.killSignal != null then { KillSignal = attrs.killSignal; } else {})
    // (if attrs ? killTimeout && attrs.killTimeout != null then { KillTimeout = attrs.killTimeout; } else {})
    // (if attrs ? logs && attrs.logs != null then { LogConfig = mkLogConfigAPI attrs.logs; } else {})
    // (if attrs ? meta && attrs.meta != null then { Meta = attrs.meta; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? resources && attrs.resources != null then { Resources = mkResourcesAPI attrs.resources; } else {})
    // (if attrs ? shutdownDelay && attrs.shutdownDelay != null then { ShutdownDelay = attrs.shutdownDelay; } else {})
    // (if attrs ? user && attrs.user != null then { User = attrs.user; } else {})
  );
  _module.transformers.mkSpreadAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attribute && attrs.attribute != null then { Attribute = attrs.attribute; } else {})
    // (if attrs ? target && builtins.isAttrs attrs.target then { SpreadTarget = mapAttrsToList (_: mkSpreadTargetAPI) attrs.target; } else {})
    // (if attrs ? weight && attrs.weight != null then { Weight = attrs.weight; } else {})
  );
  _module.transformers.mkSpreadTargetAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? percent && attrs.percent != null then { Percent = attrs.percent; } else {})
    // (if attrs ? value && attrs.value != null then { Value = attrs.value; } else {})
  );
  _module.transformers.mkTaskAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? affinities && builtins.isList attrs.affinities then { Affinities = builtins.map mkAffinityAPI attrs.affinities; } else {})
    // (if attrs ? artifacts && builtins.isList attrs.artifacts then { Artifacts = builtins.map mkTaskArtifactAPI attrs.artifacts; } else {})
    // (if attrs ? config && attrs.config != null then { Config = attrs.config; } else {})
    // (if attrs ? constraints && builtins.isList attrs.constraints then { Constraints = builtins.map mkConstraintAPI attrs.constraints; } else {})
    // (if attrs ? csiPlugin && attrs.csiPlugin != null then { CSIPluginConfig = mkTaskCSIPluginConfigAPI attrs.csiPlugin; } else {})
    // (if attrs ? dispatchPayload && attrs.dispatchPayload != null then { DispatchPayload = mkDispatchPayloadConfigAPI attrs.dispatchPayload; } else {})
    // (if attrs ? driver && attrs.driver != null then { Driver = attrs.driver; } else {})
    // (if attrs ? env && attrs.env != null then { Env = attrs.env; } else {})
    // (if attrs ? killSignal && attrs.killSignal != null then { KillSignal = attrs.killSignal; } else {})
    // (if attrs ? killTimeout && attrs.killTimeout != null then { KillTimeout = attrs.killTimeout; } else {})
    // (if attrs ? kind && attrs.kind != null then { Kind = attrs.kind; } else {})
    // (if attrs ? leader && attrs.leader != null then { Leader = attrs.leader; } else {})
    // (if attrs ? lifecycle && attrs.lifecycle != null then { Lifecycle = mkTaskLifecycleAPI attrs.lifecycle; } else {})
    // (if attrs ? logs && attrs.logs != null then { LogConfig = mkLogConfigAPI attrs.logs; } else {})
    // (if attrs ? meta && attrs.meta != null then { Meta = attrs.meta; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? resources && attrs.resources != null then { Resources = mkResourcesAPI attrs.resources; } else {})
    // (if attrs ? restart && attrs.restart != null then { RestartPolicy = mkRestartPolicyAPI attrs.restart; } else {})
    // (if attrs ? scalings && builtins.isList attrs.scalings then { ScalingPolicies = builtins.map mkScalingPolicyAPI attrs.scalings; } else {})
    // (if attrs ? services && builtins.isList attrs.services then { Services = builtins.map mkServiceAPI attrs.services; } else {})
    // (if attrs ? shutdownDelay && attrs.shutdownDelay != null then { ShutdownDelay = attrs.shutdownDelay; } else {})
    // (if attrs ? templates && builtins.isList attrs.templates then { Templates = builtins.map mkTemplateAPI attrs.templates; } else {})
    // (if attrs ? user && attrs.user != null then { User = attrs.user; } else {})
    // (if attrs ? vault && attrs.vault != null then { Vault = mkVaultAPI attrs.vault; } else {})
    // (if attrs ? volumeMounts && builtins.isList attrs.volumeMounts then { VolumeMounts = builtins.map mkVolumeMountAPI attrs.volumeMounts; } else {})
  );
  _module.transformers.mkTaskArtifactAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? destination && attrs.destination != null then { RelativeDest = attrs.destination; } else {})
    // (if attrs ? headers && attrs.headers != null then { GetterHeaders = attrs.headers; } else {})
    // (if attrs ? mode && attrs.mode != null then { GetterMode = attrs.mode; } else {})
    // (if attrs ? options && attrs.options != null then { GetterOptions = attrs.options; } else {})
    // (if attrs ? source && attrs.source != null then { GetterSource = attrs.source; } else {})
  );
  _module.transformers.mkTaskCSIPluginConfigAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? id && attrs.id != null then { ID = attrs.id; } else {})
    // (if attrs ? mountDir && attrs.mountDir != null then { MountDir = attrs.mountDir; } else {})
    // (if attrs ? type && attrs.type != null then { Type = attrs.type; } else {})
  );
  _module.transformers.mkTaskGroupAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? affinities && builtins.isList attrs.affinities then { Affinities = builtins.map mkAffinityAPI attrs.affinities; } else {})
    // (if attrs ? constraints && builtins.isList attrs.constraints then { Constraints = builtins.map mkConstraintAPI attrs.constraints; } else {})
    // (if attrs ? consul && attrs.consul != null then { Consul = mkConsulAPI attrs.consul; } else {})
    // (if attrs ? count && attrs.count != null then { Count = attrs.count; } else {})
    // (if attrs ? ephemeralDisk && attrs.ephemeralDisk != null then { EphemeralDisk = mkEphemeralDiskAPI attrs.ephemeralDisk; } else {})
    // (if attrs ? meta && attrs.meta != null then { Meta = attrs.meta; } else {})
    // (if attrs ? migrate && attrs.migrate != null then { Migrate = mkMigrateStrategyAPI attrs.migrate; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? networks && builtins.isList attrs.networks then { Networks = builtins.map mkNetworkResourceAPI attrs.networks; } else {})
    // (if attrs ? reschedule && attrs.reschedule != null then { ReschedulePolicy = mkReschedulePolicyAPI attrs.reschedule; } else {})
    // (if attrs ? restart && attrs.restart != null then { RestartPolicy = mkRestartPolicyAPI attrs.restart; } else {})
    // (if attrs ? scaling && attrs.scaling != null then { Scaling = mkScalingPolicyAPI attrs.scaling; } else {})
    // (if attrs ? services && builtins.isList attrs.services then { Services = builtins.map mkServiceAPI attrs.services; } else {})
    // (if attrs ? shutdownDelay && attrs.shutdownDelay != null then { ShutdownDelay = attrs.shutdownDelay; } else {})
    // (if attrs ? spreads && builtins.isList attrs.spreads then { Spreads = builtins.map mkSpreadAPI attrs.spreads; } else {})
    // (if attrs ? stopAfterClientDisconnect && attrs.stopAfterClientDisconnect != null then { StopAfterClientDisconnect = attrs.stopAfterClientDisconnect; } else {})
    // (if attrs ? task && builtins.isAttrs attrs.task then { Tasks = mapAttrsToList (_: mkTaskAPI) attrs.task; } else {})
    // (if attrs ? update && attrs.update != null then { Update = mkUpdateStrategyAPI attrs.update; } else {})
    // (if attrs ? volume && builtins.isAttrs attrs.volume then { Volumes = mapAttrsToList (_: mkVolumeRequestAPI) attrs.volume; } else {})
  );
  _module.transformers.mkTaskLifecycleAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? hook && attrs.hook != null then { Hook = attrs.hook; } else {})
    // (if attrs ? sidecar && attrs.sidecar != null then { Sidecar = attrs.sidecar; } else {})
  );
  _module.transformers.mkTemplateAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? changeMode && attrs.changeMode != null then { ChangeMode = attrs.changeMode; } else {})
    // (if attrs ? changeSignal && attrs.changeSignal != null then { ChangeSignal = attrs.changeSignal; } else {})
    // (if attrs ? data && attrs.data != null then { EmbeddedTmpl = attrs.data; } else {})
    // (if attrs ? destination && attrs.destination != null then { DestPath = attrs.destination; } else {})
    // (if attrs ? env && attrs.env != null then { Envvars = attrs.env; } else {})
    // (if attrs ? leftDelimiter && attrs.leftDelimiter != null then { LeftDelim = attrs.leftDelimiter; } else {})
    // (if attrs ? perms && attrs.perms != null then { Perms = attrs.perms; } else {})
    // (if attrs ? rightDelimiter && attrs.rightDelimiter != null then { RightDelim = attrs.rightDelimiter; } else {})
    // (if attrs ? source && attrs.source != null then { SourcePath = attrs.source; } else {})
    // (if attrs ? splay && attrs.splay != null then { Splay = attrs.splay; } else {})
    // (if attrs ? vaultGrace && attrs.vaultGrace != null then { VaultGrace = attrs.vaultGrace; } else {})
    // (if attrs ? wait && attrs.wait != null then { Wait = mkWaitConfigAPI attrs.wait; } else {})
  );
  _module.transformers.mkUpdateStrategyAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? autoPromote && attrs.autoPromote != null then { AutoPromote = attrs.autoPromote; } else {})
    // (if attrs ? autoRevert && attrs.autoRevert != null then { AutoRevert = attrs.autoRevert; } else {})
    // (if attrs ? canary && attrs.canary != null then { Canary = attrs.canary; } else {})
    // (if attrs ? healthCheck && attrs.healthCheck != null then { HealthCheck = attrs.healthCheck; } else {})
    // (if attrs ? healthyDeadline && attrs.healthyDeadline != null then { HealthyDeadline = attrs.healthyDeadline; } else {})
    // (if attrs ? maxParallel && attrs.maxParallel != null then { MaxParallel = attrs.maxParallel; } else {})
    // (if attrs ? minHealthyTime && attrs.minHealthyTime != null then { MinHealthyTime = attrs.minHealthyTime; } else {})
    // (if attrs ? progressDeadline && attrs.progressDeadline != null then { ProgressDeadline = attrs.progressDeadline; } else {})
    // (if attrs ? stagger && attrs.stagger != null then { Stagger = attrs.stagger; } else {})
  );
  _module.transformers.mkVaultAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? changeMode && attrs.changeMode != null then { ChangeMode = attrs.changeMode; } else {})
    // (if attrs ? changeSignal && attrs.changeSignal != null then { ChangeSignal = attrs.changeSignal; } else {})
    // (if attrs ? env && attrs.env != null then { Env = attrs.env; } else {})
    // (if attrs ? namespace && attrs.namespace != null then { Namespace = attrs.namespace; } else {})
    // (if attrs ? policies && attrs.policies != null then { Policies = attrs.policies; } else {})
  );
  _module.transformers.mkVolumeMountAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? destination && attrs.destination != null then { Destination = attrs.destination; } else {})
    // (if attrs ? propagationMode && attrs.propagationMode != null then { PropagationMode = attrs.propagationMode; } else {})
    // (if attrs ? readOnly && attrs.readOnly != null then { ReadOnly = attrs.readOnly; } else {})
    // (if attrs ? volume && attrs.volume != null then { Volume = attrs.volume; } else {})
  );
  _module.transformers.mkVolumeRequestAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? accessMode && attrs.accessMode != null then { AccessMode = attrs.accessMode; } else {})
    // (if attrs ? attachmentMode && attrs.attachmentMode != null then { AttachmentMode = attrs.attachmentMode; } else {})
    // (if attrs ? mountOptions && attrs.mountOptions != null then { MountOptions = mkCSIMountOptionsAPI attrs.mountOptions; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? perAlloc && attrs.perAlloc != null then { PerAlloc = attrs.perAlloc; } else {})
    // (if attrs ? readOnly && attrs.readOnly != null then { ReadOnly = attrs.readOnly; } else {})
    // (if attrs ? source && attrs.source != null then { Source = attrs.source; } else {})
    // (if attrs ? type && attrs.type != null then { Type = attrs.type; } else {})
  );
  _module.transformers.mkWaitConfigAPI = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? max && attrs.max != null then { Max = attrs.max; } else {})
    // (if attrs ? min && attrs.min != null then { Min = attrs.min; } else {})
  );
}
