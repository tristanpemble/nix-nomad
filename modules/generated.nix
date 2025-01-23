{ config, lib, ... }:

{
  _module.types.Action = with lib; with config._module.types; with lib.types; submodule ({ name, ... }: {
    options.args = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.command = mkOption {
      type = str;
    };
    options.name = mkOption {
      type = str;
      default = name;
      internal = true;
      visible = false;
    };
  });
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
  _module.types.CniConfig = with lib; with config._module.types; with lib.types; submodule ({
    options.args = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
  });
  _module.types.CsiMountOptions = with lib; with config._module.types; with lib.types; submodule ({
    options.fsType = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.mountFlags = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
  });
  _module.types.ChangeScript = with lib; with config._module.types; with lib.types; submodule ({
    options.args = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.command = mkOption {
      type = str;
    };
    options.failOnError = mkOption {
      type = bool;
    };
    options.timeout = mkOption {
      type = (nullOr int);
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
    options.cluster = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.namespace = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.partition = mkOption {
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
  _module.types.ConsulGatewayTlsConfig = with lib; with config._module.types; with lib.types; submodule ({
    options.cipherSuites = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.enabled = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.sds = mkOption {
      type = (nullOr ConsulGatewayTlssdsConfig);
      default = null;
    };
    options.tlsMaxVersion = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.tlsMinVersion = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.ConsulGatewayTlssdsConfig = with lib; with config._module.types; with lib.types; submodule ({
    options.certResource = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.clusterName = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.ConsulHttpHeaderModifiers = with lib; with config._module.types; with lib.types; submodule ({
    options.add = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.remove = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.set = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
  });
  _module.types.ConsulIngressConfigEntry = with lib; with config._module.types; with lib.types; submodule ({
    options.listeners = mkOption {
      type = (nullOr (listOf ConsulIngressListener));
      default = null;
    };
    options.tls = mkOption {
      type = (nullOr ConsulGatewayTlsConfig);
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
    options.maxConcurrentRequests = mkOption {
      type = (nullOr ints.unsigned);
      default = null;
    };
    options.maxConnections = mkOption {
      type = (nullOr ints.unsigned);
      default = null;
    };
    options.maxPendingRequests = mkOption {
      type = (nullOr ints.unsigned);
      default = null;
    };
    options.name = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.requestHeaders = mkOption {
      type = (nullOr ConsulHttpHeaderModifiers);
      default = null;
    };
    options.responseHeaders = mkOption {
      type = (nullOr ConsulHttpHeaderModifiers);
      default = null;
    };
    options.tls = mkOption {
      type = (nullOr ConsulGatewayTlsConfig);
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
    options.transparentProxy = mkOption {
      type = (nullOr ConsulTransparentProxy);
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
    options.meta = mkOption {
      type = (nullOr (attrsOf str));
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
  _module.types.ConsulTransparentProxy = with lib; with config._module.types; with lib.types; submodule ({
    options.excludeInboundPorts = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.excludeOutboundCidrs = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.excludeOutboundPorts = mkOption {
      type = (nullOr (listOf ints.unsigned));
      default = null;
    };
    options.excludeUids = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.noDns = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.outboundPort = mkOption {
      type = (nullOr ints.unsigned);
      default = null;
    };
    options.uid = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.ConsulUpstream = with lib; with config._module.types; with lib.types; submodule ({
    options.config = mkOption {
      type = (nullOr (attrsOf anything));
      default = null;
    };
    options.datacenter = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.destinationName = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.destinationNamespace = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.destinationPartition = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.destinationPeer = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.destinationType = mkOption {
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
    options.localBindSocketMode = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.localBindSocketPath = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.meshGateway = mkOption {
      type = (nullOr ConsulMeshGateway);
      default = null;
    };
  });
  _module.types.DnsConfig = with lib; with config._module.types; with lib.types; submodule ({
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
  _module.types.DisconnectStrategy = with lib; with config._module.types; with lib.types; submodule ({
    options.lostAfter = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.reconcile = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.replace = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.stopOnClientAfter = mkOption {
      type = (nullOr int);
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
      visible = false;
    };
    options.namespace = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.nodePool = mkOption {
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
    options.ui = mkOption {
      type = (nullOr JobUiConfig);
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
  _module.types.JobUiConfig = with lib; with config._module.types; with lib.types; submodule ({
    options.description = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.links = mkOption {
      type = (nullOr (listOf JobUiLink));
      default = null;
    };
  });
  _module.types.JobUiLink = with lib; with config._module.types; with lib.types; submodule ({
    options.label = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.url = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.LogConfig = with lib; with config._module.types; with lib.types; submodule ({
    options.disabled = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.enabled = mkOption {
      type = (nullOr bool);
      default = null;
    };
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
      visible = false;
    };
    options.nodePool = mkOption {
      type = (nullOr str);
      default = null;
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
  _module.types.NumaResource = with lib; with config._module.types; with lib.types; submodule ({
    options.affinity = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.devices = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
  });
  _module.types.NetworkResource = with lib; with config._module.types; with lib.types; submodule ({
    options.cidr = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.cni = mkOption {
      type = (nullOr CniConfig);
      default = null;
    };
    options.device = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.dns = mkOption {
      type = (nullOr DnsConfig);
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
    options.crons = mkOption {
      type = (nullOr (listOf str));
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
    options.ignoreCollision = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.label = mkOption {
      type = str;
      default = name;
      internal = true;
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
    options.numa = mkOption {
      type = (nullOr NumaResource);
      default = null;
    };
    options.secrets = mkOption {
      type = (nullOr int);
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
    options.renderTemplates = mkOption {
      type = (nullOr bool);
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
    options.address = mkOption {
      type = (nullOr str);
      default = null;
    };
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
    options.cluster = mkOption {
      type = (nullOr str);
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
    options.identity = mkOption {
      type = (nullOr WorkloadIdentity);
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
    options.provider = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.taggedAddresses = mkOption {
      type = (nullOr (attrsOf str));
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
    options.weights = mkOption {
      type = (nullOr ServiceWeights);
      default = null;
    };
  });
  _module.types.ServiceCheck = with lib; with config._module.types; with lib.types; submodule ({
    options.addressMode = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.advertise = mkOption {
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
    options.failuresBeforeWarning = mkOption {
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
    options.notes = mkOption {
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
    options.tlsServerName = mkOption {
      type = (nullOr str);
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
  _module.types.ServiceWeights = with lib; with config._module.types; with lib.types; submodule ({
    options.passing = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.warning = mkOption {
      type = (nullOr int);
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
    options.volumeMounts = mkOption {
      type = (nullOr (listOf VolumeMount));
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
      visible = false;
    };
  });
  _module.types.Task = with lib; with config._module.types; with lib.types; submodule ({ name, ... }: {
    options.action = mkOption {
      type = (nullOr (attrsOf Action));
      default = null;
    };
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
    options.consul = mkOption {
      type = (nullOr Consul);
      default = null;
    };
    options.csiPlugin = mkOption {
      type = (nullOr TaskCsiPluginConfig);
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
    options.identities = mkOption {
      type = (nullOr (listOf WorkloadIdentity));
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
    options.schedule = mkOption {
      type = (nullOr TaskSchedule);
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
    options.chown = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.destination = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.headers = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.insecure = mkOption {
      type = (nullOr bool);
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
  _module.types.TaskCsiPluginConfig = with lib; with config._module.types; with lib.types; submodule ({
    options.healthTimeout = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.id = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.mountDir = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.stagePublishBaseDir = mkOption {
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
    options.disconnect = mkOption {
      type = (nullOr DisconnectStrategy);
      default = null;
    };
    options.ephemeralDisk = mkOption {
      type = (nullOr EphemeralDisk);
      default = null;
    };
    options.maxClientDisconnect = mkOption {
      type = (nullOr int);
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
      visible = false;
    };
    options.networks = mkOption {
      type = (nullOr (listOf NetworkResource));
      default = null;
    };
    options.preventRescheduleOnLost = mkOption {
      type = (nullOr bool);
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
  _module.types.TaskSchedule = with lib; with config._module.types; with lib.types; submodule ({
    options.cron = mkOption {
      type = (nullOr TaskScheduleCron);
      default = null;
    };
  });
  _module.types.TaskScheduleCron = with lib; with config._module.types; with lib.types; submodule ({
    options.end = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.start = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.timezone = mkOption {
      type = (nullOr str);
      default = null;
    };
  });
  _module.types.Template = with lib; with config._module.types; with lib.types; submodule ({
    options.changeMode = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.changeScript = mkOption {
      type = (nullOr ChangeScript);
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
    options.errorOnMissingKey = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.gid = mkOption {
      type = (nullOr int);
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
    options.uid = mkOption {
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
    options.allowTokenExpiration = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.changeMode = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.changeSignal = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.cluster = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.disableFile = mkOption {
      type = (nullOr bool);
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
    options.role = mkOption {
      type = (nullOr str);
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
    options.selinuxLabel = mkOption {
      type = (nullOr str);
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
      type = (nullOr CsiMountOptions);
      default = null;
    };
    options.name = mkOption {
      type = str;
      default = name;
      internal = true;
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
    options.sticky = mkOption {
      type = (nullOr bool);
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
  _module.types.WorkloadIdentity = with lib; with config._module.types; with lib.types; submodule ({
    options.aud = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
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
    options.file = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.filepath = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.name = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.serviceName = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.ttl = mkOption {
      type = (nullOr int);
      default = null;
    };
  });

  # Convert a Action Nix module into a JSON object.
  _module.transformers.Action.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? args && attrs.args != null then { Args = attrs.args; } else {})
    // (if attrs ? command && attrs.command != null then { Command = attrs.command; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
  );

  # Convert a Action JSON object into a Nix module.
  _module.transformers.Action.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Args && attrs.Args != null then { args = attrs.Args; } else {})
    // (if attrs ? Command && attrs.Command != null then { command = attrs.Command; } else {})
    // (if attrs ? Name && attrs.Name != null then { name = attrs.Name; } else {})
  );

  # Convert a Affinity Nix module into a JSON object.
  _module.transformers.Affinity.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attribute && attrs.attribute != null then { LTarget = attrs.attribute; } else {})
    // (if attrs ? operator && attrs.operator != null then { Operand = attrs.operator; } else {})
    // (if attrs ? value && attrs.value != null then { RTarget = attrs.value; } else {})
    // (if attrs ? weight && attrs.weight != null then { Weight = attrs.weight; } else {})
  );

  # Convert a Affinity JSON object into a Nix module.
  _module.transformers.Affinity.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? LTarget && attrs.LTarget != null then { attribute = attrs.LTarget; } else {})
    // (if attrs ? Operand && attrs.Operand != null then { operator = attrs.Operand; } else {})
    // (if attrs ? RTarget && attrs.RTarget != null then { value = attrs.RTarget; } else {})
    // (if attrs ? Weight && attrs.Weight != null then { weight = attrs.Weight; } else {})
  );

  # Convert a CniConfig Nix module into a JSON object.
  _module.transformers.CniConfig.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? args && attrs.args != null then { Args = attrs.args; } else {})
  );

  # Convert a CniConfig JSON object into a Nix module.
  _module.transformers.CniConfig.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Args && attrs.Args != null then { args = attrs.Args; } else {})
  );

  # Convert a CsiMountOptions Nix module into a JSON object.
  _module.transformers.CsiMountOptions.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? fsType && attrs.fsType != null then { FSType = attrs.fsType; } else {})
    // (if attrs ? mountFlags && attrs.mountFlags != null then { MountFlags = attrs.mountFlags; } else {})
  );

  # Convert a CsiMountOptions JSON object into a Nix module.
  _module.transformers.CsiMountOptions.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? FSType && attrs.FSType != null then { fsType = attrs.FSType; } else {})
    // (if attrs ? MountFlags && attrs.MountFlags != null then { mountFlags = attrs.MountFlags; } else {})
  );

  # Convert a ChangeScript Nix module into a JSON object.
  _module.transformers.ChangeScript.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? args && attrs.args != null then { Args = attrs.args; } else {})
    // (if attrs ? command && attrs.command != null then { Command = attrs.command; } else {})
    // (if attrs ? failOnError && attrs.failOnError != null then { FailOnError = attrs.failOnError; } else {})
    // (if attrs ? timeout && attrs.timeout != null then { Timeout = attrs.timeout; } else {})
  );

  # Convert a ChangeScript JSON object into a Nix module.
  _module.transformers.ChangeScript.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Args && attrs.Args != null then { args = attrs.Args; } else {})
    // (if attrs ? Command && attrs.Command != null then { command = attrs.Command; } else {})
    // (if attrs ? FailOnError && attrs.FailOnError != null then { failOnError = attrs.FailOnError; } else {})
    // (if attrs ? Timeout && attrs.Timeout != null then { timeout = attrs.Timeout; } else {})
  );

  # Convert a CheckRestart Nix module into a JSON object.
  _module.transformers.CheckRestart.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? grace && attrs.grace != null then { Grace = attrs.grace; } else {})
    // (if attrs ? ignoreWarnings && attrs.ignoreWarnings != null then { IgnoreWarnings = attrs.ignoreWarnings; } else {})
    // (if attrs ? limit && attrs.limit != null then { Limit = attrs.limit; } else {})
  );

  # Convert a CheckRestart JSON object into a Nix module.
  _module.transformers.CheckRestart.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Grace && attrs.Grace != null then { grace = attrs.Grace; } else {})
    // (if attrs ? IgnoreWarnings && attrs.IgnoreWarnings != null then { ignoreWarnings = attrs.IgnoreWarnings; } else {})
    // (if attrs ? Limit && attrs.Limit != null then { limit = attrs.Limit; } else {})
  );

  # Convert a Constraint Nix module into a JSON object.
  _module.transformers.Constraint.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attribute && attrs.attribute != null then { LTarget = attrs.attribute; } else {})
    // (if attrs ? operator && attrs.operator != null then { Operand = attrs.operator; } else {})
    // (if attrs ? value && attrs.value != null then { RTarget = attrs.value; } else {})
  );

  # Convert a Constraint JSON object into a Nix module.
  _module.transformers.Constraint.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? LTarget && attrs.LTarget != null then { attribute = attrs.LTarget; } else {})
    // (if attrs ? Operand && attrs.Operand != null then { operator = attrs.Operand; } else {})
    // (if attrs ? RTarget && attrs.RTarget != null then { value = attrs.RTarget; } else {})
  );

  # Convert a Consul Nix module into a JSON object.
  _module.transformers.Consul.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? cluster && attrs.cluster != null then { Cluster = attrs.cluster; } else {})
    // (if attrs ? namespace && attrs.namespace != null then { Namespace = attrs.namespace; } else {})
    // (if attrs ? partition && attrs.partition != null then { Partition = attrs.partition; } else {})
  );

  # Convert a Consul JSON object into a Nix module.
  _module.transformers.Consul.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Cluster && attrs.Cluster != null then { cluster = attrs.Cluster; } else {})
    // (if attrs ? Namespace && attrs.Namespace != null then { namespace = attrs.Namespace; } else {})
    // (if attrs ? Partition && attrs.Partition != null then { partition = attrs.Partition; } else {})
  );

  # Convert a ConsulConnect Nix module into a JSON object.
  _module.transformers.ConsulConnect.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? gateway && attrs.gateway != null then { Gateway = ConsulGateway.toJSON attrs.gateway; } else {})
    // (if attrs ? native && attrs.native != null then { Native = attrs.native; } else {})
    // (if attrs ? sidecarService && attrs.sidecarService != null then { SidecarService = ConsulSidecarService.toJSON attrs.sidecarService; } else {})
    // (if attrs ? sidecarTask && attrs.sidecarTask != null then { SidecarTask = SidecarTask.toJSON attrs.sidecarTask; } else {})
  );

  # Convert a ConsulConnect JSON object into a Nix module.
  _module.transformers.ConsulConnect.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Gateway && attrs.Gateway != null then { gateway = ConsulGateway.fromJSON attrs.Gateway; } else {})
    // (if attrs ? Native && attrs.Native != null then { native = attrs.Native; } else {})
    // (if attrs ? SidecarService && attrs.SidecarService != null then { sidecarService = ConsulSidecarService.fromJSON attrs.SidecarService; } else {})
    // (if attrs ? SidecarTask && attrs.SidecarTask != null then { sidecarTask = SidecarTask.fromJSON attrs.SidecarTask; } else {})
  );

  # Convert a ConsulExposeConfig Nix module into a JSON object.
  _module.transformers.ConsulExposeConfig.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? paths && builtins.isList attrs.paths then { Paths = builtins.map ConsulExposePath.toJSON attrs.paths; } else {})
  );

  # Convert a ConsulExposeConfig JSON object into a Nix module.
  _module.transformers.ConsulExposeConfig.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Paths && builtins.isList attrs.Paths then { paths = builtins.map ConsulExposePath.fromJSON attrs.Paths; } else {})
  );

  # Convert a ConsulExposePath Nix module into a JSON object.
  _module.transformers.ConsulExposePath.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? listenerPort && attrs.listenerPort != null then { ListenerPort = attrs.listenerPort; } else {})
    // (if attrs ? localPathPort && attrs.localPathPort != null then { LocalPathPort = attrs.localPathPort; } else {})
    // (if attrs ? path && attrs.path != null then { Path = attrs.path; } else {})
    // (if attrs ? protocol && attrs.protocol != null then { Protocol = attrs.protocol; } else {})
  );

  # Convert a ConsulExposePath JSON object into a Nix module.
  _module.transformers.ConsulExposePath.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? ListenerPort && attrs.ListenerPort != null then { listenerPort = attrs.ListenerPort; } else {})
    // (if attrs ? LocalPathPort && attrs.LocalPathPort != null then { localPathPort = attrs.LocalPathPort; } else {})
    // (if attrs ? Path && attrs.Path != null then { path = attrs.Path; } else {})
    // (if attrs ? Protocol && attrs.Protocol != null then { protocol = attrs.Protocol; } else {})
  );

  # Convert a ConsulGateway Nix module into a JSON object.
  _module.transformers.ConsulGateway.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? ingress && attrs.ingress != null then { Ingress = ConsulIngressConfigEntry.toJSON attrs.ingress; } else {})
    // (if attrs ? mesh && attrs.mesh != null then { Mesh = ConsulMeshConfigEntry.toJSON attrs.mesh; } else {})
    // (if attrs ? proxy && attrs.proxy != null then { Proxy = ConsulGatewayProxy.toJSON attrs.proxy; } else {})
    // (if attrs ? terminating && attrs.terminating != null then { Terminating = ConsulTerminatingConfigEntry.toJSON attrs.terminating; } else {})
  );

  # Convert a ConsulGateway JSON object into a Nix module.
  _module.transformers.ConsulGateway.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Ingress && attrs.Ingress != null then { ingress = ConsulIngressConfigEntry.fromJSON attrs.Ingress; } else {})
    // (if attrs ? Mesh && attrs.Mesh != null then { mesh = ConsulMeshConfigEntry.fromJSON attrs.Mesh; } else {})
    // (if attrs ? Proxy && attrs.Proxy != null then { proxy = ConsulGatewayProxy.fromJSON attrs.Proxy; } else {})
    // (if attrs ? Terminating && attrs.Terminating != null then { terminating = ConsulTerminatingConfigEntry.fromJSON attrs.Terminating; } else {})
  );

  # Convert a ConsulGatewayBindAddress Nix module into a JSON object.
  _module.transformers.ConsulGatewayBindAddress.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? address && attrs.address != null then { Address = attrs.address; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? port && attrs.port != null then { Port = attrs.port; } else {})
  );

  # Convert a ConsulGatewayBindAddress JSON object into a Nix module.
  _module.transformers.ConsulGatewayBindAddress.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Address && attrs.Address != null then { address = attrs.Address; } else {})
    // (if attrs ? Name && attrs.Name != null then { name = attrs.Name; } else {})
    // (if attrs ? Port && attrs.Port != null then { port = attrs.Port; } else {})
  );

  # Convert a ConsulGatewayProxy Nix module into a JSON object.
  _module.transformers.ConsulGatewayProxy.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? config && attrs.config != null then { Config = attrs.config; } else {})
    // (if attrs ? connectTimeout && attrs.connectTimeout != null then { ConnectTimeout = attrs.connectTimeout; } else {})
    // (if attrs ? envoyDnsDiscoveryType && attrs.envoyDnsDiscoveryType != null then { EnvoyDNSDiscoveryType = attrs.envoyDnsDiscoveryType; } else {})
    // (if attrs ? envoyGatewayBindAddresses && builtins.isAttrs attrs.envoyGatewayBindAddresses then { EnvoyGatewayBindAddresses = mapAttrs (_: ConsulGatewayBindAddress.toJSON) attrs.envoyGatewayBindAddresses; } else {})
    // (if attrs ? envoyGatewayBindTaggedAddresses && attrs.envoyGatewayBindTaggedAddresses != null then { EnvoyGatewayBindTaggedAddresses = attrs.envoyGatewayBindTaggedAddresses; } else {})
    // (if attrs ? envoyGatewayNoDefaultBind && attrs.envoyGatewayNoDefaultBind != null then { EnvoyGatewayNoDefaultBind = attrs.envoyGatewayNoDefaultBind; } else {})
  );

  # Convert a ConsulGatewayProxy JSON object into a Nix module.
  _module.transformers.ConsulGatewayProxy.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Config && attrs.Config != null then { config = attrs.Config; } else {})
    // (if attrs ? ConnectTimeout && attrs.ConnectTimeout != null then { connectTimeout = attrs.ConnectTimeout; } else {})
    // (if attrs ? EnvoyDNSDiscoveryType && attrs.EnvoyDNSDiscoveryType != null then { envoyDnsDiscoveryType = attrs.EnvoyDNSDiscoveryType; } else {})
    // (if attrs ? EnvoyGatewayBindAddresses && builtins.isList attrs.EnvoyGatewayBindAddresses then { envoyGatewayBindAddresses = builtins.listToAttrs (builtins.map (v: nameValuePair v.Name (ConsulGatewayBindAddress.fromJSON v)) attrs.EnvoyGatewayBindAddresses); } else {})
    // (if attrs ? EnvoyGatewayBindTaggedAddresses && attrs.EnvoyGatewayBindTaggedAddresses != null then { envoyGatewayBindTaggedAddresses = attrs.EnvoyGatewayBindTaggedAddresses; } else {})
    // (if attrs ? EnvoyGatewayNoDefaultBind && attrs.EnvoyGatewayNoDefaultBind != null then { envoyGatewayNoDefaultBind = attrs.EnvoyGatewayNoDefaultBind; } else {})
  );

  # Convert a ConsulGatewayTlsConfig Nix module into a JSON object.
  _module.transformers.ConsulGatewayTlsConfig.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? cipherSuites && attrs.cipherSuites != null then { CipherSuites = attrs.cipherSuites; } else {})
    // (if attrs ? enabled && attrs.enabled != null then { Enabled = attrs.enabled; } else {})
    // (if attrs ? sds && attrs.sds != null then { SDS = ConsulGatewayTlssdsConfig.toJSON attrs.sds; } else {})
    // (if attrs ? tlsMaxVersion && attrs.tlsMaxVersion != null then { TLSMaxVersion = attrs.tlsMaxVersion; } else {})
    // (if attrs ? tlsMinVersion && attrs.tlsMinVersion != null then { TLSMinVersion = attrs.tlsMinVersion; } else {})
  );

  # Convert a ConsulGatewayTlsConfig JSON object into a Nix module.
  _module.transformers.ConsulGatewayTlsConfig.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? CipherSuites && attrs.CipherSuites != null then { cipherSuites = attrs.CipherSuites; } else {})
    // (if attrs ? Enabled && attrs.Enabled != null then { enabled = attrs.Enabled; } else {})
    // (if attrs ? SDS && attrs.SDS != null then { sds = ConsulGatewayTlssdsConfig.fromJSON attrs.SDS; } else {})
    // (if attrs ? TLSMaxVersion && attrs.TLSMaxVersion != null then { tlsMaxVersion = attrs.TLSMaxVersion; } else {})
    // (if attrs ? TLSMinVersion && attrs.TLSMinVersion != null then { tlsMinVersion = attrs.TLSMinVersion; } else {})
  );

  # Convert a ConsulGatewayTlssdsConfig Nix module into a JSON object.
  _module.transformers.ConsulGatewayTlssdsConfig.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? certResource && attrs.certResource != null then { CertResource = attrs.certResource; } else {})
    // (if attrs ? clusterName && attrs.clusterName != null then { ClusterName = attrs.clusterName; } else {})
  );

  # Convert a ConsulGatewayTlssdsConfig JSON object into a Nix module.
  _module.transformers.ConsulGatewayTlssdsConfig.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? CertResource && attrs.CertResource != null then { certResource = attrs.CertResource; } else {})
    // (if attrs ? ClusterName && attrs.ClusterName != null then { clusterName = attrs.ClusterName; } else {})
  );

  # Convert a ConsulHttpHeaderModifiers Nix module into a JSON object.
  _module.transformers.ConsulHttpHeaderModifiers.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? add && attrs.add != null then { Add = attrs.add; } else {})
    // (if attrs ? remove && attrs.remove != null then { Remove = attrs.remove; } else {})
    // (if attrs ? set && attrs.set != null then { Set = attrs.set; } else {})
  );

  # Convert a ConsulHttpHeaderModifiers JSON object into a Nix module.
  _module.transformers.ConsulHttpHeaderModifiers.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Add && attrs.Add != null then { add = attrs.Add; } else {})
    // (if attrs ? Remove && attrs.Remove != null then { remove = attrs.Remove; } else {})
    // (if attrs ? Set && attrs.Set != null then { set = attrs.Set; } else {})
  );

  # Convert a ConsulIngressConfigEntry Nix module into a JSON object.
  _module.transformers.ConsulIngressConfigEntry.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? listeners && builtins.isList attrs.listeners then { Listeners = builtins.map ConsulIngressListener.toJSON attrs.listeners; } else {})
    // (if attrs ? tls && attrs.tls != null then { TLS = ConsulGatewayTlsConfig.toJSON attrs.tls; } else {})
  );

  # Convert a ConsulIngressConfigEntry JSON object into a Nix module.
  _module.transformers.ConsulIngressConfigEntry.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Listeners && builtins.isList attrs.Listeners then { listeners = builtins.map ConsulIngressListener.fromJSON attrs.Listeners; } else {})
    // (if attrs ? TLS && attrs.TLS != null then { tls = ConsulGatewayTlsConfig.fromJSON attrs.TLS; } else {})
  );

  # Convert a ConsulIngressListener Nix module into a JSON object.
  _module.transformers.ConsulIngressListener.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? port && attrs.port != null then { Port = attrs.port; } else {})
    // (if attrs ? protocol && attrs.protocol != null then { Protocol = attrs.protocol; } else {})
    // (if attrs ? services && builtins.isList attrs.services then { Services = builtins.map ConsulIngressService.toJSON attrs.services; } else {})
  );

  # Convert a ConsulIngressListener JSON object into a Nix module.
  _module.transformers.ConsulIngressListener.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Port && attrs.Port != null then { port = attrs.Port; } else {})
    // (if attrs ? Protocol && attrs.Protocol != null then { protocol = attrs.Protocol; } else {})
    // (if attrs ? Services && builtins.isList attrs.Services then { services = builtins.map ConsulIngressService.fromJSON attrs.Services; } else {})
  );

  # Convert a ConsulIngressService Nix module into a JSON object.
  _module.transformers.ConsulIngressService.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? hosts && attrs.hosts != null then { Hosts = attrs.hosts; } else {})
    // (if attrs ? maxConcurrentRequests && attrs.maxConcurrentRequests != null then { MaxConcurrentRequests = attrs.maxConcurrentRequests; } else {})
    // (if attrs ? maxConnections && attrs.maxConnections != null then { MaxConnections = attrs.maxConnections; } else {})
    // (if attrs ? maxPendingRequests && attrs.maxPendingRequests != null then { MaxPendingRequests = attrs.maxPendingRequests; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? requestHeaders && attrs.requestHeaders != null then { RequestHeaders = ConsulHttpHeaderModifiers.toJSON attrs.requestHeaders; } else {})
    // (if attrs ? responseHeaders && attrs.responseHeaders != null then { ResponseHeaders = ConsulHttpHeaderModifiers.toJSON attrs.responseHeaders; } else {})
    // (if attrs ? tls && attrs.tls != null then { TLS = ConsulGatewayTlsConfig.toJSON attrs.tls; } else {})
  );

  # Convert a ConsulIngressService JSON object into a Nix module.
  _module.transformers.ConsulIngressService.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Hosts && attrs.Hosts != null then { hosts = attrs.Hosts; } else {})
    // (if attrs ? MaxConcurrentRequests && attrs.MaxConcurrentRequests != null then { maxConcurrentRequests = attrs.MaxConcurrentRequests; } else {})
    // (if attrs ? MaxConnections && attrs.MaxConnections != null then { maxConnections = attrs.MaxConnections; } else {})
    // (if attrs ? MaxPendingRequests && attrs.MaxPendingRequests != null then { maxPendingRequests = attrs.MaxPendingRequests; } else {})
    // (if attrs ? Name && attrs.Name != null then { name = attrs.Name; } else {})
    // (if attrs ? RequestHeaders && attrs.RequestHeaders != null then { requestHeaders = ConsulHttpHeaderModifiers.fromJSON attrs.RequestHeaders; } else {})
    // (if attrs ? ResponseHeaders && attrs.ResponseHeaders != null then { responseHeaders = ConsulHttpHeaderModifiers.fromJSON attrs.ResponseHeaders; } else {})
    // (if attrs ? TLS && attrs.TLS != null then { tls = ConsulGatewayTlsConfig.fromJSON attrs.TLS; } else {})
  );

  # Convert a ConsulLinkedService Nix module into a JSON object.
  _module.transformers.ConsulLinkedService.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? caFile && attrs.caFile != null then { CAFile = attrs.caFile; } else {})
    // (if attrs ? certFile && attrs.certFile != null then { CertFile = attrs.certFile; } else {})
    // (if attrs ? keyFile && attrs.keyFile != null then { KeyFile = attrs.keyFile; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? sni && attrs.sni != null then { SNI = attrs.sni; } else {})
  );

  # Convert a ConsulLinkedService JSON object into a Nix module.
  _module.transformers.ConsulLinkedService.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? CAFile && attrs.CAFile != null then { caFile = attrs.CAFile; } else {})
    // (if attrs ? CertFile && attrs.CertFile != null then { certFile = attrs.CertFile; } else {})
    // (if attrs ? KeyFile && attrs.KeyFile != null then { keyFile = attrs.KeyFile; } else {})
    // (if attrs ? Name && attrs.Name != null then { name = attrs.Name; } else {})
    // (if attrs ? SNI && attrs.SNI != null then { sni = attrs.SNI; } else {})
  );

  # Convert a ConsulMeshConfigEntry Nix module into a JSON object.
  _module.transformers.ConsulMeshConfigEntry.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
  );

  # Convert a ConsulMeshConfigEntry JSON object into a Nix module.
  _module.transformers.ConsulMeshConfigEntry.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
  );

  # Convert a ConsulMeshGateway Nix module into a JSON object.
  _module.transformers.ConsulMeshGateway.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? mode && attrs.mode != null then { Mode = attrs.mode; } else {})
  );

  # Convert a ConsulMeshGateway JSON object into a Nix module.
  _module.transformers.ConsulMeshGateway.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Mode && attrs.Mode != null then { mode = attrs.Mode; } else {})
  );

  # Convert a ConsulProxy Nix module into a JSON object.
  _module.transformers.ConsulProxy.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? config && attrs.config != null then { Config = attrs.config; } else {})
    // (if attrs ? expose && attrs.expose != null then { Expose = ConsulExposeConfig.toJSON attrs.expose; } else {})
    // (if attrs ? localServiceAddress && attrs.localServiceAddress != null then { LocalServiceAddress = attrs.localServiceAddress; } else {})
    // (if attrs ? localServicePort && attrs.localServicePort != null then { LocalServicePort = attrs.localServicePort; } else {})
    // (if attrs ? transparentProxy && attrs.transparentProxy != null then { TransparentProxy = ConsulTransparentProxy.toJSON attrs.transparentProxy; } else {})
    // (if attrs ? upstreams && builtins.isList attrs.upstreams then { Upstreams = builtins.map ConsulUpstream.toJSON attrs.upstreams; } else {})
  );

  # Convert a ConsulProxy JSON object into a Nix module.
  _module.transformers.ConsulProxy.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Config && attrs.Config != null then { config = attrs.Config; } else {})
    // (if attrs ? Expose && attrs.Expose != null then { expose = ConsulExposeConfig.fromJSON attrs.Expose; } else {})
    // (if attrs ? LocalServiceAddress && attrs.LocalServiceAddress != null then { localServiceAddress = attrs.LocalServiceAddress; } else {})
    // (if attrs ? LocalServicePort && attrs.LocalServicePort != null then { localServicePort = attrs.LocalServicePort; } else {})
    // (if attrs ? TransparentProxy && attrs.TransparentProxy != null then { transparentProxy = ConsulTransparentProxy.fromJSON attrs.TransparentProxy; } else {})
    // (if attrs ? Upstreams && builtins.isList attrs.Upstreams then { upstreams = builtins.map ConsulUpstream.fromJSON attrs.Upstreams; } else {})
  );

  # Convert a ConsulSidecarService Nix module into a JSON object.
  _module.transformers.ConsulSidecarService.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? disableDefaultTcpCheck && attrs.disableDefaultTcpCheck != null then { DisableDefaultTCPCheck = attrs.disableDefaultTcpCheck; } else {})
    // (if attrs ? meta && attrs.meta != null then { Meta = attrs.meta; } else {})
    // (if attrs ? port && attrs.port != null then { Port = attrs.port; } else {})
    // (if attrs ? proxy && attrs.proxy != null then { Proxy = ConsulProxy.toJSON attrs.proxy; } else {})
    // (if attrs ? tags && attrs.tags != null then { Tags = attrs.tags; } else {})
  );

  # Convert a ConsulSidecarService JSON object into a Nix module.
  _module.transformers.ConsulSidecarService.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? DisableDefaultTCPCheck && attrs.DisableDefaultTCPCheck != null then { disableDefaultTcpCheck = attrs.DisableDefaultTCPCheck; } else {})
    // (if attrs ? Meta && attrs.Meta != null then { meta = attrs.Meta; } else {})
    // (if attrs ? Port && attrs.Port != null then { port = attrs.Port; } else {})
    // (if attrs ? Proxy && attrs.Proxy != null then { proxy = ConsulProxy.fromJSON attrs.Proxy; } else {})
    // (if attrs ? Tags && attrs.Tags != null then { tags = attrs.Tags; } else {})
  );

  # Convert a ConsulTerminatingConfigEntry Nix module into a JSON object.
  _module.transformers.ConsulTerminatingConfigEntry.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? services && builtins.isList attrs.services then { Services = builtins.map ConsulLinkedService.toJSON attrs.services; } else {})
  );

  # Convert a ConsulTerminatingConfigEntry JSON object into a Nix module.
  _module.transformers.ConsulTerminatingConfigEntry.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Services && builtins.isList attrs.Services then { services = builtins.map ConsulLinkedService.fromJSON attrs.Services; } else {})
  );

  # Convert a ConsulTransparentProxy Nix module into a JSON object.
  _module.transformers.ConsulTransparentProxy.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? excludeInboundPorts && attrs.excludeInboundPorts != null then { ExcludeInboundPorts = attrs.excludeInboundPorts; } else {})
    // (if attrs ? excludeOutboundCidrs && attrs.excludeOutboundCidrs != null then { ExcludeOutboundCIDRs = attrs.excludeOutboundCidrs; } else {})
    // (if attrs ? excludeOutboundPorts && attrs.excludeOutboundPorts != null then { ExcludeOutboundPorts = attrs.excludeOutboundPorts; } else {})
    // (if attrs ? excludeUids && attrs.excludeUids != null then { ExcludeUIDs = attrs.excludeUids; } else {})
    // (if attrs ? noDns && attrs.noDns != null then { NoDNS = attrs.noDns; } else {})
    // (if attrs ? outboundPort && attrs.outboundPort != null then { OutboundPort = attrs.outboundPort; } else {})
    // (if attrs ? uid && attrs.uid != null then { UID = attrs.uid; } else {})
  );

  # Convert a ConsulTransparentProxy JSON object into a Nix module.
  _module.transformers.ConsulTransparentProxy.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? ExcludeInboundPorts && attrs.ExcludeInboundPorts != null then { excludeInboundPorts = attrs.ExcludeInboundPorts; } else {})
    // (if attrs ? ExcludeOutboundCIDRs && attrs.ExcludeOutboundCIDRs != null then { excludeOutboundCidrs = attrs.ExcludeOutboundCIDRs; } else {})
    // (if attrs ? ExcludeOutboundPorts && attrs.ExcludeOutboundPorts != null then { excludeOutboundPorts = attrs.ExcludeOutboundPorts; } else {})
    // (if attrs ? ExcludeUIDs && attrs.ExcludeUIDs != null then { excludeUids = attrs.ExcludeUIDs; } else {})
    // (if attrs ? NoDNS && attrs.NoDNS != null then { noDns = attrs.NoDNS; } else {})
    // (if attrs ? OutboundPort && attrs.OutboundPort != null then { outboundPort = attrs.OutboundPort; } else {})
    // (if attrs ? UID && attrs.UID != null then { uid = attrs.UID; } else {})
  );

  # Convert a ConsulUpstream Nix module into a JSON object.
  _module.transformers.ConsulUpstream.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? config && attrs.config != null then { Config = attrs.config; } else {})
    // (if attrs ? datacenter && attrs.datacenter != null then { Datacenter = attrs.datacenter; } else {})
    // (if attrs ? destinationName && attrs.destinationName != null then { DestinationName = attrs.destinationName; } else {})
    // (if attrs ? destinationNamespace && attrs.destinationNamespace != null then { DestinationNamespace = attrs.destinationNamespace; } else {})
    // (if attrs ? destinationPartition && attrs.destinationPartition != null then { DestinationPartition = attrs.destinationPartition; } else {})
    // (if attrs ? destinationPeer && attrs.destinationPeer != null then { DestinationPeer = attrs.destinationPeer; } else {})
    // (if attrs ? destinationType && attrs.destinationType != null then { DestinationType = attrs.destinationType; } else {})
    // (if attrs ? localBindAddress && attrs.localBindAddress != null then { LocalBindAddress = attrs.localBindAddress; } else {})
    // (if attrs ? localBindPort && attrs.localBindPort != null then { LocalBindPort = attrs.localBindPort; } else {})
    // (if attrs ? localBindSocketMode && attrs.localBindSocketMode != null then { LocalBindSocketMode = attrs.localBindSocketMode; } else {})
    // (if attrs ? localBindSocketPath && attrs.localBindSocketPath != null then { LocalBindSocketPath = attrs.localBindSocketPath; } else {})
    // (if attrs ? meshGateway && attrs.meshGateway != null then { MeshGateway = ConsulMeshGateway.toJSON attrs.meshGateway; } else {})
  );

  # Convert a ConsulUpstream JSON object into a Nix module.
  _module.transformers.ConsulUpstream.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Config && attrs.Config != null then { config = attrs.Config; } else {})
    // (if attrs ? Datacenter && attrs.Datacenter != null then { datacenter = attrs.Datacenter; } else {})
    // (if attrs ? DestinationName && attrs.DestinationName != null then { destinationName = attrs.DestinationName; } else {})
    // (if attrs ? DestinationNamespace && attrs.DestinationNamespace != null then { destinationNamespace = attrs.DestinationNamespace; } else {})
    // (if attrs ? DestinationPartition && attrs.DestinationPartition != null then { destinationPartition = attrs.DestinationPartition; } else {})
    // (if attrs ? DestinationPeer && attrs.DestinationPeer != null then { destinationPeer = attrs.DestinationPeer; } else {})
    // (if attrs ? DestinationType && attrs.DestinationType != null then { destinationType = attrs.DestinationType; } else {})
    // (if attrs ? LocalBindAddress && attrs.LocalBindAddress != null then { localBindAddress = attrs.LocalBindAddress; } else {})
    // (if attrs ? LocalBindPort && attrs.LocalBindPort != null then { localBindPort = attrs.LocalBindPort; } else {})
    // (if attrs ? LocalBindSocketMode && attrs.LocalBindSocketMode != null then { localBindSocketMode = attrs.LocalBindSocketMode; } else {})
    // (if attrs ? LocalBindSocketPath && attrs.LocalBindSocketPath != null then { localBindSocketPath = attrs.LocalBindSocketPath; } else {})
    // (if attrs ? MeshGateway && attrs.MeshGateway != null then { meshGateway = ConsulMeshGateway.fromJSON attrs.MeshGateway; } else {})
  );

  # Convert a DnsConfig Nix module into a JSON object.
  _module.transformers.DnsConfig.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? options && attrs.options != null then { Options = attrs.options; } else {})
    // (if attrs ? searches && attrs.searches != null then { Searches = attrs.searches; } else {})
    // (if attrs ? servers && attrs.servers != null then { Servers = attrs.servers; } else {})
  );

  # Convert a DnsConfig JSON object into a Nix module.
  _module.transformers.DnsConfig.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Options && attrs.Options != null then { options = attrs.Options; } else {})
    // (if attrs ? Searches && attrs.Searches != null then { searches = attrs.Searches; } else {})
    // (if attrs ? Servers && attrs.Servers != null then { servers = attrs.Servers; } else {})
  );

  # Convert a DisconnectStrategy Nix module into a JSON object.
  _module.transformers.DisconnectStrategy.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? lostAfter && attrs.lostAfter != null then { LostAfter = attrs.lostAfter; } else {})
    // (if attrs ? reconcile && attrs.reconcile != null then { Reconcile = attrs.reconcile; } else {})
    // (if attrs ? replace && attrs.replace != null then { Replace = attrs.replace; } else {})
    // (if attrs ? stopOnClientAfter && attrs.stopOnClientAfter != null then { StopOnClientAfter = attrs.stopOnClientAfter; } else {})
  );

  # Convert a DisconnectStrategy JSON object into a Nix module.
  _module.transformers.DisconnectStrategy.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? LostAfter && attrs.LostAfter != null then { lostAfter = attrs.LostAfter; } else {})
    // (if attrs ? Reconcile && attrs.Reconcile != null then { reconcile = attrs.Reconcile; } else {})
    // (if attrs ? Replace && attrs.Replace != null then { replace = attrs.Replace; } else {})
    // (if attrs ? StopOnClientAfter && attrs.StopOnClientAfter != null then { stopOnClientAfter = attrs.StopOnClientAfter; } else {})
  );

  # Convert a DispatchPayloadConfig Nix module into a JSON object.
  _module.transformers.DispatchPayloadConfig.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? file && attrs.file != null then { File = attrs.file; } else {})
  );

  # Convert a DispatchPayloadConfig JSON object into a Nix module.
  _module.transformers.DispatchPayloadConfig.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? File && attrs.File != null then { file = attrs.File; } else {})
  );

  # Convert a EphemeralDisk Nix module into a JSON object.
  _module.transformers.EphemeralDisk.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? migrate && attrs.migrate != null then { Migrate = attrs.migrate; } else {})
    // (if attrs ? size && attrs.size != null then { SizeMB = attrs.size; } else {})
    // (if attrs ? sticky && attrs.sticky != null then { Sticky = attrs.sticky; } else {})
  );

  # Convert a EphemeralDisk JSON object into a Nix module.
  _module.transformers.EphemeralDisk.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Migrate && attrs.Migrate != null then { migrate = attrs.Migrate; } else {})
    // (if attrs ? SizeMB && attrs.SizeMB != null then { size = attrs.SizeMB; } else {})
    // (if attrs ? Sticky && attrs.Sticky != null then { sticky = attrs.Sticky; } else {})
  );

  # Convert a Job Nix module into a JSON object.
  _module.transformers.Job.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? affinities && builtins.isList attrs.affinities then { Affinities = builtins.map Affinity.toJSON attrs.affinities; } else {})
    // (if attrs ? allAtOnce && attrs.allAtOnce != null then { AllAtOnce = attrs.allAtOnce; } else {})
    // (if attrs ? constraints && builtins.isList attrs.constraints then { Constraints = builtins.map Constraint.toJSON attrs.constraints; } else {})
    // (if attrs ? consulToken && attrs.consulToken != null then { ConsulToken = attrs.consulToken; } else {})
    // (if attrs ? datacenters && attrs.datacenters != null then { Datacenters = attrs.datacenters; } else {})
    // (if attrs ? group && builtins.isAttrs attrs.group then { TaskGroups = mapAttrsToList (_: TaskGroup.toJSON) attrs.group; } else {})
    // (if attrs ? id && attrs.id != null then { ID = attrs.id; } else {})
    // (if attrs ? meta && attrs.meta != null then { Meta = attrs.meta; } else {})
    // (if attrs ? migrate && attrs.migrate != null then { Migrate = MigrateStrategy.toJSON attrs.migrate; } else {})
    // (if attrs ? multiregion && attrs.multiregion != null then { Multiregion = Multiregion.toJSON attrs.multiregion; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? namespace && attrs.namespace != null then { Namespace = attrs.namespace; } else {})
    // (if attrs ? nodePool && attrs.nodePool != null then { NodePool = attrs.nodePool; } else {})
    // (if attrs ? parameterized && attrs.parameterized != null then { ParameterizedJob = ParameterizedJobConfig.toJSON attrs.parameterized; } else {})
    // (if attrs ? periodic && attrs.periodic != null then { Periodic = PeriodicConfig.toJSON attrs.periodic; } else {})
    // (if attrs ? priority && attrs.priority != null then { Priority = attrs.priority; } else {})
    // (if attrs ? region && attrs.region != null then { Region = attrs.region; } else {})
    // (if attrs ? reschedule && attrs.reschedule != null then { Reschedule = ReschedulePolicy.toJSON attrs.reschedule; } else {})
    // (if attrs ? spreads && builtins.isList attrs.spreads then { Spreads = builtins.map Spread.toJSON attrs.spreads; } else {})
    // (if attrs ? type && attrs.type != null then { Type = attrs.type; } else {})
    // (if attrs ? ui && attrs.ui != null then { UI = JobUiConfig.toJSON attrs.ui; } else {})
    // (if attrs ? update && attrs.update != null then { Update = UpdateStrategy.toJSON attrs.update; } else {})
    // (if attrs ? vaultToken && attrs.vaultToken != null then { VaultToken = attrs.vaultToken; } else {})
  );

  # Convert a Job JSON object into a Nix module.
  _module.transformers.Job.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Affinities && builtins.isList attrs.Affinities then { affinities = builtins.map Affinity.fromJSON attrs.Affinities; } else {})
    // (if attrs ? AllAtOnce && attrs.AllAtOnce != null then { allAtOnce = attrs.AllAtOnce; } else {})
    // (if attrs ? Constraints && builtins.isList attrs.Constraints then { constraints = builtins.map Constraint.fromJSON attrs.Constraints; } else {})
    // (if attrs ? ConsulToken && attrs.ConsulToken != null then { consulToken = attrs.ConsulToken; } else {})
    // (if attrs ? Datacenters && attrs.Datacenters != null then { datacenters = attrs.Datacenters; } else {})
    // (if attrs ? TaskGroups && builtins.isList attrs.TaskGroups then { group = builtins.listToAttrs (builtins.map (v: nameValuePair v.Name (TaskGroup.fromJSON v)) attrs.TaskGroups); } else {})
    // (if attrs ? ID && attrs.ID != null then { id = attrs.ID; } else {})
    // (if attrs ? Meta && attrs.Meta != null then { meta = attrs.Meta; } else {})
    // (if attrs ? Migrate && attrs.Migrate != null then { migrate = MigrateStrategy.fromJSON attrs.Migrate; } else {})
    // (if attrs ? Multiregion && attrs.Multiregion != null then { multiregion = Multiregion.fromJSON attrs.Multiregion; } else {})
    // (if attrs ? Name && attrs.Name != null then { name = attrs.Name; } else {})
    // (if attrs ? Namespace && attrs.Namespace != null then { namespace = attrs.Namespace; } else {})
    // (if attrs ? NodePool && attrs.NodePool != null then { nodePool = attrs.NodePool; } else {})
    // (if attrs ? ParameterizedJob && attrs.ParameterizedJob != null then { parameterized = ParameterizedJobConfig.fromJSON attrs.ParameterizedJob; } else {})
    // (if attrs ? Periodic && attrs.Periodic != null then { periodic = PeriodicConfig.fromJSON attrs.Periodic; } else {})
    // (if attrs ? Priority && attrs.Priority != null then { priority = attrs.Priority; } else {})
    // (if attrs ? Region && attrs.Region != null then { region = attrs.Region; } else {})
    // (if attrs ? Reschedule && attrs.Reschedule != null then { reschedule = ReschedulePolicy.fromJSON attrs.Reschedule; } else {})
    // (if attrs ? Spreads && builtins.isList attrs.Spreads then { spreads = builtins.map Spread.fromJSON attrs.Spreads; } else {})
    // (if attrs ? Type && attrs.Type != null then { type = attrs.Type; } else {})
    // (if attrs ? UI && attrs.UI != null then { ui = JobUiConfig.fromJSON attrs.UI; } else {})
    // (if attrs ? Update && attrs.Update != null then { update = UpdateStrategy.fromJSON attrs.Update; } else {})
    // (if attrs ? VaultToken && attrs.VaultToken != null then { vaultToken = attrs.VaultToken; } else {})
  );

  # Convert a JobUiConfig Nix module into a JSON object.
  _module.transformers.JobUiConfig.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? description && attrs.description != null then { Description = attrs.description; } else {})
    // (if attrs ? links && builtins.isList attrs.links then { Links = builtins.map JobUiLink.toJSON attrs.links; } else {})
  );

  # Convert a JobUiConfig JSON object into a Nix module.
  _module.transformers.JobUiConfig.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Description && attrs.Description != null then { description = attrs.Description; } else {})
    // (if attrs ? Links && builtins.isList attrs.Links then { links = builtins.map JobUiLink.fromJSON attrs.Links; } else {})
  );

  # Convert a JobUiLink Nix module into a JSON object.
  _module.transformers.JobUiLink.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? label && attrs.label != null then { Label = attrs.label; } else {})
    // (if attrs ? url && attrs.url != null then { URL = attrs.url; } else {})
  );

  # Convert a JobUiLink JSON object into a Nix module.
  _module.transformers.JobUiLink.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Label && attrs.Label != null then { label = attrs.Label; } else {})
    // (if attrs ? URL && attrs.URL != null then { url = attrs.URL; } else {})
  );

  # Convert a LogConfig Nix module into a JSON object.
  _module.transformers.LogConfig.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? disabled && attrs.disabled != null then { Disabled = attrs.disabled; } else {})
    // (if attrs ? enabled && attrs.enabled != null then { Enabled = attrs.enabled; } else {})
    // (if attrs ? maxFileSize && attrs.maxFileSize != null then { MaxFileSizeMB = attrs.maxFileSize; } else {})
    // (if attrs ? maxFiles && attrs.maxFiles != null then { MaxFiles = attrs.maxFiles; } else {})
  );

  # Convert a LogConfig JSON object into a Nix module.
  _module.transformers.LogConfig.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Disabled && attrs.Disabled != null then { disabled = attrs.Disabled; } else {})
    // (if attrs ? Enabled && attrs.Enabled != null then { enabled = attrs.Enabled; } else {})
    // (if attrs ? MaxFileSizeMB && attrs.MaxFileSizeMB != null then { maxFileSize = attrs.MaxFileSizeMB; } else {})
    // (if attrs ? MaxFiles && attrs.MaxFiles != null then { maxFiles = attrs.MaxFiles; } else {})
  );

  # Convert a MigrateStrategy Nix module into a JSON object.
  _module.transformers.MigrateStrategy.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? healthCheck && attrs.healthCheck != null then { HealthCheck = attrs.healthCheck; } else {})
    // (if attrs ? healthyDeadline && attrs.healthyDeadline != null then { HealthyDeadline = attrs.healthyDeadline; } else {})
    // (if attrs ? maxParallel && attrs.maxParallel != null then { MaxParallel = attrs.maxParallel; } else {})
    // (if attrs ? minHealthyTime && attrs.minHealthyTime != null then { MinHealthyTime = attrs.minHealthyTime; } else {})
  );

  # Convert a MigrateStrategy JSON object into a Nix module.
  _module.transformers.MigrateStrategy.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? HealthCheck && attrs.HealthCheck != null then { healthCheck = attrs.HealthCheck; } else {})
    // (if attrs ? HealthyDeadline && attrs.HealthyDeadline != null then { healthyDeadline = attrs.HealthyDeadline; } else {})
    // (if attrs ? MaxParallel && attrs.MaxParallel != null then { maxParallel = attrs.MaxParallel; } else {})
    // (if attrs ? MinHealthyTime && attrs.MinHealthyTime != null then { minHealthyTime = attrs.MinHealthyTime; } else {})
  );

  # Convert a Multiregion Nix module into a JSON object.
  _module.transformers.Multiregion.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? region && builtins.isAttrs attrs.region then { Regions = mapAttrsToList (_: MultiregionRegion.toJSON) attrs.region; } else {})
    // (if attrs ? strategy && attrs.strategy != null then { Strategy = MultiregionStrategy.toJSON attrs.strategy; } else {})
  );

  # Convert a Multiregion JSON object into a Nix module.
  _module.transformers.Multiregion.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Regions && builtins.isList attrs.Regions then { region = builtins.listToAttrs (builtins.map (v: nameValuePair v.Name (MultiregionRegion.fromJSON v)) attrs.Regions); } else {})
    // (if attrs ? Strategy && attrs.Strategy != null then { strategy = MultiregionStrategy.fromJSON attrs.Strategy; } else {})
  );

  # Convert a MultiregionRegion Nix module into a JSON object.
  _module.transformers.MultiregionRegion.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? count && attrs.count != null then { Count = attrs.count; } else {})
    // (if attrs ? datacenters && attrs.datacenters != null then { Datacenters = attrs.datacenters; } else {})
    // (if attrs ? meta && attrs.meta != null then { Meta = attrs.meta; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? nodePool && attrs.nodePool != null then { NodePool = attrs.nodePool; } else {})
  );

  # Convert a MultiregionRegion JSON object into a Nix module.
  _module.transformers.MultiregionRegion.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Count && attrs.Count != null then { count = attrs.Count; } else {})
    // (if attrs ? Datacenters && attrs.Datacenters != null then { datacenters = attrs.Datacenters; } else {})
    // (if attrs ? Meta && attrs.Meta != null then { meta = attrs.Meta; } else {})
    // (if attrs ? Name && attrs.Name != null then { name = attrs.Name; } else {})
    // (if attrs ? NodePool && attrs.NodePool != null then { nodePool = attrs.NodePool; } else {})
  );

  # Convert a MultiregionStrategy Nix module into a JSON object.
  _module.transformers.MultiregionStrategy.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? maxParallel && attrs.maxParallel != null then { MaxParallel = attrs.maxParallel; } else {})
    // (if attrs ? onFailure && attrs.onFailure != null then { OnFailure = attrs.onFailure; } else {})
  );

  # Convert a MultiregionStrategy JSON object into a Nix module.
  _module.transformers.MultiregionStrategy.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? MaxParallel && attrs.MaxParallel != null then { maxParallel = attrs.MaxParallel; } else {})
    // (if attrs ? OnFailure && attrs.OnFailure != null then { onFailure = attrs.OnFailure; } else {})
  );

  # Convert a NumaResource Nix module into a JSON object.
  _module.transformers.NumaResource.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? affinity && attrs.affinity != null then { Affinity = attrs.affinity; } else {})
    // (if attrs ? devices && attrs.devices != null then { Devices = attrs.devices; } else {})
  );

  # Convert a NumaResource JSON object into a Nix module.
  _module.transformers.NumaResource.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Affinity && attrs.Affinity != null then { affinity = attrs.Affinity; } else {})
    // (if attrs ? Devices && attrs.Devices != null then { devices = attrs.Devices; } else {})
  );

  # Convert a NetworkResource Nix module into a JSON object.
  _module.transformers.NetworkResource.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? cidr && attrs.cidr != null then { CIDR = attrs.cidr; } else {})
    // (if attrs ? cni && attrs.cni != null then { CNI = CniConfig.toJSON attrs.cni; } else {})
    // (if attrs ? device && attrs.device != null then { Device = attrs.device; } else {})
    // (if attrs ? dns && attrs.dns != null then { DNS = DnsConfig.toJSON attrs.dns; } else {})
    // (if attrs ? hostname && attrs.hostname != null then { Hostname = attrs.hostname; } else {})
    // (if attrs ? ip && attrs.ip != null then { IP = attrs.ip; } else {})
    // (if attrs ? mbits && attrs.mbits != null then { MBits = attrs.mbits; } else {})
    // (if attrs ? mode && attrs.mode != null then { Mode = attrs.mode; } else {})
    // (if attrs ? port && builtins.isAttrs attrs.port then { DynamicPorts = mapAttrsToList (_: Port.toJSON) attrs.port; } else {})
    // (if attrs ? reservedPorts && builtins.isAttrs attrs.reservedPorts then { ReservedPorts = mapAttrsToList (_: Port.toJSON) attrs.reservedPorts; } else {})
  );

  # Convert a NetworkResource JSON object into a Nix module.
  _module.transformers.NetworkResource.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? CIDR && attrs.CIDR != null then { cidr = attrs.CIDR; } else {})
    // (if attrs ? CNI && attrs.CNI != null then { cni = CniConfig.fromJSON attrs.CNI; } else {})
    // (if attrs ? Device && attrs.Device != null then { device = attrs.Device; } else {})
    // (if attrs ? DNS && attrs.DNS != null then { dns = DnsConfig.fromJSON attrs.DNS; } else {})
    // (if attrs ? Hostname && attrs.Hostname != null then { hostname = attrs.Hostname; } else {})
    // (if attrs ? IP && attrs.IP != null then { ip = attrs.IP; } else {})
    // (if attrs ? MBits && attrs.MBits != null then { mbits = attrs.MBits; } else {})
    // (if attrs ? Mode && attrs.Mode != null then { mode = attrs.Mode; } else {})
    // (if attrs ? DynamicPorts && builtins.isList attrs.DynamicPorts then { port = builtins.listToAttrs (builtins.map (v: nameValuePair v.Label (Port.fromJSON v)) attrs.DynamicPorts); } else {})
    // (if attrs ? ReservedPorts && builtins.isList attrs.ReservedPorts then { reservedPorts = builtins.listToAttrs (builtins.map (v: nameValuePair v.Label (Port.fromJSON v)) attrs.ReservedPorts); } else {})
  );

  # Convert a ParameterizedJobConfig Nix module into a JSON object.
  _module.transformers.ParameterizedJobConfig.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? metaOptional && attrs.metaOptional != null then { MetaOptional = attrs.metaOptional; } else {})
    // (if attrs ? metaRequired && attrs.metaRequired != null then { MetaRequired = attrs.metaRequired; } else {})
    // (if attrs ? payload && attrs.payload != null then { Payload = attrs.payload; } else {})
  );

  # Convert a ParameterizedJobConfig JSON object into a Nix module.
  _module.transformers.ParameterizedJobConfig.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? MetaOptional && attrs.MetaOptional != null then { metaOptional = attrs.MetaOptional; } else {})
    // (if attrs ? MetaRequired && attrs.MetaRequired != null then { metaRequired = attrs.MetaRequired; } else {})
    // (if attrs ? Payload && attrs.Payload != null then { payload = attrs.Payload; } else {})
  );

  # Convert a PeriodicConfig Nix module into a JSON object.
  _module.transformers.PeriodicConfig.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? cron && attrs.cron != null then { Spec = attrs.cron; } else {})
    // (if attrs ? crons && attrs.crons != null then { Specs = attrs.crons; } else {})
    // (if attrs ? enabled && attrs.enabled != null then { Enabled = attrs.enabled; } else {})
    // (if attrs ? prohibitOverlap && attrs.prohibitOverlap != null then { ProhibitOverlap = attrs.prohibitOverlap; } else {})
    // (if attrs ? timeZone && attrs.timeZone != null then { TimeZone = attrs.timeZone; } else {})
  );

  # Convert a PeriodicConfig JSON object into a Nix module.
  _module.transformers.PeriodicConfig.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Spec && attrs.Spec != null then { cron = attrs.Spec; } else {})
    // (if attrs ? Specs && attrs.Specs != null then { crons = attrs.Specs; } else {})
    // (if attrs ? Enabled && attrs.Enabled != null then { enabled = attrs.Enabled; } else {})
    // (if attrs ? ProhibitOverlap && attrs.ProhibitOverlap != null then { prohibitOverlap = attrs.ProhibitOverlap; } else {})
    // (if attrs ? TimeZone && attrs.TimeZone != null then { timeZone = attrs.TimeZone; } else {})
  );

  # Convert a Port Nix module into a JSON object.
  _module.transformers.Port.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? hostNetwork && attrs.hostNetwork != null then { HostNetwork = attrs.hostNetwork; } else {})
    // (if attrs ? ignoreCollision && attrs.ignoreCollision != null then { IgnoreCollision = attrs.ignoreCollision; } else {})
    // (if attrs ? label && attrs.label != null then { Label = attrs.label; } else {})
    // (if attrs ? static && attrs.static != null then { Value = attrs.static; } else {})
    // (if attrs ? to && attrs.to != null then { To = attrs.to; } else {})
  );

  # Convert a Port JSON object into a Nix module.
  _module.transformers.Port.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? HostNetwork && attrs.HostNetwork != null then { hostNetwork = attrs.HostNetwork; } else {})
    // (if attrs ? IgnoreCollision && attrs.IgnoreCollision != null then { ignoreCollision = attrs.IgnoreCollision; } else {})
    // (if attrs ? Label && attrs.Label != null then { label = attrs.Label; } else {})
    // (if attrs ? Value && attrs.Value != null then { static = attrs.Value; } else {})
    // (if attrs ? To && attrs.To != null then { to = attrs.To; } else {})
  );

  # Convert a RequestedDevice Nix module into a JSON object.
  _module.transformers.RequestedDevice.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? affinities && builtins.isList attrs.affinities then { Affinities = builtins.map Affinity.toJSON attrs.affinities; } else {})
    // (if attrs ? constraints && builtins.isList attrs.constraints then { Constraints = builtins.map Constraint.toJSON attrs.constraints; } else {})
    // (if attrs ? count && attrs.count != null then { Count = attrs.count; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
  );

  # Convert a RequestedDevice JSON object into a Nix module.
  _module.transformers.RequestedDevice.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Affinities && builtins.isList attrs.Affinities then { affinities = builtins.map Affinity.fromJSON attrs.Affinities; } else {})
    // (if attrs ? Constraints && builtins.isList attrs.Constraints then { constraints = builtins.map Constraint.fromJSON attrs.Constraints; } else {})
    // (if attrs ? Count && attrs.Count != null then { count = attrs.Count; } else {})
    // (if attrs ? Name && attrs.Name != null then { name = attrs.Name; } else {})
  );

  # Convert a ReschedulePolicy Nix module into a JSON object.
  _module.transformers.ReschedulePolicy.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attempts && attrs.attempts != null then { Attempts = attrs.attempts; } else {})
    // (if attrs ? delay && attrs.delay != null then { Delay = attrs.delay; } else {})
    // (if attrs ? delayFunction && attrs.delayFunction != null then { DelayFunction = attrs.delayFunction; } else {})
    // (if attrs ? interval && attrs.interval != null then { Interval = attrs.interval; } else {})
    // (if attrs ? maxDelay && attrs.maxDelay != null then { MaxDelay = attrs.maxDelay; } else {})
    // (if attrs ? unlimited && attrs.unlimited != null then { Unlimited = attrs.unlimited; } else {})
  );

  # Convert a ReschedulePolicy JSON object into a Nix module.
  _module.transformers.ReschedulePolicy.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Attempts && attrs.Attempts != null then { attempts = attrs.Attempts; } else {})
    // (if attrs ? Delay && attrs.Delay != null then { delay = attrs.Delay; } else {})
    // (if attrs ? DelayFunction && attrs.DelayFunction != null then { delayFunction = attrs.DelayFunction; } else {})
    // (if attrs ? Interval && attrs.Interval != null then { interval = attrs.Interval; } else {})
    // (if attrs ? MaxDelay && attrs.MaxDelay != null then { maxDelay = attrs.MaxDelay; } else {})
    // (if attrs ? Unlimited && attrs.Unlimited != null then { unlimited = attrs.Unlimited; } else {})
  );

  # Convert a Resources Nix module into a JSON object.
  _module.transformers.Resources.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? cores && attrs.cores != null then { Cores = attrs.cores; } else {})
    // (if attrs ? cpu && attrs.cpu != null then { CPU = attrs.cpu; } else {})
    // (if attrs ? device && builtins.isAttrs attrs.device then { Devices = mapAttrsToList (_: RequestedDevice.toJSON) attrs.device; } else {})
    // (if attrs ? disk && attrs.disk != null then { DiskMB = attrs.disk; } else {})
    // (if attrs ? iops && attrs.iops != null then { IOPS = attrs.iops; } else {})
    // (if attrs ? memory && attrs.memory != null then { MemoryMB = attrs.memory; } else {})
    // (if attrs ? memoryMax && attrs.memoryMax != null then { MemoryMaxMB = attrs.memoryMax; } else {})
    // (if attrs ? networks && builtins.isList attrs.networks then { Networks = builtins.map NetworkResource.toJSON attrs.networks; } else {})
    // (if attrs ? numa && attrs.numa != null then { NUMA = NumaResource.toJSON attrs.numa; } else {})
    // (if attrs ? secrets && attrs.secrets != null then { SecretsMB = attrs.secrets; } else {})
  );

  # Convert a Resources JSON object into a Nix module.
  _module.transformers.Resources.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Cores && attrs.Cores != null then { cores = attrs.Cores; } else {})
    // (if attrs ? CPU && attrs.CPU != null then { cpu = attrs.CPU; } else {})
    // (if attrs ? Devices && builtins.isList attrs.Devices then { device = builtins.listToAttrs (builtins.map (v: nameValuePair v.Name (RequestedDevice.fromJSON v)) attrs.Devices); } else {})
    // (if attrs ? DiskMB && attrs.DiskMB != null then { disk = attrs.DiskMB; } else {})
    // (if attrs ? IOPS && attrs.IOPS != null then { iops = attrs.IOPS; } else {})
    // (if attrs ? MemoryMB && attrs.MemoryMB != null then { memory = attrs.MemoryMB; } else {})
    // (if attrs ? MemoryMaxMB && attrs.MemoryMaxMB != null then { memoryMax = attrs.MemoryMaxMB; } else {})
    // (if attrs ? Networks && builtins.isList attrs.Networks then { networks = builtins.map NetworkResource.fromJSON attrs.Networks; } else {})
    // (if attrs ? NUMA && attrs.NUMA != null then { numa = NumaResource.fromJSON attrs.NUMA; } else {})
    // (if attrs ? SecretsMB && attrs.SecretsMB != null then { secrets = attrs.SecretsMB; } else {})
  );

  # Convert a RestartPolicy Nix module into a JSON object.
  _module.transformers.RestartPolicy.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attempts && attrs.attempts != null then { Attempts = attrs.attempts; } else {})
    // (if attrs ? delay && attrs.delay != null then { Delay = attrs.delay; } else {})
    // (if attrs ? interval && attrs.interval != null then { Interval = attrs.interval; } else {})
    // (if attrs ? mode && attrs.mode != null then { Mode = attrs.mode; } else {})
    // (if attrs ? renderTemplates && attrs.renderTemplates != null then { RenderTemplates = attrs.renderTemplates; } else {})
  );

  # Convert a RestartPolicy JSON object into a Nix module.
  _module.transformers.RestartPolicy.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Attempts && attrs.Attempts != null then { attempts = attrs.Attempts; } else {})
    // (if attrs ? Delay && attrs.Delay != null then { delay = attrs.Delay; } else {})
    // (if attrs ? Interval && attrs.Interval != null then { interval = attrs.Interval; } else {})
    // (if attrs ? Mode && attrs.Mode != null then { mode = attrs.Mode; } else {})
    // (if attrs ? RenderTemplates && attrs.RenderTemplates != null then { renderTemplates = attrs.RenderTemplates; } else {})
  );

  # Convert a ScalingPolicy Nix module into a JSON object.
  _module.transformers.ScalingPolicy.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? enabled && attrs.enabled != null then { Enabled = attrs.enabled; } else {})
    // (if attrs ? max && attrs.max != null then { Max = attrs.max; } else {})
    // (if attrs ? min && attrs.min != null then { Min = attrs.min; } else {})
    // (if attrs ? policy && attrs.policy != null then { Policy = attrs.policy; } else {})
    // (if attrs ? type && attrs.type != null then { Type = attrs.type; } else {})
  );

  # Convert a ScalingPolicy JSON object into a Nix module.
  _module.transformers.ScalingPolicy.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Enabled && attrs.Enabled != null then { enabled = attrs.Enabled; } else {})
    // (if attrs ? Max && attrs.Max != null then { max = attrs.Max; } else {})
    // (if attrs ? Min && attrs.Min != null then { min = attrs.Min; } else {})
    // (if attrs ? Policy && attrs.Policy != null then { policy = attrs.Policy; } else {})
    // (if attrs ? Type && attrs.Type != null then { type = attrs.Type; } else {})
  );

  # Convert a Service Nix module into a JSON object.
  _module.transformers.Service.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? address && attrs.address != null then { Address = attrs.address; } else {})
    // (if attrs ? addressMode && attrs.addressMode != null then { AddressMode = attrs.addressMode; } else {})
    // (if attrs ? canaryMeta && attrs.canaryMeta != null then { CanaryMeta = attrs.canaryMeta; } else {})
    // (if attrs ? canaryTags && attrs.canaryTags != null then { CanaryTags = attrs.canaryTags; } else {})
    // (if attrs ? checkRestart && attrs.checkRestart != null then { CheckRestart = CheckRestart.toJSON attrs.checkRestart; } else {})
    // (if attrs ? checks && builtins.isList attrs.checks then { Checks = builtins.map ServiceCheck.toJSON attrs.checks; } else {})
    // (if attrs ? cluster && attrs.cluster != null then { Cluster = attrs.cluster; } else {})
    // (if attrs ? connect && attrs.connect != null then { Connect = ConsulConnect.toJSON attrs.connect; } else {})
    // (if attrs ? enableTagOverride && attrs.enableTagOverride != null then { EnableTagOverride = attrs.enableTagOverride; } else {})
    // (if attrs ? identity && attrs.identity != null then { Identity = WorkloadIdentity.toJSON attrs.identity; } else {})
    // (if attrs ? meta && attrs.meta != null then { Meta = attrs.meta; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? onUpdate && attrs.onUpdate != null then { OnUpdate = attrs.onUpdate; } else {})
    // (if attrs ? port && attrs.port != null then { PortLabel = attrs.port; } else {})
    // (if attrs ? provider && attrs.provider != null then { Provider = attrs.provider; } else {})
    // (if attrs ? taggedAddresses && attrs.taggedAddresses != null then { TaggedAddresses = attrs.taggedAddresses; } else {})
    // (if attrs ? tags && attrs.tags != null then { Tags = attrs.tags; } else {})
    // (if attrs ? task && attrs.task != null then { TaskName = attrs.task; } else {})
    // (if attrs ? weights && attrs.weights != null then { Weights = ServiceWeights.toJSON attrs.weights; } else {})
  );

  # Convert a Service JSON object into a Nix module.
  _module.transformers.Service.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Address && attrs.Address != null then { address = attrs.Address; } else {})
    // (if attrs ? AddressMode && attrs.AddressMode != null then { addressMode = attrs.AddressMode; } else {})
    // (if attrs ? CanaryMeta && attrs.CanaryMeta != null then { canaryMeta = attrs.CanaryMeta; } else {})
    // (if attrs ? CanaryTags && attrs.CanaryTags != null then { canaryTags = attrs.CanaryTags; } else {})
    // (if attrs ? CheckRestart && attrs.CheckRestart != null then { checkRestart = CheckRestart.fromJSON attrs.CheckRestart; } else {})
    // (if attrs ? Checks && builtins.isList attrs.Checks then { checks = builtins.map ServiceCheck.fromJSON attrs.Checks; } else {})
    // (if attrs ? Cluster && attrs.Cluster != null then { cluster = attrs.Cluster; } else {})
    // (if attrs ? Connect && attrs.Connect != null then { connect = ConsulConnect.fromJSON attrs.Connect; } else {})
    // (if attrs ? EnableTagOverride && attrs.EnableTagOverride != null then { enableTagOverride = attrs.EnableTagOverride; } else {})
    // (if attrs ? Identity && attrs.Identity != null then { identity = WorkloadIdentity.fromJSON attrs.Identity; } else {})
    // (if attrs ? Meta && attrs.Meta != null then { meta = attrs.Meta; } else {})
    // (if attrs ? Name && attrs.Name != null then { name = attrs.Name; } else {})
    // (if attrs ? OnUpdate && attrs.OnUpdate != null then { onUpdate = attrs.OnUpdate; } else {})
    // (if attrs ? PortLabel && attrs.PortLabel != null then { port = attrs.PortLabel; } else {})
    // (if attrs ? Provider && attrs.Provider != null then { provider = attrs.Provider; } else {})
    // (if attrs ? TaggedAddresses && attrs.TaggedAddresses != null then { taggedAddresses = attrs.TaggedAddresses; } else {})
    // (if attrs ? Tags && attrs.Tags != null then { tags = attrs.Tags; } else {})
    // (if attrs ? TaskName && attrs.TaskName != null then { task = attrs.TaskName; } else {})
    // (if attrs ? Weights && attrs.Weights != null then { weights = ServiceWeights.fromJSON attrs.Weights; } else {})
  );

  # Convert a ServiceCheck Nix module into a JSON object.
  _module.transformers.ServiceCheck.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? addressMode && attrs.addressMode != null then { AddressMode = attrs.addressMode; } else {})
    // (if attrs ? advertise && attrs.advertise != null then { Advertise = attrs.advertise; } else {})
    // (if attrs ? args && attrs.args != null then { Args = attrs.args; } else {})
    // (if attrs ? body && attrs.body != null then { Body = attrs.body; } else {})
    // (if attrs ? checkRestart && attrs.checkRestart != null then { CheckRestart = CheckRestart.toJSON attrs.checkRestart; } else {})
    // (if attrs ? command && attrs.command != null then { Command = attrs.command; } else {})
    // (if attrs ? expose && attrs.expose != null then { Expose = attrs.expose; } else {})
    // (if attrs ? failuresBeforeCritical && attrs.failuresBeforeCritical != null then { FailuresBeforeCritical = attrs.failuresBeforeCritical; } else {})
    // (if attrs ? failuresBeforeWarning && attrs.failuresBeforeWarning != null then { FailuresBeforeWarning = attrs.failuresBeforeWarning; } else {})
    // (if attrs ? grpcService && attrs.grpcService != null then { GRPCService = attrs.grpcService; } else {})
    // (if attrs ? grpcUseTls && attrs.grpcUseTls != null then { GRPCUseTLS = attrs.grpcUseTls; } else {})
    // (if attrs ? header && attrs.header != null then { Header = attrs.header; } else {})
    // (if attrs ? initialStatus && attrs.initialStatus != null then { InitialStatus = attrs.initialStatus; } else {})
    // (if attrs ? interval && attrs.interval != null then { Interval = attrs.interval; } else {})
    // (if attrs ? method && attrs.method != null then { Method = attrs.method; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? notes && attrs.notes != null then { Notes = attrs.notes; } else {})
    // (if attrs ? onUpdate && attrs.onUpdate != null then { OnUpdate = attrs.onUpdate; } else {})
    // (if attrs ? path && attrs.path != null then { Path = attrs.path; } else {})
    // (if attrs ? port && attrs.port != null then { PortLabel = attrs.port; } else {})
    // (if attrs ? protocol && attrs.protocol != null then { Protocol = attrs.protocol; } else {})
    // (if attrs ? successBeforePassing && attrs.successBeforePassing != null then { SuccessBeforePassing = attrs.successBeforePassing; } else {})
    // (if attrs ? task && attrs.task != null then { TaskName = attrs.task; } else {})
    // (if attrs ? timeout && attrs.timeout != null then { Timeout = attrs.timeout; } else {})
    // (if attrs ? tlsServerName && attrs.tlsServerName != null then { TLSServerName = attrs.tlsServerName; } else {})
    // (if attrs ? tlsSkipVerify && attrs.tlsSkipVerify != null then { TLSSkipVerify = attrs.tlsSkipVerify; } else {})
    // (if attrs ? type && attrs.type != null then { Type = attrs.type; } else {})
  );

  # Convert a ServiceCheck JSON object into a Nix module.
  _module.transformers.ServiceCheck.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? AddressMode && attrs.AddressMode != null then { addressMode = attrs.AddressMode; } else {})
    // (if attrs ? Advertise && attrs.Advertise != null then { advertise = attrs.Advertise; } else {})
    // (if attrs ? Args && attrs.Args != null then { args = attrs.Args; } else {})
    // (if attrs ? Body && attrs.Body != null then { body = attrs.Body; } else {})
    // (if attrs ? CheckRestart && attrs.CheckRestart != null then { checkRestart = CheckRestart.fromJSON attrs.CheckRestart; } else {})
    // (if attrs ? Command && attrs.Command != null then { command = attrs.Command; } else {})
    // (if attrs ? Expose && attrs.Expose != null then { expose = attrs.Expose; } else {})
    // (if attrs ? FailuresBeforeCritical && attrs.FailuresBeforeCritical != null then { failuresBeforeCritical = attrs.FailuresBeforeCritical; } else {})
    // (if attrs ? FailuresBeforeWarning && attrs.FailuresBeforeWarning != null then { failuresBeforeWarning = attrs.FailuresBeforeWarning; } else {})
    // (if attrs ? GRPCService && attrs.GRPCService != null then { grpcService = attrs.GRPCService; } else {})
    // (if attrs ? GRPCUseTLS && attrs.GRPCUseTLS != null then { grpcUseTls = attrs.GRPCUseTLS; } else {})
    // (if attrs ? Header && attrs.Header != null then { header = attrs.Header; } else {})
    // (if attrs ? InitialStatus && attrs.InitialStatus != null then { initialStatus = attrs.InitialStatus; } else {})
    // (if attrs ? Interval && attrs.Interval != null then { interval = attrs.Interval; } else {})
    // (if attrs ? Method && attrs.Method != null then { method = attrs.Method; } else {})
    // (if attrs ? Name && attrs.Name != null then { name = attrs.Name; } else {})
    // (if attrs ? Notes && attrs.Notes != null then { notes = attrs.Notes; } else {})
    // (if attrs ? OnUpdate && attrs.OnUpdate != null then { onUpdate = attrs.OnUpdate; } else {})
    // (if attrs ? Path && attrs.Path != null then { path = attrs.Path; } else {})
    // (if attrs ? PortLabel && attrs.PortLabel != null then { port = attrs.PortLabel; } else {})
    // (if attrs ? Protocol && attrs.Protocol != null then { protocol = attrs.Protocol; } else {})
    // (if attrs ? SuccessBeforePassing && attrs.SuccessBeforePassing != null then { successBeforePassing = attrs.SuccessBeforePassing; } else {})
    // (if attrs ? TaskName && attrs.TaskName != null then { task = attrs.TaskName; } else {})
    // (if attrs ? Timeout && attrs.Timeout != null then { timeout = attrs.Timeout; } else {})
    // (if attrs ? TLSServerName && attrs.TLSServerName != null then { tlsServerName = attrs.TLSServerName; } else {})
    // (if attrs ? TLSSkipVerify && attrs.TLSSkipVerify != null then { tlsSkipVerify = attrs.TLSSkipVerify; } else {})
    // (if attrs ? Type && attrs.Type != null then { type = attrs.Type; } else {})
  );

  # Convert a ServiceWeights Nix module into a JSON object.
  _module.transformers.ServiceWeights.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? passing && attrs.passing != null then { Passing = attrs.passing; } else {})
    // (if attrs ? warning && attrs.warning != null then { Warning = attrs.warning; } else {})
  );

  # Convert a ServiceWeights JSON object into a Nix module.
  _module.transformers.ServiceWeights.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Passing && attrs.Passing != null then { passing = attrs.Passing; } else {})
    // (if attrs ? Warning && attrs.Warning != null then { warning = attrs.Warning; } else {})
  );

  # Convert a SidecarTask Nix module into a JSON object.
  _module.transformers.SidecarTask.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? config && attrs.config != null then { Config = attrs.config; } else {})
    // (if attrs ? driver && attrs.driver != null then { Driver = attrs.driver; } else {})
    // (if attrs ? env && attrs.env != null then { Env = attrs.env; } else {})
    // (if attrs ? killSignal && attrs.killSignal != null then { KillSignal = attrs.killSignal; } else {})
    // (if attrs ? killTimeout && attrs.killTimeout != null then { KillTimeout = attrs.killTimeout; } else {})
    // (if attrs ? logs && attrs.logs != null then { LogConfig = LogConfig.toJSON attrs.logs; } else {})
    // (if attrs ? meta && attrs.meta != null then { Meta = attrs.meta; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? resources && attrs.resources != null then { Resources = Resources.toJSON attrs.resources; } else {})
    // (if attrs ? shutdownDelay && attrs.shutdownDelay != null then { ShutdownDelay = attrs.shutdownDelay; } else {})
    // (if attrs ? user && attrs.user != null then { User = attrs.user; } else {})
    // (if attrs ? volumeMounts && builtins.isList attrs.volumeMounts then { VolumeMounts = builtins.map VolumeMount.toJSON attrs.volumeMounts; } else {})
  );

  # Convert a SidecarTask JSON object into a Nix module.
  _module.transformers.SidecarTask.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Config && attrs.Config != null then { config = attrs.Config; } else {})
    // (if attrs ? Driver && attrs.Driver != null then { driver = attrs.Driver; } else {})
    // (if attrs ? Env && attrs.Env != null then { env = attrs.Env; } else {})
    // (if attrs ? KillSignal && attrs.KillSignal != null then { killSignal = attrs.KillSignal; } else {})
    // (if attrs ? KillTimeout && attrs.KillTimeout != null then { killTimeout = attrs.KillTimeout; } else {})
    // (if attrs ? LogConfig && attrs.LogConfig != null then { logs = LogConfig.fromJSON attrs.LogConfig; } else {})
    // (if attrs ? Meta && attrs.Meta != null then { meta = attrs.Meta; } else {})
    // (if attrs ? Name && attrs.Name != null then { name = attrs.Name; } else {})
    // (if attrs ? Resources && attrs.Resources != null then { resources = Resources.fromJSON attrs.Resources; } else {})
    // (if attrs ? ShutdownDelay && attrs.ShutdownDelay != null then { shutdownDelay = attrs.ShutdownDelay; } else {})
    // (if attrs ? User && attrs.User != null then { user = attrs.User; } else {})
    // (if attrs ? VolumeMounts && builtins.isList attrs.VolumeMounts then { volumeMounts = builtins.map VolumeMount.fromJSON attrs.VolumeMounts; } else {})
  );

  # Convert a Spread Nix module into a JSON object.
  _module.transformers.Spread.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attribute && attrs.attribute != null then { Attribute = attrs.attribute; } else {})
    // (if attrs ? target && builtins.isAttrs attrs.target then { SpreadTarget = mapAttrsToList (_: SpreadTarget.toJSON) attrs.target; } else {})
    // (if attrs ? weight && attrs.weight != null then { Weight = attrs.weight; } else {})
  );

  # Convert a Spread JSON object into a Nix module.
  _module.transformers.Spread.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Attribute && attrs.Attribute != null then { attribute = attrs.Attribute; } else {})
    // (if attrs ? SpreadTarget && builtins.isList attrs.SpreadTarget then { target = builtins.listToAttrs (builtins.map (v: nameValuePair v.Value (SpreadTarget.fromJSON v)) attrs.SpreadTarget); } else {})
    // (if attrs ? Weight && attrs.Weight != null then { weight = attrs.Weight; } else {})
  );

  # Convert a SpreadTarget Nix module into a JSON object.
  _module.transformers.SpreadTarget.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? percent && attrs.percent != null then { Percent = attrs.percent; } else {})
    // (if attrs ? value && attrs.value != null then { Value = attrs.value; } else {})
  );

  # Convert a SpreadTarget JSON object into a Nix module.
  _module.transformers.SpreadTarget.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Percent && attrs.Percent != null then { percent = attrs.Percent; } else {})
    // (if attrs ? Value && attrs.Value != null then { value = attrs.Value; } else {})
  );

  # Convert a Task Nix module into a JSON object.
  _module.transformers.Task.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? action && builtins.isAttrs attrs.action then { Actions = mapAttrsToList (_: Action.toJSON) attrs.action; } else {})
    // (if attrs ? affinities && builtins.isList attrs.affinities then { Affinities = builtins.map Affinity.toJSON attrs.affinities; } else {})
    // (if attrs ? artifacts && builtins.isList attrs.artifacts then { Artifacts = builtins.map TaskArtifact.toJSON attrs.artifacts; } else {})
    // (if attrs ? config && attrs.config != null then { Config = attrs.config; } else {})
    // (if attrs ? constraints && builtins.isList attrs.constraints then { Constraints = builtins.map Constraint.toJSON attrs.constraints; } else {})
    // (if attrs ? consul && attrs.consul != null then { Consul = Consul.toJSON attrs.consul; } else {})
    // (if attrs ? csiPlugin && attrs.csiPlugin != null then { CSIPluginConfig = TaskCsiPluginConfig.toJSON attrs.csiPlugin; } else {})
    // (if attrs ? dispatchPayload && attrs.dispatchPayload != null then { DispatchPayload = DispatchPayloadConfig.toJSON attrs.dispatchPayload; } else {})
    // (if attrs ? driver && attrs.driver != null then { Driver = attrs.driver; } else {})
    // (if attrs ? env && attrs.env != null then { Env = attrs.env; } else {})
    // (if attrs ? identities && builtins.isList attrs.identities then { Identities = builtins.map WorkloadIdentity.toJSON attrs.identities; } else {})
    // (if attrs ? killSignal && attrs.killSignal != null then { KillSignal = attrs.killSignal; } else {})
    // (if attrs ? killTimeout && attrs.killTimeout != null then { KillTimeout = attrs.killTimeout; } else {})
    // (if attrs ? kind && attrs.kind != null then { Kind = attrs.kind; } else {})
    // (if attrs ? leader && attrs.leader != null then { Leader = attrs.leader; } else {})
    // (if attrs ? lifecycle && attrs.lifecycle != null then { Lifecycle = TaskLifecycle.toJSON attrs.lifecycle; } else {})
    // (if attrs ? logs && attrs.logs != null then { LogConfig = LogConfig.toJSON attrs.logs; } else {})
    // (if attrs ? meta && attrs.meta != null then { Meta = attrs.meta; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? resources && attrs.resources != null then { Resources = Resources.toJSON attrs.resources; } else {})
    // (if attrs ? restart && attrs.restart != null then { RestartPolicy = RestartPolicy.toJSON attrs.restart; } else {})
    // (if attrs ? scalings && builtins.isList attrs.scalings then { ScalingPolicies = builtins.map ScalingPolicy.toJSON attrs.scalings; } else {})
    // (if attrs ? schedule && attrs.schedule != null then { Schedule = TaskSchedule.toJSON attrs.schedule; } else {})
    // (if attrs ? services && builtins.isList attrs.services then { Services = builtins.map Service.toJSON attrs.services; } else {})
    // (if attrs ? shutdownDelay && attrs.shutdownDelay != null then { ShutdownDelay = attrs.shutdownDelay; } else {})
    // (if attrs ? templates && builtins.isList attrs.templates then { Templates = builtins.map Template.toJSON attrs.templates; } else {})
    // (if attrs ? user && attrs.user != null then { User = attrs.user; } else {})
    // (if attrs ? vault && attrs.vault != null then { Vault = Vault.toJSON attrs.vault; } else {})
    // (if attrs ? volumeMounts && builtins.isList attrs.volumeMounts then { VolumeMounts = builtins.map VolumeMount.toJSON attrs.volumeMounts; } else {})
  );

  # Convert a Task JSON object into a Nix module.
  _module.transformers.Task.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Actions && builtins.isList attrs.Actions then { action = builtins.listToAttrs (builtins.map (v: nameValuePair v.Name (Action.fromJSON v)) attrs.Actions); } else {})
    // (if attrs ? Affinities && builtins.isList attrs.Affinities then { affinities = builtins.map Affinity.fromJSON attrs.Affinities; } else {})
    // (if attrs ? Artifacts && builtins.isList attrs.Artifacts then { artifacts = builtins.map TaskArtifact.fromJSON attrs.Artifacts; } else {})
    // (if attrs ? Config && attrs.Config != null then { config = attrs.Config; } else {})
    // (if attrs ? Constraints && builtins.isList attrs.Constraints then { constraints = builtins.map Constraint.fromJSON attrs.Constraints; } else {})
    // (if attrs ? Consul && attrs.Consul != null then { consul = Consul.fromJSON attrs.Consul; } else {})
    // (if attrs ? CSIPluginConfig && attrs.CSIPluginConfig != null then { csiPlugin = TaskCsiPluginConfig.fromJSON attrs.CSIPluginConfig; } else {})
    // (if attrs ? DispatchPayload && attrs.DispatchPayload != null then { dispatchPayload = DispatchPayloadConfig.fromJSON attrs.DispatchPayload; } else {})
    // (if attrs ? Driver && attrs.Driver != null then { driver = attrs.Driver; } else {})
    // (if attrs ? Env && attrs.Env != null then { env = attrs.Env; } else {})
    // (if attrs ? Identities && builtins.isList attrs.Identities then { identities = builtins.map WorkloadIdentity.fromJSON attrs.Identities; } else {})
    // (if attrs ? KillSignal && attrs.KillSignal != null then { killSignal = attrs.KillSignal; } else {})
    // (if attrs ? KillTimeout && attrs.KillTimeout != null then { killTimeout = attrs.KillTimeout; } else {})
    // (if attrs ? Kind && attrs.Kind != null then { kind = attrs.Kind; } else {})
    // (if attrs ? Leader && attrs.Leader != null then { leader = attrs.Leader; } else {})
    // (if attrs ? Lifecycle && attrs.Lifecycle != null then { lifecycle = TaskLifecycle.fromJSON attrs.Lifecycle; } else {})
    // (if attrs ? LogConfig && attrs.LogConfig != null then { logs = LogConfig.fromJSON attrs.LogConfig; } else {})
    // (if attrs ? Meta && attrs.Meta != null then { meta = attrs.Meta; } else {})
    // (if attrs ? Name && attrs.Name != null then { name = attrs.Name; } else {})
    // (if attrs ? Resources && attrs.Resources != null then { resources = Resources.fromJSON attrs.Resources; } else {})
    // (if attrs ? RestartPolicy && attrs.RestartPolicy != null then { restart = RestartPolicy.fromJSON attrs.RestartPolicy; } else {})
    // (if attrs ? ScalingPolicies && builtins.isList attrs.ScalingPolicies then { scalings = builtins.map ScalingPolicy.fromJSON attrs.ScalingPolicies; } else {})
    // (if attrs ? Schedule && attrs.Schedule != null then { schedule = TaskSchedule.fromJSON attrs.Schedule; } else {})
    // (if attrs ? Services && builtins.isList attrs.Services then { services = builtins.map Service.fromJSON attrs.Services; } else {})
    // (if attrs ? ShutdownDelay && attrs.ShutdownDelay != null then { shutdownDelay = attrs.ShutdownDelay; } else {})
    // (if attrs ? Templates && builtins.isList attrs.Templates then { templates = builtins.map Template.fromJSON attrs.Templates; } else {})
    // (if attrs ? User && attrs.User != null then { user = attrs.User; } else {})
    // (if attrs ? Vault && attrs.Vault != null then { vault = Vault.fromJSON attrs.Vault; } else {})
    // (if attrs ? VolumeMounts && builtins.isList attrs.VolumeMounts then { volumeMounts = builtins.map VolumeMount.fromJSON attrs.VolumeMounts; } else {})
  );

  # Convert a TaskArtifact Nix module into a JSON object.
  _module.transformers.TaskArtifact.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? chown && attrs.chown != null then { Chown = attrs.chown; } else {})
    // (if attrs ? destination && attrs.destination != null then { RelativeDest = attrs.destination; } else {})
    // (if attrs ? headers && attrs.headers != null then { GetterHeaders = attrs.headers; } else {})
    // (if attrs ? insecure && attrs.insecure != null then { GetterInsecure = attrs.insecure; } else {})
    // (if attrs ? mode && attrs.mode != null then { GetterMode = attrs.mode; } else {})
    // (if attrs ? options && attrs.options != null then { GetterOptions = attrs.options; } else {})
    // (if attrs ? source && attrs.source != null then { GetterSource = attrs.source; } else {})
  );

  # Convert a TaskArtifact JSON object into a Nix module.
  _module.transformers.TaskArtifact.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Chown && attrs.Chown != null then { chown = attrs.Chown; } else {})
    // (if attrs ? RelativeDest && attrs.RelativeDest != null then { destination = attrs.RelativeDest; } else {})
    // (if attrs ? GetterHeaders && attrs.GetterHeaders != null then { headers = attrs.GetterHeaders; } else {})
    // (if attrs ? GetterInsecure && attrs.GetterInsecure != null then { insecure = attrs.GetterInsecure; } else {})
    // (if attrs ? GetterMode && attrs.GetterMode != null then { mode = attrs.GetterMode; } else {})
    // (if attrs ? GetterOptions && attrs.GetterOptions != null then { options = attrs.GetterOptions; } else {})
    // (if attrs ? GetterSource && attrs.GetterSource != null then { source = attrs.GetterSource; } else {})
  );

  # Convert a TaskCsiPluginConfig Nix module into a JSON object.
  _module.transformers.TaskCsiPluginConfig.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? healthTimeout && attrs.healthTimeout != null then { HealthTimeout = attrs.healthTimeout; } else {})
    // (if attrs ? id && attrs.id != null then { ID = attrs.id; } else {})
    // (if attrs ? mountDir && attrs.mountDir != null then { MountDir = attrs.mountDir; } else {})
    // (if attrs ? stagePublishBaseDir && attrs.stagePublishBaseDir != null then { StagePublishBaseDir = attrs.stagePublishBaseDir; } else {})
    // (if attrs ? type && attrs.type != null then { Type = attrs.type; } else {})
  );

  # Convert a TaskCsiPluginConfig JSON object into a Nix module.
  _module.transformers.TaskCsiPluginConfig.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? HealthTimeout && attrs.HealthTimeout != null then { healthTimeout = attrs.HealthTimeout; } else {})
    // (if attrs ? ID && attrs.ID != null then { id = attrs.ID; } else {})
    // (if attrs ? MountDir && attrs.MountDir != null then { mountDir = attrs.MountDir; } else {})
    // (if attrs ? StagePublishBaseDir && attrs.StagePublishBaseDir != null then { stagePublishBaseDir = attrs.StagePublishBaseDir; } else {})
    // (if attrs ? Type && attrs.Type != null then { type = attrs.Type; } else {})
  );

  # Convert a TaskGroup Nix module into a JSON object.
  _module.transformers.TaskGroup.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? affinities && builtins.isList attrs.affinities then { Affinities = builtins.map Affinity.toJSON attrs.affinities; } else {})
    // (if attrs ? constraints && builtins.isList attrs.constraints then { Constraints = builtins.map Constraint.toJSON attrs.constraints; } else {})
    // (if attrs ? consul && attrs.consul != null then { Consul = Consul.toJSON attrs.consul; } else {})
    // (if attrs ? count && attrs.count != null then { Count = attrs.count; } else {})
    // (if attrs ? disconnect && attrs.disconnect != null then { Disconnect = DisconnectStrategy.toJSON attrs.disconnect; } else {})
    // (if attrs ? ephemeralDisk && attrs.ephemeralDisk != null then { EphemeralDisk = EphemeralDisk.toJSON attrs.ephemeralDisk; } else {})
    // (if attrs ? maxClientDisconnect && attrs.maxClientDisconnect != null then { MaxClientDisconnect = attrs.maxClientDisconnect; } else {})
    // (if attrs ? meta && attrs.meta != null then { Meta = attrs.meta; } else {})
    // (if attrs ? migrate && attrs.migrate != null then { Migrate = MigrateStrategy.toJSON attrs.migrate; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? networks && builtins.isList attrs.networks then { Networks = builtins.map NetworkResource.toJSON attrs.networks; } else {})
    // (if attrs ? preventRescheduleOnLost && attrs.preventRescheduleOnLost != null then { PreventRescheduleOnLost = attrs.preventRescheduleOnLost; } else {})
    // (if attrs ? reschedule && attrs.reschedule != null then { ReschedulePolicy = ReschedulePolicy.toJSON attrs.reschedule; } else {})
    // (if attrs ? restart && attrs.restart != null then { RestartPolicy = RestartPolicy.toJSON attrs.restart; } else {})
    // (if attrs ? scaling && attrs.scaling != null then { Scaling = ScalingPolicy.toJSON attrs.scaling; } else {})
    // (if attrs ? services && builtins.isList attrs.services then { Services = builtins.map Service.toJSON attrs.services; } else {})
    // (if attrs ? shutdownDelay && attrs.shutdownDelay != null then { ShutdownDelay = attrs.shutdownDelay; } else {})
    // (if attrs ? spreads && builtins.isList attrs.spreads then { Spreads = builtins.map Spread.toJSON attrs.spreads; } else {})
    // (if attrs ? stopAfterClientDisconnect && attrs.stopAfterClientDisconnect != null then { StopAfterClientDisconnect = attrs.stopAfterClientDisconnect; } else {})
    // (if attrs ? task && builtins.isAttrs attrs.task then { Tasks = mapAttrsToList (_: Task.toJSON) attrs.task; } else {})
    // (if attrs ? update && attrs.update != null then { Update = UpdateStrategy.toJSON attrs.update; } else {})
    // (if attrs ? volume && builtins.isAttrs attrs.volume then { Volumes = mapAttrs (_: VolumeRequest.toJSON) attrs.volume; } else {})
  );

  # Convert a TaskGroup JSON object into a Nix module.
  _module.transformers.TaskGroup.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Affinities && builtins.isList attrs.Affinities then { affinities = builtins.map Affinity.fromJSON attrs.Affinities; } else {})
    // (if attrs ? Constraints && builtins.isList attrs.Constraints then { constraints = builtins.map Constraint.fromJSON attrs.Constraints; } else {})
    // (if attrs ? Consul && attrs.Consul != null then { consul = Consul.fromJSON attrs.Consul; } else {})
    // (if attrs ? Count && attrs.Count != null then { count = attrs.Count; } else {})
    // (if attrs ? Disconnect && attrs.Disconnect != null then { disconnect = DisconnectStrategy.fromJSON attrs.Disconnect; } else {})
    // (if attrs ? EphemeralDisk && attrs.EphemeralDisk != null then { ephemeralDisk = EphemeralDisk.fromJSON attrs.EphemeralDisk; } else {})
    // (if attrs ? MaxClientDisconnect && attrs.MaxClientDisconnect != null then { maxClientDisconnect = attrs.MaxClientDisconnect; } else {})
    // (if attrs ? Meta && attrs.Meta != null then { meta = attrs.Meta; } else {})
    // (if attrs ? Migrate && attrs.Migrate != null then { migrate = MigrateStrategy.fromJSON attrs.Migrate; } else {})
    // (if attrs ? Name && attrs.Name != null then { name = attrs.Name; } else {})
    // (if attrs ? Networks && builtins.isList attrs.Networks then { networks = builtins.map NetworkResource.fromJSON attrs.Networks; } else {})
    // (if attrs ? PreventRescheduleOnLost && attrs.PreventRescheduleOnLost != null then { preventRescheduleOnLost = attrs.PreventRescheduleOnLost; } else {})
    // (if attrs ? ReschedulePolicy && attrs.ReschedulePolicy != null then { reschedule = ReschedulePolicy.fromJSON attrs.ReschedulePolicy; } else {})
    // (if attrs ? RestartPolicy && attrs.RestartPolicy != null then { restart = RestartPolicy.fromJSON attrs.RestartPolicy; } else {})
    // (if attrs ? Scaling && attrs.Scaling != null then { scaling = ScalingPolicy.fromJSON attrs.Scaling; } else {})
    // (if attrs ? Services && builtins.isList attrs.Services then { services = builtins.map Service.fromJSON attrs.Services; } else {})
    // (if attrs ? ShutdownDelay && attrs.ShutdownDelay != null then { shutdownDelay = attrs.ShutdownDelay; } else {})
    // (if attrs ? Spreads && builtins.isList attrs.Spreads then { spreads = builtins.map Spread.fromJSON attrs.Spreads; } else {})
    // (if attrs ? StopAfterClientDisconnect && attrs.StopAfterClientDisconnect != null then { stopAfterClientDisconnect = attrs.StopAfterClientDisconnect; } else {})
    // (if attrs ? Tasks && builtins.isList attrs.Tasks then { task = builtins.listToAttrs (builtins.map (v: nameValuePair v.Name (Task.fromJSON v)) attrs.Tasks); } else {})
    // (if attrs ? Update && attrs.Update != null then { update = UpdateStrategy.fromJSON attrs.Update; } else {})
    // (if attrs ? Volumes && builtins.isList attrs.Volumes then { volume = builtins.listToAttrs (builtins.map (v: nameValuePair v.Name (VolumeRequest.fromJSON v)) attrs.Volumes); } else {})
  );

  # Convert a TaskLifecycle Nix module into a JSON object.
  _module.transformers.TaskLifecycle.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? hook && attrs.hook != null then { Hook = attrs.hook; } else {})
    // (if attrs ? sidecar && attrs.sidecar != null then { Sidecar = attrs.sidecar; } else {})
  );

  # Convert a TaskLifecycle JSON object into a Nix module.
  _module.transformers.TaskLifecycle.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Hook && attrs.Hook != null then { hook = attrs.Hook; } else {})
    // (if attrs ? Sidecar && attrs.Sidecar != null then { sidecar = attrs.Sidecar; } else {})
  );

  # Convert a TaskSchedule Nix module into a JSON object.
  _module.transformers.TaskSchedule.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? cron && attrs.cron != null then { Cron = TaskScheduleCron.toJSON attrs.cron; } else {})
  );

  # Convert a TaskSchedule JSON object into a Nix module.
  _module.transformers.TaskSchedule.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Cron && attrs.Cron != null then { cron = TaskScheduleCron.fromJSON attrs.Cron; } else {})
  );

  # Convert a TaskScheduleCron Nix module into a JSON object.
  _module.transformers.TaskScheduleCron.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? end && attrs.end != null then { End = attrs.end; } else {})
    // (if attrs ? start && attrs.start != null then { Start = attrs.start; } else {})
    // (if attrs ? timezone && attrs.timezone != null then { Timezone = attrs.timezone; } else {})
  );

  # Convert a TaskScheduleCron JSON object into a Nix module.
  _module.transformers.TaskScheduleCron.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? End && attrs.End != null then { end = attrs.End; } else {})
    // (if attrs ? Start && attrs.Start != null then { start = attrs.Start; } else {})
    // (if attrs ? Timezone && attrs.Timezone != null then { timezone = attrs.Timezone; } else {})
  );

  # Convert a Template Nix module into a JSON object.
  _module.transformers.Template.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? changeMode && attrs.changeMode != null then { ChangeMode = attrs.changeMode; } else {})
    // (if attrs ? changeScript && attrs.changeScript != null then { ChangeScript = ChangeScript.toJSON attrs.changeScript; } else {})
    // (if attrs ? changeSignal && attrs.changeSignal != null then { ChangeSignal = attrs.changeSignal; } else {})
    // (if attrs ? data && attrs.data != null then { EmbeddedTmpl = attrs.data; } else {})
    // (if attrs ? destination && attrs.destination != null then { DestPath = attrs.destination; } else {})
    // (if attrs ? env && attrs.env != null then { Envvars = attrs.env; } else {})
    // (if attrs ? errorOnMissingKey && attrs.errorOnMissingKey != null then { ErrMissingKey = attrs.errorOnMissingKey; } else {})
    // (if attrs ? gid && attrs.gid != null then { Gid = attrs.gid; } else {})
    // (if attrs ? leftDelimiter && attrs.leftDelimiter != null then { LeftDelim = attrs.leftDelimiter; } else {})
    // (if attrs ? perms && attrs.perms != null then { Perms = attrs.perms; } else {})
    // (if attrs ? rightDelimiter && attrs.rightDelimiter != null then { RightDelim = attrs.rightDelimiter; } else {})
    // (if attrs ? source && attrs.source != null then { SourcePath = attrs.source; } else {})
    // (if attrs ? splay && attrs.splay != null then { Splay = attrs.splay; } else {})
    // (if attrs ? uid && attrs.uid != null then { Uid = attrs.uid; } else {})
    // (if attrs ? vaultGrace && attrs.vaultGrace != null then { VaultGrace = attrs.vaultGrace; } else {})
    // (if attrs ? wait && attrs.wait != null then { Wait = WaitConfig.toJSON attrs.wait; } else {})
  );

  # Convert a Template JSON object into a Nix module.
  _module.transformers.Template.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? ChangeMode && attrs.ChangeMode != null then { changeMode = attrs.ChangeMode; } else {})
    // (if attrs ? ChangeScript && attrs.ChangeScript != null then { changeScript = ChangeScript.fromJSON attrs.ChangeScript; } else {})
    // (if attrs ? ChangeSignal && attrs.ChangeSignal != null then { changeSignal = attrs.ChangeSignal; } else {})
    // (if attrs ? EmbeddedTmpl && attrs.EmbeddedTmpl != null then { data = attrs.EmbeddedTmpl; } else {})
    // (if attrs ? DestPath && attrs.DestPath != null then { destination = attrs.DestPath; } else {})
    // (if attrs ? Envvars && attrs.Envvars != null then { env = attrs.Envvars; } else {})
    // (if attrs ? ErrMissingKey && attrs.ErrMissingKey != null then { errorOnMissingKey = attrs.ErrMissingKey; } else {})
    // (if attrs ? Gid && attrs.Gid != null then { gid = attrs.Gid; } else {})
    // (if attrs ? LeftDelim && attrs.LeftDelim != null then { leftDelimiter = attrs.LeftDelim; } else {})
    // (if attrs ? Perms && attrs.Perms != null then { perms = attrs.Perms; } else {})
    // (if attrs ? RightDelim && attrs.RightDelim != null then { rightDelimiter = attrs.RightDelim; } else {})
    // (if attrs ? SourcePath && attrs.SourcePath != null then { source = attrs.SourcePath; } else {})
    // (if attrs ? Splay && attrs.Splay != null then { splay = attrs.Splay; } else {})
    // (if attrs ? Uid && attrs.Uid != null then { uid = attrs.Uid; } else {})
    // (if attrs ? VaultGrace && attrs.VaultGrace != null then { vaultGrace = attrs.VaultGrace; } else {})
    // (if attrs ? Wait && attrs.Wait != null then { wait = WaitConfig.fromJSON attrs.Wait; } else {})
  );

  # Convert a UpdateStrategy Nix module into a JSON object.
  _module.transformers.UpdateStrategy.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
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

  # Convert a UpdateStrategy JSON object into a Nix module.
  _module.transformers.UpdateStrategy.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? AutoPromote && attrs.AutoPromote != null then { autoPromote = attrs.AutoPromote; } else {})
    // (if attrs ? AutoRevert && attrs.AutoRevert != null then { autoRevert = attrs.AutoRevert; } else {})
    // (if attrs ? Canary && attrs.Canary != null then { canary = attrs.Canary; } else {})
    // (if attrs ? HealthCheck && attrs.HealthCheck != null then { healthCheck = attrs.HealthCheck; } else {})
    // (if attrs ? HealthyDeadline && attrs.HealthyDeadline != null then { healthyDeadline = attrs.HealthyDeadline; } else {})
    // (if attrs ? MaxParallel && attrs.MaxParallel != null then { maxParallel = attrs.MaxParallel; } else {})
    // (if attrs ? MinHealthyTime && attrs.MinHealthyTime != null then { minHealthyTime = attrs.MinHealthyTime; } else {})
    // (if attrs ? ProgressDeadline && attrs.ProgressDeadline != null then { progressDeadline = attrs.ProgressDeadline; } else {})
    // (if attrs ? Stagger && attrs.Stagger != null then { stagger = attrs.Stagger; } else {})
  );

  # Convert a Vault Nix module into a JSON object.
  _module.transformers.Vault.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? allowTokenExpiration && attrs.allowTokenExpiration != null then { AllowTokenExpiration = attrs.allowTokenExpiration; } else {})
    // (if attrs ? changeMode && attrs.changeMode != null then { ChangeMode = attrs.changeMode; } else {})
    // (if attrs ? changeSignal && attrs.changeSignal != null then { ChangeSignal = attrs.changeSignal; } else {})
    // (if attrs ? cluster && attrs.cluster != null then { Cluster = attrs.cluster; } else {})
    // (if attrs ? disableFile && attrs.disableFile != null then { DisableFile = attrs.disableFile; } else {})
    // (if attrs ? env && attrs.env != null then { Env = attrs.env; } else {})
    // (if attrs ? namespace && attrs.namespace != null then { Namespace = attrs.namespace; } else {})
    // (if attrs ? policies && attrs.policies != null then { Policies = attrs.policies; } else {})
    // (if attrs ? role && attrs.role != null then { Role = attrs.role; } else {})
  );

  # Convert a Vault JSON object into a Nix module.
  _module.transformers.Vault.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? AllowTokenExpiration && attrs.AllowTokenExpiration != null then { allowTokenExpiration = attrs.AllowTokenExpiration; } else {})
    // (if attrs ? ChangeMode && attrs.ChangeMode != null then { changeMode = attrs.ChangeMode; } else {})
    // (if attrs ? ChangeSignal && attrs.ChangeSignal != null then { changeSignal = attrs.ChangeSignal; } else {})
    // (if attrs ? Cluster && attrs.Cluster != null then { cluster = attrs.Cluster; } else {})
    // (if attrs ? DisableFile && attrs.DisableFile != null then { disableFile = attrs.DisableFile; } else {})
    // (if attrs ? Env && attrs.Env != null then { env = attrs.Env; } else {})
    // (if attrs ? Namespace && attrs.Namespace != null then { namespace = attrs.Namespace; } else {})
    // (if attrs ? Policies && attrs.Policies != null then { policies = attrs.Policies; } else {})
    // (if attrs ? Role && attrs.Role != null then { role = attrs.Role; } else {})
  );

  # Convert a VolumeMount Nix module into a JSON object.
  _module.transformers.VolumeMount.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? destination && attrs.destination != null then { Destination = attrs.destination; } else {})
    // (if attrs ? propagationMode && attrs.propagationMode != null then { PropagationMode = attrs.propagationMode; } else {})
    // (if attrs ? readOnly && attrs.readOnly != null then { ReadOnly = attrs.readOnly; } else {})
    // (if attrs ? selinuxLabel && attrs.selinuxLabel != null then { SELinuxLabel = attrs.selinuxLabel; } else {})
    // (if attrs ? volume && attrs.volume != null then { Volume = attrs.volume; } else {})
  );

  # Convert a VolumeMount JSON object into a Nix module.
  _module.transformers.VolumeMount.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Destination && attrs.Destination != null then { destination = attrs.Destination; } else {})
    // (if attrs ? PropagationMode && attrs.PropagationMode != null then { propagationMode = attrs.PropagationMode; } else {})
    // (if attrs ? ReadOnly && attrs.ReadOnly != null then { readOnly = attrs.ReadOnly; } else {})
    // (if attrs ? SELinuxLabel && attrs.SELinuxLabel != null then { selinuxLabel = attrs.SELinuxLabel; } else {})
    // (if attrs ? Volume && attrs.Volume != null then { volume = attrs.Volume; } else {})
  );

  # Convert a VolumeRequest Nix module into a JSON object.
  _module.transformers.VolumeRequest.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? accessMode && attrs.accessMode != null then { AccessMode = attrs.accessMode; } else {})
    // (if attrs ? attachmentMode && attrs.attachmentMode != null then { AttachmentMode = attrs.attachmentMode; } else {})
    // (if attrs ? mountOptions && attrs.mountOptions != null then { MountOptions = CsiMountOptions.toJSON attrs.mountOptions; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? perAlloc && attrs.perAlloc != null then { PerAlloc = attrs.perAlloc; } else {})
    // (if attrs ? readOnly && attrs.readOnly != null then { ReadOnly = attrs.readOnly; } else {})
    // (if attrs ? source && attrs.source != null then { Source = attrs.source; } else {})
    // (if attrs ? sticky && attrs.sticky != null then { Sticky = attrs.sticky; } else {})
    // (if attrs ? type && attrs.type != null then { Type = attrs.type; } else {})
  );

  # Convert a VolumeRequest JSON object into a Nix module.
  _module.transformers.VolumeRequest.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? AccessMode && attrs.AccessMode != null then { accessMode = attrs.AccessMode; } else {})
    // (if attrs ? AttachmentMode && attrs.AttachmentMode != null then { attachmentMode = attrs.AttachmentMode; } else {})
    // (if attrs ? MountOptions && attrs.MountOptions != null then { mountOptions = CsiMountOptions.fromJSON attrs.MountOptions; } else {})
    // (if attrs ? Name && attrs.Name != null then { name = attrs.Name; } else {})
    // (if attrs ? PerAlloc && attrs.PerAlloc != null then { perAlloc = attrs.PerAlloc; } else {})
    // (if attrs ? ReadOnly && attrs.ReadOnly != null then { readOnly = attrs.ReadOnly; } else {})
    // (if attrs ? Source && attrs.Source != null then { source = attrs.Source; } else {})
    // (if attrs ? Sticky && attrs.Sticky != null then { sticky = attrs.Sticky; } else {})
    // (if attrs ? Type && attrs.Type != null then { type = attrs.Type; } else {})
  );

  # Convert a WaitConfig Nix module into a JSON object.
  _module.transformers.WaitConfig.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? max && attrs.max != null then { Max = attrs.max; } else {})
    // (if attrs ? min && attrs.min != null then { Min = attrs.min; } else {})
  );

  # Convert a WaitConfig JSON object into a Nix module.
  _module.transformers.WaitConfig.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Max && attrs.Max != null then { max = attrs.Max; } else {})
    // (if attrs ? Min && attrs.Min != null then { min = attrs.Min; } else {})
  );

  # Convert a WorkloadIdentity Nix module into a JSON object.
  _module.transformers.WorkloadIdentity.toJSON = with lib; with config._module.transformers; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? aud && attrs.aud != null then { Audience = attrs.aud; } else {})
    // (if attrs ? changeMode && attrs.changeMode != null then { ChangeMode = attrs.changeMode; } else {})
    // (if attrs ? changeSignal && attrs.changeSignal != null then { ChangeSignal = attrs.changeSignal; } else {})
    // (if attrs ? env && attrs.env != null then { Env = attrs.env; } else {})
    // (if attrs ? file && attrs.file != null then { File = attrs.file; } else {})
    // (if attrs ? filepath && attrs.filepath != null then { Filepath = attrs.filepath; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? serviceName && attrs.serviceName != null then { ServiceName = attrs.serviceName; } else {})
    // (if attrs ? ttl && attrs.ttl != null then { TTL = attrs.ttl; } else {})
  );

  # Convert a WorkloadIdentity JSON object into a Nix module.
  _module.transformers.WorkloadIdentity.fromJSON = with lib; with config._module.transformers; attrs: (
    {}
    // (if attrs ? Audience && attrs.Audience != null then { aud = attrs.Audience; } else {})
    // (if attrs ? ChangeMode && attrs.ChangeMode != null then { changeMode = attrs.ChangeMode; } else {})
    // (if attrs ? ChangeSignal && attrs.ChangeSignal != null then { changeSignal = attrs.ChangeSignal; } else {})
    // (if attrs ? Env && attrs.Env != null then { env = attrs.Env; } else {})
    // (if attrs ? File && attrs.File != null then { file = attrs.File; } else {})
    // (if attrs ? Filepath && attrs.Filepath != null then { filepath = attrs.Filepath; } else {})
    // (if attrs ? Name && attrs.Name != null then { name = attrs.Name; } else {})
    // (if attrs ? ServiceName && attrs.ServiceName != null then { serviceName = attrs.ServiceName; } else {})
    // (if attrs ? TTL && attrs.TTL != null then { ttl = attrs.TTL; } else {})
  );
}
