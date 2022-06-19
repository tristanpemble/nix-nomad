{ lib }:

rec {
  Affinity = with lib; with lib.types; {
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
  };
  CSIMountOptions = with lib; with lib.types; {
    options.fsType = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.mountFlags = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
  };
  CheckRestart = with lib; with lib.types; {
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
  };
  Constraint = with lib; with lib.types; {
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
  };
  Consul = with lib; with lib.types; {
    options.namespace = mkOption {
      type = (nullOr str);
      default = null;
    };
  };
  ConsulConnect = with lib; with lib.types; {
    options.gateway = mkOption {
      type = (nullOr (submodule ConsulGateway));
      default = null;
    };
    options.native = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.sidecarService = mkOption {
      type = (nullOr (submodule ConsulSidecarService));
      default = null;
    };
    options.sidecarTask = mkOption {
      type = (nullOr (submodule SidecarTask));
      default = null;
    };
  };
  ConsulExposeConfig = with lib; with lib.types; {
    options.path = mkOption {
      type = (nullOr (listOf (either (listOf (submodule ConsulExposePath)) (attrsOf (submodule ConsulExposePath)))));
      default = null;
    };
  };
  ConsulExposePath = with lib; with lib.types; {
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
  };
  ConsulGateway = with lib; with lib.types; {
    options.ingress = mkOption {
      type = (nullOr (submodule ConsulIngressConfigEntry));
      default = null;
    };
    options.mesh = mkOption {
      type = (nullOr (submodule ConsulMeshConfigEntry));
      default = null;
    };
    options.proxy = mkOption {
      type = (nullOr (submodule ConsulGatewayProxy));
      default = null;
    };
    options.terminating = mkOption {
      type = (nullOr (submodule ConsulTerminatingConfigEntry));
      default = null;
    };
  };
  ConsulGatewayBindAddress = with lib; with lib.types; {
    options.address = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.port = mkOption {
      type = (nullOr int);
      default = null;
    };
  };
  ConsulGatewayProxy = with lib; with lib.types; {
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
      type = (nullOr (either (listOf (submodule ConsulGatewayBindAddress)) (attrsOf (submodule ConsulGatewayBindAddress))));
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
  };
  ConsulGatewayTLSConfig = with lib; with lib.types; {
    options.enabled = mkOption {
      type = (nullOr bool);
      default = null;
    };
  };
  ConsulIngressConfigEntry = with lib; with lib.types; {
    options.listener = mkOption {
      type = (nullOr (listOf (either (listOf (submodule ConsulIngressListener)) (attrsOf (submodule ConsulIngressListener)))));
      default = null;
    };
    options.tls = mkOption {
      type = (nullOr (submodule ConsulGatewayTLSConfig));
      default = null;
    };
  };
  ConsulIngressListener = with lib; with lib.types; {
    options.port = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.protocol = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.service = mkOption {
      type = (nullOr (listOf (either (listOf (submodule ConsulIngressService)) (attrsOf (submodule ConsulIngressService)))));
      default = null;
    };
  };
  ConsulIngressService = with lib; with lib.types; {
    options.hosts = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
    options.name = mkOption {
      type = (nullOr str);
      default = null;
    };
  };
  ConsulLinkedService = with lib; with lib.types; {
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
  };
  ConsulMeshConfigEntry = with lib; with lib.types; {
  };
  ConsulMeshGateway = with lib; with lib.types; {
    options.mode = mkOption {
      type = (nullOr str);
      default = null;
    };
  };
  ConsulProxy = with lib; with lib.types; {
    options.config = mkOption {
      type = (nullOr (attrsOf anything));
      default = null;
    };
    options.expose = mkOption {
      type = (nullOr (submodule ConsulExposeConfig));
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
      type = (nullOr (listOf (either (listOf (submodule ConsulUpstream)) (attrsOf (submodule ConsulUpstream)))));
      default = null;
    };
  };
  ConsulSidecarService = with lib; with lib.types; {
    options.disableDefaultTcpCheck = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.port = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.proxy = mkOption {
      type = (nullOr (submodule ConsulProxy));
      default = null;
    };
    options.tags = mkOption {
      type = (nullOr (listOf str));
      default = null;
    };
  };
  ConsulTerminatingConfigEntry = with lib; with lib.types; {
    options.service = mkOption {
      type = (nullOr (listOf (either (listOf (submodule ConsulLinkedService)) (attrsOf (submodule ConsulLinkedService)))));
      default = null;
    };
  };
  ConsulUpstream = with lib; with lib.types; {
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
      type = (nullOr (submodule ConsulMeshGateway));
      default = null;
    };
  };
  DNSConfig = with lib; with lib.types; {
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
  };
  DispatchPayloadConfig = with lib; with lib.types; {
    options.file = mkOption {
      type = (nullOr str);
      default = null;
    };
  };
  EphemeralDisk = with lib; with lib.types; {
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
  };
  Job = with lib; with lib.types; {
    options.affinity = mkOption {
      type = (nullOr (listOf (either (listOf (submodule Affinity)) (attrsOf (submodule Affinity)))));
      default = null;
    };
    options.allAtOnce = mkOption {
      type = (nullOr bool);
      default = null;
    };
    options.constraint = mkOption {
      type = (nullOr (listOf (either (listOf (submodule Constraint)) (attrsOf (submodule Constraint)))));
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
      type = (nullOr (either (listOf (submodule TaskGroup)) (attrsOf (submodule TaskGroup))));
      default = null;
    };
    options.meta = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.migrate = mkOption {
      type = (nullOr (submodule MigrateStrategy));
      default = null;
    };
    options.multiregion = mkOption {
      type = (nullOr (submodule Multiregion));
      default = null;
    };
    options.namespace = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.parameterized = mkOption {
      type = (nullOr (submodule ParameterizedJobConfig));
      default = null;
    };
    options.periodic = mkOption {
      type = (nullOr (submodule PeriodicConfig));
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
      type = (nullOr (submodule ReschedulePolicy));
      default = null;
    };
    options.spread = mkOption {
      type = (nullOr (listOf (either (listOf (submodule Spread)) (attrsOf (submodule Spread)))));
      default = null;
    };
    options.type = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.update = mkOption {
      type = (nullOr (submodule UpdateStrategy));
      default = null;
    };
    options.vaultToken = mkOption {
      type = (nullOr str);
      default = null;
    };
  };
  LogConfig = with lib; with lib.types; {
    options.maxFileSize = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.maxFiles = mkOption {
      type = (nullOr int);
      default = null;
    };
  };
  MigrateStrategy = with lib; with lib.types; {
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
  };
  Multiregion = with lib; with lib.types; {
    options.region = mkOption {
      type = (nullOr (either (listOf (submodule MultiregionRegion)) (attrsOf (submodule MultiregionRegion))));
      default = null;
    };
    options.strategy = mkOption {
      type = (nullOr (submodule MultiregionStrategy));
      default = null;
    };
  };
  MultiregionRegion = with lib; with lib.types; {
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
  };
  MultiregionStrategy = with lib; with lib.types; {
    options.maxParallel = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.onFailure = mkOption {
      type = (nullOr str);
      default = null;
    };
  };
  NetworkResource = with lib; with lib.types; {
    options.cidr = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.device = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.dns = mkOption {
      type = (nullOr (submodule DNSConfig));
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
      type = (nullOr (either (listOf (submodule Port)) (attrsOf (submodule Port))));
      default = null;
    };
    options.reservedPorts = mkOption {
      type = (nullOr (either (listOf (submodule Port)) (attrsOf (submodule Port))));
      default = null;
    };
  };
  ParameterizedJobConfig = with lib; with lib.types; {
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
  };
  PeriodicConfig = with lib; with lib.types; {
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
  };
  Port = with lib; with lib.types; {
    options.hostNetwork = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.static = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.to = mkOption {
      type = (nullOr int);
      default = null;
    };
  };
  RequestedDevice = with lib; with lib.types; {
    options.affinity = mkOption {
      type = (nullOr (listOf (either (listOf (submodule Affinity)) (attrsOf (submodule Affinity)))));
      default = null;
    };
    options.constraint = mkOption {
      type = (nullOr (listOf (either (listOf (submodule Constraint)) (attrsOf (submodule Constraint)))));
      default = null;
    };
    options.count = mkOption {
      type = (nullOr ints.unsigned);
      default = null;
    };
  };
  ReschedulePolicy = with lib; with lib.types; {
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
  };
  Resources = with lib; with lib.types; {
    options.cores = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.cpu = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.device = mkOption {
      type = (nullOr (either (listOf (submodule RequestedDevice)) (attrsOf (submodule RequestedDevice))));
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
    options.network = mkOption {
      type = (nullOr (listOf (either (listOf (submodule NetworkResource)) (attrsOf (submodule NetworkResource)))));
      default = null;
    };
  };
  RestartPolicy = with lib; with lib.types; {
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
  };
  ScalingPolicy = with lib; with lib.types; {
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
  };
  Service = with lib; with lib.types; {
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
    options.check = mkOption {
      type = (nullOr (listOf (either (listOf (submodule ServiceCheck)) (attrsOf (submodule ServiceCheck)))));
      default = null;
    };
    options.checkRestart = mkOption {
      type = (nullOr (submodule CheckRestart));
      default = null;
    };
    options.connect = mkOption {
      type = (nullOr (submodule ConsulConnect));
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
  };
  ServiceCheck = with lib; with lib.types; {
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
      type = (nullOr (submodule CheckRestart));
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
  };
  SidecarTask = with lib; with lib.types; {
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
      type = (nullOr (submodule LogConfig));
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
      type = (nullOr (submodule Resources));
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
  };
  Spread = with lib; with lib.types; {
    options.attribute = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.target = mkOption {
      type = (nullOr (either (listOf (submodule SpreadTarget)) (attrsOf (submodule SpreadTarget))));
      default = null;
    };
    options.weight = mkOption {
      type = (nullOr int);
      default = null;
    };
  };
  SpreadTarget = with lib; with lib.types; {
    options.percent = mkOption {
      type = (nullOr ints.unsigned);
      default = null;
    };
  };
  Task = with lib; with lib.types; {
    options.affinity = mkOption {
      type = (nullOr (listOf (either (listOf (submodule Affinity)) (attrsOf (submodule Affinity)))));
      default = null;
    };
    options.artifact = mkOption {
      type = (nullOr (listOf (either (listOf (submodule TaskArtifact)) (attrsOf (submodule TaskArtifact)))));
      default = null;
    };
    options.config = mkOption {
      type = (nullOr (attrsOf anything));
      default = null;
    };
    options.constraint = mkOption {
      type = (nullOr (listOf (either (listOf (submodule Constraint)) (attrsOf (submodule Constraint)))));
      default = null;
    };
    options.csiPlugin = mkOption {
      type = (nullOr (submodule TaskCSIPluginConfig));
      default = null;
    };
    options.dispatchPayload = mkOption {
      type = (nullOr (submodule DispatchPayloadConfig));
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
      type = (nullOr (submodule TaskLifecycle));
      default = null;
    };
    options.logs = mkOption {
      type = (nullOr (submodule LogConfig));
      default = null;
    };
    options.meta = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.resources = mkOption {
      type = (nullOr (submodule Resources));
      default = null;
    };
    options.restart = mkOption {
      type = (nullOr (submodule RestartPolicy));
      default = null;
    };
    options.scaling = mkOption {
      type = (nullOr (listOf (either (listOf (submodule ScalingPolicy)) (attrsOf (submodule ScalingPolicy)))));
      default = null;
    };
    options.service = mkOption {
      type = (nullOr (listOf (either (listOf (submodule Service)) (attrsOf (submodule Service)))));
      default = null;
    };
    options.shutdownDelay = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.template = mkOption {
      type = (nullOr (listOf (either (listOf (submodule Template)) (attrsOf (submodule Template)))));
      default = null;
    };
    options.user = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.vault = mkOption {
      type = (nullOr (submodule Vault));
      default = null;
    };
    options.volumeMount = mkOption {
      type = (nullOr (listOf (either (listOf (submodule VolumeMount)) (attrsOf (submodule VolumeMount)))));
      default = null;
    };
  };
  TaskArtifact = with lib; with lib.types; {
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
  };
  TaskCSIPluginConfig = with lib; with lib.types; {
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
  };
  TaskGroup = with lib; with lib.types; {
    options.affinity = mkOption {
      type = (nullOr (listOf (either (listOf (submodule Affinity)) (attrsOf (submodule Affinity)))));
      default = null;
    };
    options.constraint = mkOption {
      type = (nullOr (listOf (either (listOf (submodule Constraint)) (attrsOf (submodule Constraint)))));
      default = null;
    };
    options.consul = mkOption {
      type = (nullOr (submodule Consul));
      default = null;
    };
    options.count = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.ephemeralDisk = mkOption {
      type = (nullOr (submodule EphemeralDisk));
      default = null;
    };
    options.meta = mkOption {
      type = (nullOr (attrsOf str));
      default = null;
    };
    options.migrate = mkOption {
      type = (nullOr (submodule MigrateStrategy));
      default = null;
    };
    options.network = mkOption {
      type = (nullOr (listOf (either (listOf (submodule NetworkResource)) (attrsOf (submodule NetworkResource)))));
      default = null;
    };
    options.reschedule = mkOption {
      type = (nullOr (submodule ReschedulePolicy));
      default = null;
    };
    options.restart = mkOption {
      type = (nullOr (submodule RestartPolicy));
      default = null;
    };
    options.scaling = mkOption {
      type = (nullOr (submodule ScalingPolicy));
      default = null;
    };
    options.service = mkOption {
      type = (nullOr (listOf (either (listOf (submodule Service)) (attrsOf (submodule Service)))));
      default = null;
    };
    options.shutdownDelay = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.spread = mkOption {
      type = (nullOr (listOf (either (listOf (submodule Spread)) (attrsOf (submodule Spread)))));
      default = null;
    };
    options.stopAfterClientDisconnect = mkOption {
      type = (nullOr int);
      default = null;
    };
    options.task = mkOption {
      type = (nullOr (either (listOf (submodule Task)) (attrsOf (submodule Task))));
      default = null;
    };
    options.update = mkOption {
      type = (nullOr (submodule UpdateStrategy));
      default = null;
    };
    options.volume = mkOption {
      type = (nullOr (either (listOf (submodule VolumeRequest)) (attrsOf (submodule VolumeRequest))));
      default = null;
    };
  };
  TaskLifecycle = with lib; with lib.types; {
    options.hook = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.sidecar = mkOption {
      type = (nullOr bool);
      default = null;
    };
  };
  Template = with lib; with lib.types; {
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
      type = (nullOr (submodule WaitConfig));
      default = null;
    };
  };
  UpdateStrategy = with lib; with lib.types; {
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
  };
  Vault = with lib; with lib.types; {
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
  };
  VolumeMount = with lib; with lib.types; {
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
  };
  VolumeRequest = with lib; with lib.types; {
    options.accessMode = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.attachmentMode = mkOption {
      type = (nullOr str);
      default = null;
    };
    options.mountOptions = mkOption {
      type = (nullOr (submodule CSIMountOptions));
      default = null;
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
  };
  WaitConfig = with lib; with lib.types; {
    options.max = mkOption {
      type = int;
    };
    options.min = mkOption {
      type = int;
    };
  };
  mkAffinityAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attribute && attrs.attribute != null then { LTarget = attrs.attribute; } else {})
    // (if attrs ? operator && attrs.operator != null then { Operand = attrs.operator; } else {})
    // (if attrs ? value && attrs.value != null then { RTarget = attrs.value; } else {})
    // (if attrs ? weight && attrs.weight != null then { Weight = attrs.weight; } else {})
  );
  mkCSIMountOptionsAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? fsType && attrs.fsType != null then { FSType = attrs.fsType; } else {})
    // (if attrs ? mountFlags && attrs.mountFlags != null then { MountFlags = attrs.mountFlags; } else {})
  );
  mkCheckRestartAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? grace && attrs.grace != null then { Grace = attrs.grace; } else {})
    // (if attrs ? ignoreWarnings && attrs.ignoreWarnings != null then { IgnoreWarnings = attrs.ignoreWarnings; } else {})
    // (if attrs ? limit && attrs.limit != null then { Limit = attrs.limit; } else {})
  );
  mkConstraintAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attribute && attrs.attribute != null then { LTarget = attrs.attribute; } else {})
    // (if attrs ? operator && attrs.operator != null then { Operand = attrs.operator; } else {})
    // (if attrs ? value && attrs.value != null then { RTarget = attrs.value; } else {})
  );
  mkConsulAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? namespace && attrs.namespace != null then { Namespace = attrs.namespace; } else {})
  );
  mkConsulConnectAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? gateway && attrs.gateway != null then { Gateway = mkConsulGatewayAPI attrs.gateway; } else {})
    // (if attrs ? native && attrs.native != null then { Native = attrs.native; } else {})
    // (if attrs ? sidecarService && attrs.sidecarService != null then { SidecarService = mkConsulSidecarServiceAPI attrs.sidecarService; } else {})
    // (if attrs ? sidecarTask && attrs.sidecarTask != null then { SidecarTask = mkSidecarTaskAPI attrs.sidecarTask; } else {})
  );
  mkConsulExposeConfigAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? path && builtins.isList attrs.path then { Path = builtins.map mkConsulExposePathAPI attrs.path; } else {})
  );
  mkConsulExposePathAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? listenerPort && attrs.listenerPort != null then { ListenerPort = attrs.listenerPort; } else {})
    // (if attrs ? localPathPort && attrs.localPathPort != null then { LocalPathPort = attrs.localPathPort; } else {})
    // (if attrs ? path && attrs.path != null then { Path = attrs.path; } else {})
    // (if attrs ? protocol && attrs.protocol != null then { Protocol = attrs.protocol; } else {})
  );
  mkConsulGatewayAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? ingress && attrs.ingress != null then { Ingress = mkConsulIngressConfigEntryAPI attrs.ingress; } else {})
    // (if attrs ? mesh && attrs.mesh != null then { Mesh = mkConsulMeshConfigEntryAPI attrs.mesh; } else {})
    // (if attrs ? proxy && attrs.proxy != null then { Proxy = mkConsulGatewayProxyAPI attrs.proxy; } else {})
    // (if attrs ? terminating && attrs.terminating != null then { Terminating = mkConsulTerminatingConfigEntryAPI attrs.terminating; } else {})
  );
  mkConsulGatewayBindAddressAPI = with lib; label: attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // ({ Name = label; })
    // (if attrs ? address && attrs.address != null then { Address = attrs.address; } else {})
    // (if attrs ? port && attrs.port != null then { Port = attrs.port; } else {})
  );
  mkConsulGatewayProxyAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? config && attrs.config != null then { Config = attrs.config; } else {})
    // (if attrs ? connectTimeout && attrs.connectTimeout != null then { ConnectTimeout = attrs.connectTimeout; } else {})
    // (if attrs ? envoyDnsDiscoveryType && attrs.envoyDnsDiscoveryType != null then { EnvoyDNSDiscoveryType = attrs.envoyDnsDiscoveryType; } else {})
    // (if attrs ? envoyGatewayBindAddresses && builtins.isAttrs attrs.envoyGatewayBindAddresses then { EnvoyGatewayBindAddresses = mapAttrsToList mkConsulGatewayBindAddressAPI attrs.envoyGatewayBindAddresses; } else {})
    // (if attrs ? envoyGatewayBindTaggedAddresses && attrs.envoyGatewayBindTaggedAddresses != null then { EnvoyGatewayBindTaggedAddresses = attrs.envoyGatewayBindTaggedAddresses; } else {})
    // (if attrs ? envoyGatewayNoDefaultBind && attrs.envoyGatewayNoDefaultBind != null then { EnvoyGatewayNoDefaultBind = attrs.envoyGatewayNoDefaultBind; } else {})
  );
  mkConsulGatewayTLSConfigAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? enabled && attrs.enabled != null then { Enabled = attrs.enabled; } else {})
  );
  mkConsulIngressConfigEntryAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? listener && builtins.isList attrs.listener then { Listeners = builtins.map mkConsulIngressListenerAPI attrs.listener; } else {})
    // (if attrs ? tls && attrs.tls != null then { TLS = mkConsulGatewayTLSConfigAPI attrs.tls; } else {})
  );
  mkConsulIngressListenerAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? port && attrs.port != null then { Port = attrs.port; } else {})
    // (if attrs ? protocol && attrs.protocol != null then { Protocol = attrs.protocol; } else {})
    // (if attrs ? service && builtins.isList attrs.service then { Services = builtins.map mkConsulIngressServiceAPI attrs.service; } else {})
  );
  mkConsulIngressServiceAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? hosts && attrs.hosts != null then { Hosts = attrs.hosts; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
  );
  mkConsulLinkedServiceAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? caFile && attrs.caFile != null then { CAFile = attrs.caFile; } else {})
    // (if attrs ? certFile && attrs.certFile != null then { CertFile = attrs.certFile; } else {})
    // (if attrs ? keyFile && attrs.keyFile != null then { KeyFile = attrs.keyFile; } else {})
    // (if attrs ? name && attrs.name != null then { Name = attrs.name; } else {})
    // (if attrs ? sni && attrs.sni != null then { SNI = attrs.sni; } else {})
  );
  mkConsulMeshConfigEntryAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
  );
  mkConsulMeshGatewayAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? mode && attrs.mode != null then { Mode = attrs.mode; } else {})
  );
  mkConsulProxyAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? config && attrs.config != null then { Config = attrs.config; } else {})
    // (if attrs ? expose && attrs.expose != null then { ExposeConfig = mkConsulExposeConfigAPI attrs.expose; } else {})
    // (if attrs ? localServiceAddress && attrs.localServiceAddress != null then { LocalServiceAddress = attrs.localServiceAddress; } else {})
    // (if attrs ? localServicePort && attrs.localServicePort != null then { LocalServicePort = attrs.localServicePort; } else {})
    // (if attrs ? upstreams && builtins.isList attrs.upstreams then { Upstreams = builtins.map mkConsulUpstreamAPI attrs.upstreams; } else {})
  );
  mkConsulSidecarServiceAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? disableDefaultTcpCheck && attrs.disableDefaultTcpCheck != null then { DisableDefaultTCPCheck = attrs.disableDefaultTcpCheck; } else {})
    // (if attrs ? port && attrs.port != null then { Port = attrs.port; } else {})
    // (if attrs ? proxy && attrs.proxy != null then { Proxy = mkConsulProxyAPI attrs.proxy; } else {})
    // (if attrs ? tags && attrs.tags != null then { Tags = attrs.tags; } else {})
  );
  mkConsulTerminatingConfigEntryAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? service && builtins.isList attrs.service then { Services = builtins.map mkConsulLinkedServiceAPI attrs.service; } else {})
  );
  mkConsulUpstreamAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? datacenter && attrs.datacenter != null then { Datacenter = attrs.datacenter; } else {})
    // (if attrs ? destinationName && attrs.destinationName != null then { DestinationName = attrs.destinationName; } else {})
    // (if attrs ? localBindAddress && attrs.localBindAddress != null then { LocalBindAddress = attrs.localBindAddress; } else {})
    // (if attrs ? localBindPort && attrs.localBindPort != null then { LocalBindPort = attrs.localBindPort; } else {})
    // (if attrs ? meshGateway && attrs.meshGateway != null then { MeshGateway = mkConsulMeshGatewayAPI attrs.meshGateway; } else {})
  );
  mkDNSConfigAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? options && attrs.options != null then { Options = attrs.options; } else {})
    // (if attrs ? searches && attrs.searches != null then { Searches = attrs.searches; } else {})
    // (if attrs ? servers && attrs.servers != null then { Servers = attrs.servers; } else {})
  );
  mkDispatchPayloadConfigAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? file && attrs.file != null then { File = attrs.file; } else {})
  );
  mkEphemeralDiskAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? migrate && attrs.migrate != null then { Migrate = attrs.migrate; } else {})
    // (if attrs ? size && attrs.size != null then { SizeMB = attrs.size; } else {})
    // (if attrs ? sticky && attrs.sticky != null then { Sticky = attrs.sticky; } else {})
  );
  mkJobAPI = with lib; label: attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? affinity && builtins.isList attrs.affinity then { Affinities = builtins.map mkAffinityAPI attrs.affinity; } else {})
    // (if attrs ? allAtOnce && attrs.allAtOnce != null then { AllAtOnce = attrs.allAtOnce; } else {})
    // (if attrs ? constraint && builtins.isList attrs.constraint then { Constraints = builtins.map mkConstraintAPI attrs.constraint; } else {})
    // (if attrs ? consulToken && attrs.consulToken != null then { ConsulToken = attrs.consulToken; } else {})
    // (if attrs ? datacenters && attrs.datacenters != null then { Datacenters = attrs.datacenters; } else {})
    // (if attrs ? group && builtins.isAttrs attrs.group then { TaskGroups = mapAttrsToList mkTaskGroupAPI attrs.group; } else {})
    // ({ ID = label; })
    // (if attrs ? meta && attrs.meta != null then { Meta = attrs.meta; } else {})
    // (if attrs ? migrate && attrs.migrate != null then { Migrate = mkMigrateStrategyAPI attrs.migrate; } else {})
    // (if attrs ? multiregion && attrs.multiregion != null then { Multiregion = mkMultiregionAPI attrs.multiregion; } else {})
    // ({ Name = label; })
    // (if attrs ? namespace && attrs.namespace != null then { Namespace = attrs.namespace; } else {})
    // (if attrs ? parameterized && attrs.parameterized != null then { ParameterizedJob = mkParameterizedJobConfigAPI attrs.parameterized; } else {})
    // (if attrs ? periodic && attrs.periodic != null then { Periodic = mkPeriodicConfigAPI attrs.periodic; } else {})
    // (if attrs ? priority && attrs.priority != null then { Priority = attrs.priority; } else {})
    // (if attrs ? region && attrs.region != null then { Region = attrs.region; } else {})
    // (if attrs ? reschedule && attrs.reschedule != null then { Reschedule = mkReschedulePolicyAPI attrs.reschedule; } else {})
    // (if attrs ? spread && builtins.isList attrs.spread then { Spreads = builtins.map mkSpreadAPI attrs.spread; } else {})
    // (if attrs ? type && attrs.type != null then { Type = attrs.type; } else {})
    // (if attrs ? update && attrs.update != null then { Update = mkUpdateStrategyAPI attrs.update; } else {})
    // (if attrs ? vaultToken && attrs.vaultToken != null then { VaultToken = attrs.vaultToken; } else {})
  );
  mkLogConfigAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? maxFileSize && attrs.maxFileSize != null then { MaxFileSizeMB = attrs.maxFileSize; } else {})
    // (if attrs ? maxFiles && attrs.maxFiles != null then { MaxFiles = attrs.maxFiles; } else {})
  );
  mkMigrateStrategyAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? healthCheck && attrs.healthCheck != null then { HealthCheck = attrs.healthCheck; } else {})
    // (if attrs ? healthyDeadline && attrs.healthyDeadline != null then { HealthyDeadline = attrs.healthyDeadline; } else {})
    // (if attrs ? maxParallel && attrs.maxParallel != null then { MaxParallel = attrs.maxParallel; } else {})
    // (if attrs ? minHealthyTime && attrs.minHealthyTime != null then { MinHealthyTime = attrs.minHealthyTime; } else {})
  );
  mkMultiregionAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? region && builtins.isAttrs attrs.region then { Regions = mapAttrsToList mkMultiregionRegionAPI attrs.region; } else {})
    // (if attrs ? strategy && attrs.strategy != null then { Strategy = mkMultiregionStrategyAPI attrs.strategy; } else {})
  );
  mkMultiregionRegionAPI = with lib; label: attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // ({ Name = label; })
    // (if attrs ? count && attrs.count != null then { Count = attrs.count; } else {})
    // (if attrs ? datacenters && attrs.datacenters != null then { Datacenters = attrs.datacenters; } else {})
    // (if attrs ? meta && attrs.meta != null then { Meta = attrs.meta; } else {})
  );
  mkMultiregionStrategyAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? maxParallel && attrs.maxParallel != null then { MaxParallel = attrs.maxParallel; } else {})
    // (if attrs ? onFailure && attrs.onFailure != null then { OnFailure = attrs.onFailure; } else {})
  );
  mkNetworkResourceAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? cidr && attrs.cidr != null then { CIDR = attrs.cidr; } else {})
    // (if attrs ? device && attrs.device != null then { Device = attrs.device; } else {})
    // (if attrs ? dns && attrs.dns != null then { DNS = mkDNSConfigAPI attrs.dns; } else {})
    // (if attrs ? hostname && attrs.hostname != null then { Hostname = attrs.hostname; } else {})
    // (if attrs ? ip && attrs.ip != null then { IP = attrs.ip; } else {})
    // (if attrs ? mbits && attrs.mbits != null then { MBits = attrs.mbits; } else {})
    // (if attrs ? mode && attrs.mode != null then { Mode = attrs.mode; } else {})
    // (if attrs ? port && builtins.isAttrs attrs.port then { DynamicPorts = mapAttrsToList mkPortAPI attrs.port; } else {})
    // (if attrs ? reservedPorts && builtins.isAttrs attrs.reservedPorts then { ReservedPorts = mapAttrsToList mkPortAPI attrs.reservedPorts; } else {})
  );
  mkParameterizedJobConfigAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? metaOptional && attrs.metaOptional != null then { MetaOptional = attrs.metaOptional; } else {})
    // (if attrs ? metaRequired && attrs.metaRequired != null then { MetaRequired = attrs.metaRequired; } else {})
    // (if attrs ? payload && attrs.payload != null then { Payload = attrs.payload; } else {})
  );
  mkPeriodicConfigAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? cron && attrs.cron != null then { Spec = attrs.cron; } else {})
    // (if attrs ? enabled && attrs.enabled != null then { Enabled = attrs.enabled; } else {})
    // (if attrs ? prohibitOverlap && attrs.prohibitOverlap != null then { ProhibitOverlap = attrs.prohibitOverlap; } else {})
    // (if attrs ? timeZone && attrs.timeZone != null then { TimeZone = attrs.timeZone; } else {})
  );
  mkPortAPI = with lib; label: attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // ({ Label = label; })
    // (if attrs ? hostNetwork && attrs.hostNetwork != null then { HostNetwork = attrs.hostNetwork; } else {})
    // (if attrs ? static && attrs.static != null then { Value = attrs.static; } else {})
    // (if attrs ? to && attrs.to != null then { To = attrs.to; } else {})
  );
  mkRequestedDeviceAPI = with lib; label: attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // ({ Name = label; })
    // (if attrs ? affinity && builtins.isList attrs.affinity then { Affinities = builtins.map mkAffinityAPI attrs.affinity; } else {})
    // (if attrs ? constraint && builtins.isList attrs.constraint then { Constraints = builtins.map mkConstraintAPI attrs.constraint; } else {})
    // (if attrs ? count && attrs.count != null then { Count = attrs.count; } else {})
  );
  mkReschedulePolicyAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attempts && attrs.attempts != null then { Attempts = attrs.attempts; } else {})
    // (if attrs ? delay && attrs.delay != null then { Delay = attrs.delay; } else {})
    // (if attrs ? delayFunction && attrs.delayFunction != null then { DelayFunction = attrs.delayFunction; } else {})
    // (if attrs ? interval && attrs.interval != null then { Interval = attrs.interval; } else {})
    // (if attrs ? maxDelay && attrs.maxDelay != null then { MaxDelay = attrs.maxDelay; } else {})
    // (if attrs ? unlimited && attrs.unlimited != null then { Unlimited = attrs.unlimited; } else {})
  );
  mkResourcesAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? cores && attrs.cores != null then { Cores = attrs.cores; } else {})
    // (if attrs ? cpu && attrs.cpu != null then { CPU = attrs.cpu; } else {})
    // (if attrs ? device && builtins.isAttrs attrs.device then { Devices = mapAttrsToList mkRequestedDeviceAPI attrs.device; } else {})
    // (if attrs ? disk && attrs.disk != null then { DiskMB = attrs.disk; } else {})
    // (if attrs ? iops && attrs.iops != null then { IOPS = attrs.iops; } else {})
    // (if attrs ? memory && attrs.memory != null then { MemoryMB = attrs.memory; } else {})
    // (if attrs ? memoryMax && attrs.memoryMax != null then { MemoryMaxMB = attrs.memoryMax; } else {})
    // (if attrs ? network && builtins.isList attrs.network then { Networks = builtins.map mkNetworkResourceAPI attrs.network; } else {})
  );
  mkRestartPolicyAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attempts && attrs.attempts != null then { Attempts = attrs.attempts; } else {})
    // (if attrs ? delay && attrs.delay != null then { Delay = attrs.delay; } else {})
    // (if attrs ? interval && attrs.interval != null then { Interval = attrs.interval; } else {})
    // (if attrs ? mode && attrs.mode != null then { Mode = attrs.mode; } else {})
  );
  mkScalingPolicyAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? enabled && attrs.enabled != null then { Enabled = attrs.enabled; } else {})
    // (if attrs ? max && attrs.max != null then { Max = attrs.max; } else {})
    // (if attrs ? min && attrs.min != null then { Min = attrs.min; } else {})
    // (if attrs ? policy && attrs.policy != null then { Policy = attrs.policy; } else {})
    // (if attrs ? type && attrs.type != null then { Type = attrs.type; } else {})
  );
  mkServiceAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? addressMode && attrs.addressMode != null then { AddressMode = attrs.addressMode; } else {})
    // (if attrs ? canaryMeta && attrs.canaryMeta != null then { CanaryMeta = attrs.canaryMeta; } else {})
    // (if attrs ? canaryTags && attrs.canaryTags != null then { CanaryTags = attrs.canaryTags; } else {})
    // (if attrs ? check && builtins.isList attrs.check then { Checks = builtins.map mkServiceCheckAPI attrs.check; } else {})
    // (if attrs ? checkRestart && attrs.checkRestart != null then { CheckRestart = mkCheckRestartAPI attrs.checkRestart; } else {})
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
  mkServiceCheckAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
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
  mkSidecarTaskAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
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
  mkSpreadAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attribute && attrs.attribute != null then { Attribute = attrs.attribute; } else {})
    // (if attrs ? target && builtins.isAttrs attrs.target then { SpreadTarget = mapAttrsToList mkSpreadTargetAPI attrs.target; } else {})
    // (if attrs ? weight && attrs.weight != null then { Weight = attrs.weight; } else {})
  );
  mkSpreadTargetAPI = with lib; label: attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // ({ Value = label; })
    // (if attrs ? percent && attrs.percent != null then { Percent = attrs.percent; } else {})
  );
  mkTaskAPI = with lib; label: attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? affinity && builtins.isList attrs.affinity then { Affinities = builtins.map mkAffinityAPI attrs.affinity; } else {})
    // (if attrs ? artifact && builtins.isList attrs.artifact then { Artifacts = builtins.map mkTaskArtifactAPI attrs.artifact; } else {})
    // (if attrs ? config && attrs.config != null then { Config = attrs.config; } else {})
    // (if attrs ? constraint && builtins.isList attrs.constraint then { Constraints = builtins.map mkConstraintAPI attrs.constraint; } else {})
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
    // ({ Name = label; })
    // (if attrs ? resources && attrs.resources != null then { Resources = mkResourcesAPI attrs.resources; } else {})
    // (if attrs ? restart && attrs.restart != null then { RestartPolicy = mkRestartPolicyAPI attrs.restart; } else {})
    // (if attrs ? scaling && builtins.isList attrs.scaling then { ScalingPolicies = builtins.map mkScalingPolicyAPI attrs.scaling; } else {})
    // (if attrs ? service && builtins.isList attrs.service then { Services = builtins.map mkServiceAPI attrs.service; } else {})
    // (if attrs ? shutdownDelay && attrs.shutdownDelay != null then { ShutdownDelay = attrs.shutdownDelay; } else {})
    // (if attrs ? template && builtins.isList attrs.template then { Templates = builtins.map mkTemplateAPI attrs.template; } else {})
    // (if attrs ? user && attrs.user != null then { User = attrs.user; } else {})
    // (if attrs ? vault && attrs.vault != null then { Vault = mkVaultAPI attrs.vault; } else {})
    // (if attrs ? volumeMount && builtins.isList attrs.volumeMount then { VolumeMounts = builtins.map mkVolumeMountAPI attrs.volumeMount; } else {})
  );
  mkTaskArtifactAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? destination && attrs.destination != null then { RelativeDest = attrs.destination; } else {})
    // (if attrs ? headers && attrs.headers != null then { GetterHeaders = attrs.headers; } else {})
    // (if attrs ? mode && attrs.mode != null then { GetterMode = attrs.mode; } else {})
    // (if attrs ? options && attrs.options != null then { GetterOptions = attrs.options; } else {})
    // (if attrs ? source && attrs.source != null then { GetterSource = attrs.source; } else {})
  );
  mkTaskCSIPluginConfigAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? id && attrs.id != null then { ID = attrs.id; } else {})
    // (if attrs ? mountDir && attrs.mountDir != null then { MountDir = attrs.mountDir; } else {})
    // (if attrs ? type && attrs.type != null then { Type = attrs.type; } else {})
  );
  mkTaskGroupAPI = with lib; label: attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? affinity && builtins.isList attrs.affinity then { Affinities = builtins.map mkAffinityAPI attrs.affinity; } else {})
    // (if attrs ? constraint && builtins.isList attrs.constraint then { Constraints = builtins.map mkConstraintAPI attrs.constraint; } else {})
    // (if attrs ? consul && attrs.consul != null then { Consul = mkConsulAPI attrs.consul; } else {})
    // (if attrs ? count && attrs.count != null then { Count = attrs.count; } else {})
    // (if attrs ? ephemeralDisk && attrs.ephemeralDisk != null then { EphemeralDisk = mkEphemeralDiskAPI attrs.ephemeralDisk; } else {})
    // (if attrs ? meta && attrs.meta != null then { Meta = attrs.meta; } else {})
    // (if attrs ? migrate && attrs.migrate != null then { Migrate = mkMigrateStrategyAPI attrs.migrate; } else {})
    // ({ Name = label; })
    // (if attrs ? network && builtins.isList attrs.network then { Networks = builtins.map mkNetworkResourceAPI attrs.network; } else {})
    // (if attrs ? reschedule && attrs.reschedule != null then { ReschedulePolicy = mkReschedulePolicyAPI attrs.reschedule; } else {})
    // (if attrs ? restart && attrs.restart != null then { RestartPolicy = mkRestartPolicyAPI attrs.restart; } else {})
    // (if attrs ? scaling && attrs.scaling != null then { Scaling = mkScalingPolicyAPI attrs.scaling; } else {})
    // (if attrs ? service && builtins.isList attrs.service then { Services = builtins.map mkServiceAPI attrs.service; } else {})
    // (if attrs ? shutdownDelay && attrs.shutdownDelay != null then { ShutdownDelay = attrs.shutdownDelay; } else {})
    // (if attrs ? spread && builtins.isList attrs.spread then { Spreads = builtins.map mkSpreadAPI attrs.spread; } else {})
    // (if attrs ? stopAfterClientDisconnect && attrs.stopAfterClientDisconnect != null then { StopAfterClientDisconnect = attrs.stopAfterClientDisconnect; } else {})
    // (if attrs ? task && builtins.isAttrs attrs.task then { Tasks = mapAttrsToList mkTaskAPI attrs.task; } else {})
    // (if attrs ? update && attrs.update != null then { Update = mkUpdateStrategyAPI attrs.update; } else {})
    // (if attrs ? volume && builtins.isAttrs attrs.volume then { Volumes = mapAttrsToList mkVolumeRequestAPI attrs.volume; } else {})
  );
  mkTaskLifecycleAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? hook && attrs.hook != null then { Hook = attrs.hook; } else {})
    // (if attrs ? sidecar && attrs.sidecar != null then { Sidecar = attrs.sidecar; } else {})
  );
  mkTemplateAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
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
  mkUpdateStrategyAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
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
  mkVaultAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? changeMode && attrs.changeMode != null then { ChangeMode = attrs.changeMode; } else {})
    // (if attrs ? changeSignal && attrs.changeSignal != null then { ChangeSignal = attrs.changeSignal; } else {})
    // (if attrs ? env && attrs.env != null then { Env = attrs.env; } else {})
    // (if attrs ? namespace && attrs.namespace != null then { Namespace = attrs.namespace; } else {})
    // (if attrs ? policies && attrs.policies != null then { Policies = attrs.policies; } else {})
  );
  mkVolumeMountAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? destination && attrs.destination != null then { Destination = attrs.destination; } else {})
    // (if attrs ? propagationMode && attrs.propagationMode != null then { PropagationMode = attrs.propagationMode; } else {})
    // (if attrs ? readOnly && attrs.readOnly != null then { ReadOnly = attrs.readOnly; } else {})
    // (if attrs ? volume && attrs.volume != null then { Volume = attrs.volume; } else {})
  );
  mkVolumeRequestAPI = with lib; label: attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? accessMode && attrs.accessMode != null then { AccessMode = attrs.accessMode; } else {})
    // (if attrs ? attachmentMode && attrs.attachmentMode != null then { AttachmentMode = attrs.attachmentMode; } else {})
    // (if attrs ? mountOptions && attrs.mountOptions != null then { MountOptions = mkCSIMountOptionsAPI attrs.mountOptions; } else {})
    // ({ Name = label; })
    // (if attrs ? perAlloc && attrs.perAlloc != null then { PerAlloc = attrs.perAlloc; } else {})
    // (if attrs ? readOnly && attrs.readOnly != null then { ReadOnly = attrs.readOnly; } else {})
    // (if attrs ? source && attrs.source != null then { Source = attrs.source; } else {})
    // (if attrs ? type && attrs.type != null then { Type = attrs.type; } else {})
  );
  mkWaitConfigAPI = with lib; attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? max && attrs.max != null then { Max = attrs.max; } else {})
    // (if attrs ? min && attrs.min != null then { Min = attrs.min; } else {})
  );
}
