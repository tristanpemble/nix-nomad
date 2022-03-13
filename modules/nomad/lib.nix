{ lib, overrides, ... }:

rec {
  Affinity = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.attribute = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Affinity or {}).attribute or {}));
      options.operator = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Affinity or {}).operator or {}));
      options.value = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Affinity or {}).value or {}));
      options.weight = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.Affinity or {}).weight or {}));
    });

  CSIMountOptions = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.fsType = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.CSIMountOptions or {}).fsType or {}));
      options.mountFlags = lib.mkOption ({
        type = (nullOr (listOf str));
        default = null;
      } // ((overrides.CSIMountOptions or {}).mountFlags or {}));
    });

  CheckRestart = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.grace = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.CheckRestart or {}).grace or {}));
      options.ignoreWarnings = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.CheckRestart or {}).ignoreWarnings or {}));
      options.limit = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.CheckRestart or {}).limit or {}));
    });

  Constraint = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.attribute = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Constraint or {}).attribute or {}));
      options.operator = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Constraint or {}).operator or {}));
      options.value = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Constraint or {}).value or {}));
    });

  Consul = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.namespace = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Consul or {}).namespace or {}));
    });

  ConsulConnect = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.gateway = lib.mkOption ({
        type = (nullOr ConsulGateway);
        default = null;
      } // ((overrides.ConsulConnect or {}).gateway or {}));
      options.native = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.ConsulConnect or {}).native or {}));
      options.sidecarService = lib.mkOption ({
        type = (nullOr ConsulSidecarService);
        default = null;
      } // ((overrides.ConsulConnect or {}).sidecarService or {}));
      options.sidecarTask = lib.mkOption ({
        type = (nullOr SidecarTask);
        default = null;
      } // ((overrides.ConsulConnect or {}).sidecarTask or {}));
    });

  ConsulExposeConfig = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.paths = lib.mkOption ({
        type = (nullOr (listOf ConsulExposePath));
        default = null;
      } // ((overrides.ConsulExposeConfig or {}).paths or {}));
    });

  ConsulExposePath = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.listenerPort = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulExposePath or {}).listenerPort or {}));
      options.localPathPort = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.ConsulExposePath or {}).localPathPort or {}));
      options.path = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulExposePath or {}).path or {}));
      options.protocol = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulExposePath or {}).protocol or {}));
    });

  ConsulGateway = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.ingress = lib.mkOption ({
        type = (nullOr ConsulIngressConfigEntry);
        default = null;
      } // ((overrides.ConsulGateway or {}).ingress or {}));
      options.mesh = lib.mkOption ({
        type = (nullOr ConsulMeshConfigEntry);
        default = null;
      } // ((overrides.ConsulGateway or {}).mesh or {}));
      options.proxy = lib.mkOption ({
        type = (nullOr ConsulGatewayProxy);
        default = null;
      } // ((overrides.ConsulGateway or {}).proxy or {}));
      options.terminating = lib.mkOption ({
        type = (nullOr ConsulTerminatingConfigEntry);
        default = null;
      } // ((overrides.ConsulGateway or {}).terminating or {}));
    });

  ConsulGatewayBindAddress = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.address = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulGatewayBindAddress or {}).address or {}));
      options.port = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.ConsulGatewayBindAddress or {}).port or {}));
    });

  ConsulGatewayProxy = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.config = lib.mkOption ({
        type = (nullOr (attrsOf anything));
        default = null;
      } // ((overrides.ConsulGatewayProxy or {}).config or {}));
      options.connectTimeout = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.ConsulGatewayProxy or {}).connectTimeout or {}));
      options.envoyDnsDiscoveryType = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulGatewayProxy or {}).envoyDnsDiscoveryType or {}));
      options.envoyGatewayBindAddresses = lib.mkOption ({
        type = (nullOr (attrsOf ConsulGatewayBindAddress));
        default = null;
      } // ((overrides.ConsulGatewayProxy or {}).envoyGatewayBindAddresses or {}));
      options.envoyGatewayBindTaggedAddresses = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.ConsulGatewayProxy or {}).envoyGatewayBindTaggedAddresses or {}));
      options.envoyGatewayNoDefaultBind = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.ConsulGatewayProxy or {}).envoyGatewayNoDefaultBind or {}));
    });

  ConsulGatewayTLSConfig = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.enabled = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.ConsulGatewayTLSConfig or {}).enabled or {}));
    });

  ConsulIngressConfigEntry = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.listeners = lib.mkOption ({
        type = (nullOr (listOf ConsulIngressListener));
        default = null;
      } // ((overrides.ConsulIngressConfigEntry or {}).listeners or {}));
      options.tls = lib.mkOption ({
        type = (nullOr ConsulGatewayTLSConfig);
        default = null;
      } // ((overrides.ConsulIngressConfigEntry or {}).tls or {}));
    });

  ConsulIngressListener = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.port = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.ConsulIngressListener or {}).port or {}));
      options.protocol = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulIngressListener or {}).protocol or {}));
      options.services = lib.mkOption ({
        type = (nullOr (listOf ConsulIngressService));
        default = null;
      } // ((overrides.ConsulIngressListener or {}).services or {}));
    });

  ConsulIngressService = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.hosts = lib.mkOption ({
        type = (nullOr (listOf str));
        default = null;
      } // ((overrides.ConsulIngressService or {}).hosts or {}));
      options.name = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulIngressService or {}).name or {}));
    });

  ConsulLinkedService = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.caFile = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulLinkedService or {}).caFile or {}));
      options.certFile = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulLinkedService or {}).certFile or {}));
      options.keyFile = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulLinkedService or {}).keyFile or {}));
      options.name = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulLinkedService or {}).name or {}));
      options.sni = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulLinkedService or {}).sni or {}));
    });

  ConsulMeshConfigEntry = lib.types.submodule ({ lib, ... }:
    with lib.types; {
    });

  ConsulMeshGateway = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.mode = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulMeshGateway or {}).mode or {}));
    });

  ConsulProxy = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.config = lib.mkOption ({
        type = (nullOr (attrsOf anything));
        default = null;
      } // ((overrides.ConsulProxy or {}).config or {}));
      options.expose = lib.mkOption ({
        type = (nullOr ConsulExposeConfig);
        default = null;
      } // ((overrides.ConsulProxy or {}).expose or {}));
      options.localServiceAddress = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulProxy or {}).localServiceAddress or {}));
      options.localServicePort = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.ConsulProxy or {}).localServicePort or {}));
      options.upstreams = lib.mkOption ({
        type = (nullOr (listOf ConsulUpstream));
        default = null;
      } // ((overrides.ConsulProxy or {}).upstreams or {}));
    });

  ConsulSidecarService = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.disableDefaultTcpCheck = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.ConsulSidecarService or {}).disableDefaultTcpCheck or {}));
      options.port = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulSidecarService or {}).port or {}));
      options.proxy = lib.mkOption ({
        type = (nullOr ConsulProxy);
        default = null;
      } // ((overrides.ConsulSidecarService or {}).proxy or {}));
      options.tags = lib.mkOption ({
        type = (nullOr (listOf str));
        default = null;
      } // ((overrides.ConsulSidecarService or {}).tags or {}));
    });

  ConsulTerminatingConfigEntry = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.services = lib.mkOption ({
        type = (nullOr (listOf ConsulLinkedService));
        default = null;
      } // ((overrides.ConsulTerminatingConfigEntry or {}).services or {}));
    });

  ConsulUpstream = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.datacenter = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulUpstream or {}).datacenter or {}));
      options.destinationName = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulUpstream or {}).destinationName or {}));
      options.localBindAddress = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ConsulUpstream or {}).localBindAddress or {}));
      options.localBindPort = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.ConsulUpstream or {}).localBindPort or {}));
      options.meshGateway = lib.mkOption ({
        type = (nullOr ConsulMeshGateway);
        default = null;
      } // ((overrides.ConsulUpstream or {}).meshGateway or {}));
    });

  DNSConfig = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.options = lib.mkOption ({
        type = (nullOr (listOf str));
        default = null;
      } // ((overrides.DNSConfig or {}).options or {}));
      options.searches = lib.mkOption ({
        type = (nullOr (listOf str));
        default = null;
      } // ((overrides.DNSConfig or {}).searches or {}));
      options.servers = lib.mkOption ({
        type = (nullOr (listOf str));
        default = null;
      } // ((overrides.DNSConfig or {}).servers or {}));
    });

  DispatchPayloadConfig = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.file = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.DispatchPayloadConfig or {}).file or {}));
    });

  EphemeralDisk = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.migrate = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.EphemeralDisk or {}).migrate or {}));
      options.size = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.EphemeralDisk or {}).size or {}));
      options.sticky = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.EphemeralDisk or {}).sticky or {}));
    });

  Job = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.affinities = lib.mkOption ({
        type = (nullOr (listOf Affinity));
        default = null;
      } // ((overrides.Job or {}).affinities or {}));
      options.allAtOnce = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.Job or {}).allAtOnce or {}));
      options.constraints = lib.mkOption ({
        type = (nullOr (listOf Constraint));
        default = null;
      } // ((overrides.Job or {}).constraints or {}));
      options.consulToken = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Job or {}).consulToken or {}));
      options.datacenters = lib.mkOption ({
        type = (nullOr (listOf str));
        default = null;
      } // ((overrides.Job or {}).datacenters or {}));
      options.groups = lib.mkOption ({
        type = (nullOr (attrsOf TaskGroup));
        default = null;
      } // ((overrides.Job or {}).groups or {}));
      options.id = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Job or {}).id or {}));
      options.meta = lib.mkOption ({
        type = (nullOr (attrsOf str));
        default = null;
      } // ((overrides.Job or {}).meta or {}));
      options.migrate = lib.mkOption ({
        type = (nullOr MigrateStrategy);
        default = null;
      } // ((overrides.Job or {}).migrate or {}));
      options.multiregion = lib.mkOption ({
        type = (nullOr Multiregion);
        default = null;
      } // ((overrides.Job or {}).multiregion or {}));
      options.name = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Job or {}).name or {}));
      options.namespace = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Job or {}).namespace or {}));
      options.parameterized = lib.mkOption ({
        type = (nullOr ParameterizedJobConfig);
        default = null;
      } // ((overrides.Job or {}).parameterized or {}));
      options.periodic = lib.mkOption ({
        type = (nullOr PeriodicConfig);
        default = null;
      } // ((overrides.Job or {}).periodic or {}));
      options.priority = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.Job or {}).priority or {}));
      options.region = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Job or {}).region or {}));
      options.reschedule = lib.mkOption ({
        type = (nullOr ReschedulePolicy);
        default = null;
      } // ((overrides.Job or {}).reschedule or {}));
      options.spreads = lib.mkOption ({
        type = (nullOr (listOf Spread));
        default = null;
      } // ((overrides.Job or {}).spreads or {}));
      options.type = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Job or {}).type or {}));
      options.update = lib.mkOption ({
        type = (nullOr UpdateStrategy);
        default = null;
      } // ((overrides.Job or {}).update or {}));
      options.vaultToken = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Job or {}).vaultToken or {}));
    });

  LogConfig = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.maxFileSize = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.LogConfig or {}).maxFileSize or {}));
      options.maxFiles = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.LogConfig or {}).maxFiles or {}));
    });

  MigrateStrategy = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.healthCheck = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.MigrateStrategy or {}).healthCheck or {}));
      options.healthyDeadline = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.MigrateStrategy or {}).healthyDeadline or {}));
      options.maxParallel = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.MigrateStrategy or {}).maxParallel or {}));
      options.minHealthyTime = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.MigrateStrategy or {}).minHealthyTime or {}));
    });

  Multiregion = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.regions = lib.mkOption ({
        type = (nullOr (attrsOf MultiregionRegion));
        default = null;
      } // ((overrides.Multiregion or {}).regions or {}));
      options.strategy = lib.mkOption ({
        type = (nullOr MultiregionStrategy);
        default = null;
      } // ((overrides.Multiregion or {}).strategy or {}));
    });

  MultiregionRegion = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.count = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.MultiregionRegion or {}).count or {}));
      options.datacenters = lib.mkOption ({
        type = (nullOr (listOf str));
        default = null;
      } // ((overrides.MultiregionRegion or {}).datacenters or {}));
      options.meta = lib.mkOption ({
        type = (nullOr (attrsOf str));
        default = null;
      } // ((overrides.MultiregionRegion or {}).meta or {}));
    });

  MultiregionStrategy = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.maxParallel = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.MultiregionStrategy or {}).maxParallel or {}));
      options.onFailure = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.MultiregionStrategy or {}).onFailure or {}));
    });

  NetworkResource = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.cidr = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.NetworkResource or {}).cidr or {}));
      options.device = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.NetworkResource or {}).device or {}));
      options.dns = lib.mkOption ({
        type = (nullOr DNSConfig);
        default = null;
      } // ((overrides.NetworkResource or {}).dns or {}));
      options.hostname = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.NetworkResource or {}).hostname or {}));
      options.ip = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.NetworkResource or {}).ip or {}));
      options.mbits = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.NetworkResource or {}).mbits or {}));
      options.mode = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.NetworkResource or {}).mode or {}));
      options.ports = lib.mkOption ({
        type = (nullOr (attrsOf Port));
        default = null;
      } // ((overrides.NetworkResource or {}).ports or {}));
      options.reservedPorts = lib.mkOption ({
        type = (nullOr (attrsOf Port));
        default = null;
      } // ((overrides.NetworkResource or {}).reservedPorts or {}));
    });

  ParameterizedJobConfig = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.metaOptional = lib.mkOption ({
        type = (nullOr (listOf str));
        default = null;
      } // ((overrides.ParameterizedJobConfig or {}).metaOptional or {}));
      options.metaRequired = lib.mkOption ({
        type = (nullOr (listOf str));
        default = null;
      } // ((overrides.ParameterizedJobConfig or {}).metaRequired or {}));
      options.payload = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ParameterizedJobConfig or {}).payload or {}));
    });

  PeriodicConfig = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.cron = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.PeriodicConfig or {}).cron or {}));
      options.enabled = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.PeriodicConfig or {}).enabled or {}));
      options.prohibitOverlap = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.PeriodicConfig or {}).prohibitOverlap or {}));
      options.timeZone = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.PeriodicConfig or {}).timeZone or {}));
    });

  Port = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.hostNetwork = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Port or {}).hostNetwork or {}));
      options.static = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.Port or {}).static or {}));
      options.to = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.Port or {}).to or {}));
    });

  RequestedDevice = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.affinities = lib.mkOption ({
        type = (nullOr (listOf Affinity));
        default = null;
      } // ((overrides.RequestedDevice or {}).affinities or {}));
      options.constraints = lib.mkOption ({
        type = (nullOr (listOf Constraint));
        default = null;
      } // ((overrides.RequestedDevice or {}).constraints or {}));
      options.count = lib.mkOption ({
        type = (nullOr ints.unsigned);
        default = null;
      } // ((overrides.RequestedDevice or {}).count or {}));
    });

  ReschedulePolicy = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.attempts = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.ReschedulePolicy or {}).attempts or {}));
      options.delay = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.ReschedulePolicy or {}).delay or {}));
      options.delayFunction = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ReschedulePolicy or {}).delayFunction or {}));
      options.interval = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.ReschedulePolicy or {}).interval or {}));
      options.maxDelay = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.ReschedulePolicy or {}).maxDelay or {}));
      options.unlimited = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.ReschedulePolicy or {}).unlimited or {}));
    });

  Resources = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.cores = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.Resources or {}).cores or {}));
      options.cpu = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.Resources or {}).cpu or {}));
      options.devices = lib.mkOption ({
        type = (nullOr (attrsOf RequestedDevice));
        default = null;
      } // ((overrides.Resources or {}).devices or {}));
      options.disk = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.Resources or {}).disk or {}));
      options.iops = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.Resources or {}).iops or {}));
      options.memory = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.Resources or {}).memory or {}));
      options.memoryMax = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.Resources or {}).memoryMax or {}));
      options.networks = lib.mkOption ({
        type = (nullOr (listOf NetworkResource));
        default = null;
      } // ((overrides.Resources or {}).networks or {}));
    });

  RestartPolicy = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.attempts = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.RestartPolicy or {}).attempts or {}));
      options.delay = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.RestartPolicy or {}).delay or {}));
      options.interval = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.RestartPolicy or {}).interval or {}));
      options.mode = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.RestartPolicy or {}).mode or {}));
    });

  ScalingPolicy = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.enabled = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.ScalingPolicy or {}).enabled or {}));
      options.max = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.ScalingPolicy or {}).max or {}));
      options.min = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.ScalingPolicy or {}).min or {}));
      options.policy = lib.mkOption ({
        type = (nullOr (attrsOf anything));
        default = null;
      } // ((overrides.ScalingPolicy or {}).policy or {}));
      options.type = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ScalingPolicy or {}).type or {}));
    });

  Service = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.addressMode = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Service or {}).addressMode or {}));
      options.canaryMeta = lib.mkOption ({
        type = (nullOr (attrsOf str));
        default = null;
      } // ((overrides.Service or {}).canaryMeta or {}));
      options.canaryTags = lib.mkOption ({
        type = (nullOr (listOf str));
        default = null;
      } // ((overrides.Service or {}).canaryTags or {}));
      options.checkRestart = lib.mkOption ({
        type = (nullOr CheckRestart);
        default = null;
      } // ((overrides.Service or {}).checkRestart or {}));
      options.checks = lib.mkOption ({
        type = (nullOr (listOf ServiceCheck));
        default = null;
      } // ((overrides.Service or {}).checks or {}));
      options.connect = lib.mkOption ({
        type = (nullOr ConsulConnect);
        default = null;
      } // ((overrides.Service or {}).connect or {}));
      options.enableTagOverride = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.Service or {}).enableTagOverride or {}));
      options.id = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Service or {}).id or {}));
      options.meta = lib.mkOption ({
        type = (nullOr (attrsOf str));
        default = null;
      } // ((overrides.Service or {}).meta or {}));
      options.name = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Service or {}).name or {}));
      options.onUpdate = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Service or {}).onUpdate or {}));
      options.port = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Service or {}).port or {}));
      options.tags = lib.mkOption ({
        type = (nullOr (listOf str));
        default = null;
      } // ((overrides.Service or {}).tags or {}));
      options.task = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Service or {}).task or {}));
    });

  ServiceCheck = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.addressMode = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ServiceCheck or {}).addressMode or {}));
      options.args = lib.mkOption ({
        type = (nullOr (listOf str));
        default = null;
      } // ((overrides.ServiceCheck or {}).args or {}));
      options.body = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ServiceCheck or {}).body or {}));
      options.checkRestart = lib.mkOption ({
        type = (nullOr CheckRestart);
        default = null;
      } // ((overrides.ServiceCheck or {}).checkRestart or {}));
      options.command = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ServiceCheck or {}).command or {}));
      options.expose = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.ServiceCheck or {}).expose or {}));
      options.failuresBeforeCritical = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.ServiceCheck or {}).failuresBeforeCritical or {}));
      options.grpcService = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ServiceCheck or {}).grpcService or {}));
      options.grpcUseTls = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.ServiceCheck or {}).grpcUseTls or {}));
      options.header = lib.mkOption ({
        type = (nullOr (attrsOf str));
        default = null;
      } // ((overrides.ServiceCheck or {}).header or {}));
      options.id = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ServiceCheck or {}).id or {}));
      options.initialStatus = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ServiceCheck or {}).initialStatus or {}));
      options.interval = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.ServiceCheck or {}).interval or {}));
      options.method = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ServiceCheck or {}).method or {}));
      options.name = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ServiceCheck or {}).name or {}));
      options.onUpdate = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ServiceCheck or {}).onUpdate or {}));
      options.path = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ServiceCheck or {}).path or {}));
      options.port = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ServiceCheck or {}).port or {}));
      options.protocol = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ServiceCheck or {}).protocol or {}));
      options.successBeforePassing = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.ServiceCheck or {}).successBeforePassing or {}));
      options.task = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ServiceCheck or {}).task or {}));
      options.timeout = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.ServiceCheck or {}).timeout or {}));
      options.tlsSkipVerify = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.ServiceCheck or {}).tlsSkipVerify or {}));
      options.type = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.ServiceCheck or {}).type or {}));
    });

  SidecarTask = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.config = lib.mkOption ({
        type = (nullOr (attrsOf anything));
        default = null;
      } // ((overrides.SidecarTask or {}).config or {}));
      options.driver = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.SidecarTask or {}).driver or {}));
      options.env = lib.mkOption ({
        type = (nullOr (attrsOf str));
        default = null;
      } // ((overrides.SidecarTask or {}).env or {}));
      options.killSignal = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.SidecarTask or {}).killSignal or {}));
      options.killTimeout = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.SidecarTask or {}).killTimeout or {}));
      options.logs = lib.mkOption ({
        type = (nullOr LogConfig);
        default = null;
      } // ((overrides.SidecarTask or {}).logs or {}));
      options.meta = lib.mkOption ({
        type = (nullOr (attrsOf str));
        default = null;
      } // ((overrides.SidecarTask or {}).meta or {}));
      options.name = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.SidecarTask or {}).name or {}));
      options.resources = lib.mkOption ({
        type = (nullOr Resources);
        default = null;
      } // ((overrides.SidecarTask or {}).resources or {}));
      options.shutdownDelay = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.SidecarTask or {}).shutdownDelay or {}));
      options.user = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.SidecarTask or {}).user or {}));
    });

  Spread = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.attribute = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Spread or {}).attribute or {}));
      options.targets = lib.mkOption ({
        type = (nullOr (attrsOf SpreadTarget));
        default = null;
      } // ((overrides.Spread or {}).targets or {}));
      options.weight = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.Spread or {}).weight or {}));
    });

  SpreadTarget = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.percent = lib.mkOption ({
        type = (nullOr ints.unsigned);
        default = null;
      } // ((overrides.SpreadTarget or {}).percent or {}));
    });

  Task = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.affinities = lib.mkOption ({
        type = (nullOr (listOf Affinity));
        default = null;
      } // ((overrides.Task or {}).affinities or {}));
      options.artifacts = lib.mkOption ({
        type = (nullOr (listOf TaskArtifact));
        default = null;
      } // ((overrides.Task or {}).artifacts or {}));
      options.config = lib.mkOption ({
        type = (nullOr (attrsOf anything));
        default = null;
      } // ((overrides.Task or {}).config or {}));
      options.constraints = lib.mkOption ({
        type = (nullOr (listOf Constraint));
        default = null;
      } // ((overrides.Task or {}).constraints or {}));
      options.csiPlugin = lib.mkOption ({
        type = (nullOr TaskCSIPluginConfig);
        default = null;
      } // ((overrides.Task or {}).csiPlugin or {}));
      options.dispatchPayload = lib.mkOption ({
        type = (nullOr DispatchPayloadConfig);
        default = null;
      } // ((overrides.Task or {}).dispatchPayload or {}));
      options.driver = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Task or {}).driver or {}));
      options.env = lib.mkOption ({
        type = (nullOr (attrsOf str));
        default = null;
      } // ((overrides.Task or {}).env or {}));
      options.killSignal = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Task or {}).killSignal or {}));
      options.killTimeout = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.Task or {}).killTimeout or {}));
      options.kind = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Task or {}).kind or {}));
      options.leader = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.Task or {}).leader or {}));
      options.lifecycle = lib.mkOption ({
        type = (nullOr TaskLifecycle);
        default = null;
      } // ((overrides.Task or {}).lifecycle or {}));
      options.logs = lib.mkOption ({
        type = (nullOr LogConfig);
        default = null;
      } // ((overrides.Task or {}).logs or {}));
      options.meta = lib.mkOption ({
        type = (nullOr (attrsOf str));
        default = null;
      } // ((overrides.Task or {}).meta or {}));
      options.resources = lib.mkOption ({
        type = (nullOr Resources);
        default = null;
      } // ((overrides.Task or {}).resources or {}));
      options.restart = lib.mkOption ({
        type = (nullOr RestartPolicy);
        default = null;
      } // ((overrides.Task or {}).restart or {}));
      options.scalings = lib.mkOption ({
        type = (nullOr (listOf ScalingPolicy));
        default = null;
      } // ((overrides.Task or {}).scalings or {}));
      options.services = lib.mkOption ({
        type = (nullOr (listOf Service));
        default = null;
      } // ((overrides.Task or {}).services or {}));
      options.shutdownDelay = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.Task or {}).shutdownDelay or {}));
      options.templates = lib.mkOption ({
        type = (nullOr (listOf Template));
        default = null;
      } // ((overrides.Task or {}).templates or {}));
      options.user = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Task or {}).user or {}));
      options.vault = lib.mkOption ({
        type = (nullOr Vault);
        default = null;
      } // ((overrides.Task or {}).vault or {}));
      options.volumeMounts = lib.mkOption ({
        type = (nullOr (listOf VolumeMount));
        default = null;
      } // ((overrides.Task or {}).volumeMounts or {}));
    });

  TaskArtifact = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.destination = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.TaskArtifact or {}).destination or {}));
      options.headers = lib.mkOption ({
        type = (nullOr (attrsOf str));
        default = null;
      } // ((overrides.TaskArtifact or {}).headers or {}));
      options.mode = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.TaskArtifact or {}).mode or {}));
      options.options = lib.mkOption ({
        type = (nullOr (attrsOf str));
        default = null;
      } // ((overrides.TaskArtifact or {}).options or {}));
      options.source = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.TaskArtifact or {}).source or {}));
    });

  TaskCSIPluginConfig = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.id = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.TaskCSIPluginConfig or {}).id or {}));
      options.mountDir = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.TaskCSIPluginConfig or {}).mountDir or {}));
      options.type = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.TaskCSIPluginConfig or {}).type or {}));
    });

  TaskGroup = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.affinities = lib.mkOption ({
        type = (nullOr (listOf Affinity));
        default = null;
      } // ((overrides.TaskGroup or {}).affinities or {}));
      options.constraints = lib.mkOption ({
        type = (nullOr (listOf Constraint));
        default = null;
      } // ((overrides.TaskGroup or {}).constraints or {}));
      options.consul = lib.mkOption ({
        type = (nullOr Consul);
        default = null;
      } // ((overrides.TaskGroup or {}).consul or {}));
      options.count = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.TaskGroup or {}).count or {}));
      options.ephemeralDisk = lib.mkOption ({
        type = (nullOr EphemeralDisk);
        default = null;
      } // ((overrides.TaskGroup or {}).ephemeralDisk or {}));
      options.meta = lib.mkOption ({
        type = (nullOr (attrsOf str));
        default = null;
      } // ((overrides.TaskGroup or {}).meta or {}));
      options.migrate = lib.mkOption ({
        type = (nullOr MigrateStrategy);
        default = null;
      } // ((overrides.TaskGroup or {}).migrate or {}));
      options.networks = lib.mkOption ({
        type = (nullOr (listOf NetworkResource));
        default = null;
      } // ((overrides.TaskGroup or {}).networks or {}));
      options.reschedule = lib.mkOption ({
        type = (nullOr ReschedulePolicy);
        default = null;
      } // ((overrides.TaskGroup or {}).reschedule or {}));
      options.restart = lib.mkOption ({
        type = (nullOr RestartPolicy);
        default = null;
      } // ((overrides.TaskGroup or {}).restart or {}));
      options.scaling = lib.mkOption ({
        type = (nullOr ScalingPolicy);
        default = null;
      } // ((overrides.TaskGroup or {}).scaling or {}));
      options.services = lib.mkOption ({
        type = (nullOr (listOf Service));
        default = null;
      } // ((overrides.TaskGroup or {}).services or {}));
      options.shutdownDelay = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.TaskGroup or {}).shutdownDelay or {}));
      options.spreads = lib.mkOption ({
        type = (nullOr (listOf Spread));
        default = null;
      } // ((overrides.TaskGroup or {}).spreads or {}));
      options.stopAfterClientDisconnect = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.TaskGroup or {}).stopAfterClientDisconnect or {}));
      options.tasks = lib.mkOption ({
        type = (nullOr (attrsOf Task));
        default = null;
      } // ((overrides.TaskGroup or {}).tasks or {}));
      options.update = lib.mkOption ({
        type = (nullOr UpdateStrategy);
        default = null;
      } // ((overrides.TaskGroup or {}).update or {}));
      options.volumes = lib.mkOption ({
        type = (nullOr (attrsOf VolumeRequest));
        default = null;
      } // ((overrides.TaskGroup or {}).volumes or {}));
    });

  TaskLifecycle = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.hook = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.TaskLifecycle or {}).hook or {}));
      options.sidecar = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.TaskLifecycle or {}).sidecar or {}));
    });

  Template = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.changeMode = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Template or {}).changeMode or {}));
      options.changeSignal = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Template or {}).changeSignal or {}));
      options.data = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Template or {}).data or {}));
      options.destination = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Template or {}).destination or {}));
      options.env = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.Template or {}).env or {}));
      options.leftDelimiter = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Template or {}).leftDelimiter or {}));
      options.perms = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Template or {}).perms or {}));
      options.rightDelimiter = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Template or {}).rightDelimiter or {}));
      options.source = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Template or {}).source or {}));
      options.splay = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.Template or {}).splay or {}));
      options.vaultGrace = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.Template or {}).vaultGrace or {}));
      options.wait = lib.mkOption ({
        type = (nullOr WaitConfig);
        default = null;
      } // ((overrides.Template or {}).wait or {}));
    });

  UpdateStrategy = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.autoPromote = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.UpdateStrategy or {}).autoPromote or {}));
      options.autoRevert = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.UpdateStrategy or {}).autoRevert or {}));
      options.canary = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.UpdateStrategy or {}).canary or {}));
      options.healthCheck = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.UpdateStrategy or {}).healthCheck or {}));
      options.healthyDeadline = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.UpdateStrategy or {}).healthyDeadline or {}));
      options.maxParallel = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.UpdateStrategy or {}).maxParallel or {}));
      options.minHealthyTime = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.UpdateStrategy or {}).minHealthyTime or {}));
      options.progressDeadline = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.UpdateStrategy or {}).progressDeadline or {}));
      options.stagger = lib.mkOption ({
        type = (nullOr int);
        default = null;
      } // ((overrides.UpdateStrategy or {}).stagger or {}));
    });

  Vault = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.changeMode = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Vault or {}).changeMode or {}));
      options.changeSignal = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Vault or {}).changeSignal or {}));
      options.env = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.Vault or {}).env or {}));
      options.namespace = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.Vault or {}).namespace or {}));
      options.policies = lib.mkOption ({
        type = (nullOr (listOf str));
        default = null;
      } // ((overrides.Vault or {}).policies or {}));
    });

  VolumeMount = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.destination = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.VolumeMount or {}).destination or {}));
      options.propagationMode = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.VolumeMount or {}).propagationMode or {}));
      options.readOnly = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.VolumeMount or {}).readOnly or {}));
      options.volume = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.VolumeMount or {}).volume or {}));
    });

  VolumeRequest = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.accessMode = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.VolumeRequest or {}).accessMode or {}));
      options.attachmentMode = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.VolumeRequest or {}).attachmentMode or {}));
      options.mountOptions = lib.mkOption ({
        type = (nullOr CSIMountOptions);
        default = null;
      } // ((overrides.VolumeRequest or {}).mountOptions or {}));
      options.perAlloc = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.VolumeRequest or {}).perAlloc or {}));
      options.readOnly = lib.mkOption ({
        type = (nullOr bool);
        default = null;
      } // ((overrides.VolumeRequest or {}).readOnly or {}));
      options.source = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.VolumeRequest or {}).source or {}));
      options.type = lib.mkOption ({
        type = (nullOr str);
        default = null;
      } // ((overrides.VolumeRequest or {}).type or {}));
    });

  WaitConfig = lib.types.submodule ({ lib, ... }:
    with lib.types; {
      options.max = lib.mkOption ({
        type = int;
      } // ((overrides.WaitConfig or {}).max or {}));
      options.min = lib.mkOption ({
        type = int;
      } // ((overrides.WaitConfig or {}).min or {}));
    });

  mkAffinityAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attribute then { LTarget = attrs.attribute; } else {})
    // (if attrs ? operator then { Operand = attrs.operator; } else {})
    // (if attrs ? value then { RTarget = attrs.value; } else {})
    // (if attrs ? weight then { Weight = attrs.weight; } else {})
  );

  mkCSIMountOptionsAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? fsType then { FSType = attrs.fsType; } else {})
    // (if attrs ? mountFlags then { MountFlags = attrs.mountFlags; } else {})
  );

  mkCheckRestartAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? grace then { Grace = attrs.grace; } else {})
    // (if attrs ? ignoreWarnings then { IgnoreWarnings = attrs.ignoreWarnings; } else {})
    // (if attrs ? limit then { Limit = attrs.limit; } else {})
  );

  mkConstraintAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attribute then { LTarget = attrs.attribute; } else {})
    // (if attrs ? operator then { Operand = attrs.operator; } else {})
    // (if attrs ? value then { RTarget = attrs.value; } else {})
  );

  mkConsulAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? namespace then { Namespace = attrs.namespace; } else {})
  );

  mkConsulConnectAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? gateway then { Gateway = mkConsulGatewayAPI attrs.gateway; } else {})
    // (if attrs ? native then { Native = attrs.native; } else {})
    // (if attrs ? sidecarService then { SidecarService = mkConsulSidecarServiceAPI attrs.sidecarService; } else {})
    // (if attrs ? sidecarTask then { SidecarTask = mkSidecarTaskAPI attrs.sidecarTask; } else {})
  );

  mkConsulExposeConfigAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? paths && builtins.isList attrs.paths then { Path = builtins.map mkConsulExposePathAPI (attrs.paths or []); } else {})
  );

  mkConsulExposePathAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? listenerPort then { ListenerPort = attrs.listenerPort; } else {})
    // (if attrs ? localPathPort then { LocalPathPort = attrs.localPathPort; } else {})
    // (if attrs ? path then { Path = attrs.path; } else {})
    // (if attrs ? protocol then { Protocol = attrs.protocol; } else {})
  );

  mkConsulGatewayAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? ingress then { Ingress = mkConsulIngressConfigEntryAPI attrs.ingress; } else {})
    // (if attrs ? mesh then { Mesh = mkConsulMeshConfigEntryAPI attrs.mesh; } else {})
    // (if attrs ? proxy then { Proxy = mkConsulGatewayProxyAPI attrs.proxy; } else {})
    // (if attrs ? terminating then { Terminating = mkConsulTerminatingConfigEntryAPI attrs.terminating; } else {})
  );

  mkConsulGatewayBindAddressAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? address then { Address = attrs.address; } else {})
    // (if attrs ? port then { Port = attrs.port; } else {})
  );

  mkConsulGatewayProxyAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? config then { Config = attrs.config; } else {})
    // (if attrs ? connectTimeout then { ConnectTimeout = attrs.connectTimeout; } else {})
    // (if attrs ? envoyDnsDiscoveryType then { EnvoyDNSDiscoveryType = attrs.envoyDnsDiscoveryType; } else {})
    // (if attrs ? envoyGatewayBindAddresses && builtins.isAttrs attrs.envoyGatewayBindAddresses then { EnvoyGatewayBindAddresses = lib.mapAttrsToList (k: v: (mkConsulGatewayBindAddressAPI (v // { Name = k; }))) attrs.envoyGatewayBindAddresses; } else {})
    // (if attrs ? envoyGatewayBindTaggedAddresses then { EnvoyGatewayBindTaggedAddresses = attrs.envoyGatewayBindTaggedAddresses; } else {})
    // (if attrs ? envoyGatewayNoDefaultBind then { EnvoyGatewayNoDefaultBind = attrs.envoyGatewayNoDefaultBind; } else {})
  );

  mkConsulGatewayTLSConfigAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? enabled then { Enabled = attrs.enabled; } else {})
  );

  mkConsulIngressConfigEntryAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? listeners && builtins.isList attrs.listeners then { Listeners = builtins.map mkConsulIngressListenerAPI (attrs.listeners or []); } else {})
    // (if attrs ? tls then { TLS = mkConsulGatewayTLSConfigAPI attrs.tls; } else {})
  );

  mkConsulIngressListenerAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? port then { Port = attrs.port; } else {})
    // (if attrs ? protocol then { Protocol = attrs.protocol; } else {})
    // (if attrs ? services && builtins.isList attrs.services then { Services = builtins.map mkConsulIngressServiceAPI (attrs.services or []); } else {})
  );

  mkConsulIngressServiceAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? hosts then { Hosts = attrs.hosts; } else {})
    // (if attrs ? name then { Name = attrs.name; } else {})
  );

  mkConsulLinkedServiceAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? caFile then { CAFile = attrs.caFile; } else {})
    // (if attrs ? certFile then { CertFile = attrs.certFile; } else {})
    // (if attrs ? keyFile then { KeyFile = attrs.keyFile; } else {})
    // (if attrs ? name then { Name = attrs.name; } else {})
    // (if attrs ? sni then { SNI = attrs.sni; } else {})
  );

  mkConsulMeshConfigEntryAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
  );

  mkConsulMeshGatewayAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? mode then { Mode = attrs.mode; } else {})
  );

  mkConsulProxyAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? config then { Config = attrs.config; } else {})
    // (if attrs ? expose then { ExposeConfig = mkConsulExposeConfigAPI attrs.expose; } else {})
    // (if attrs ? localServiceAddress then { LocalServiceAddress = attrs.localServiceAddress; } else {})
    // (if attrs ? localServicePort then { LocalServicePort = attrs.localServicePort; } else {})
    // (if attrs ? upstreams && builtins.isList attrs.upstreams then { Upstreams = builtins.map mkConsulUpstreamAPI (attrs.upstreams or []); } else {})
  );

  mkConsulSidecarServiceAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? disableDefaultTcpCheck then { DisableDefaultTCPCheck = attrs.disableDefaultTcpCheck; } else {})
    // (if attrs ? port then { Port = attrs.port; } else {})
    // (if attrs ? proxy then { Proxy = mkConsulProxyAPI attrs.proxy; } else {})
    // (if attrs ? tags then { Tags = attrs.tags; } else {})
  );

  mkConsulTerminatingConfigEntryAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? services && builtins.isList attrs.services then { Services = builtins.map mkConsulLinkedServiceAPI (attrs.services or []); } else {})
  );

  mkConsulUpstreamAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? datacenter then { Datacenter = attrs.datacenter; } else {})
    // (if attrs ? destinationName then { DestinationName = attrs.destinationName; } else {})
    // (if attrs ? localBindAddress then { LocalBindAddress = attrs.localBindAddress; } else {})
    // (if attrs ? localBindPort then { LocalBindPort = attrs.localBindPort; } else {})
    // (if attrs ? meshGateway then { MeshGateway = mkConsulMeshGatewayAPI attrs.meshGateway; } else {})
  );

  mkDNSConfigAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? options then { Options = attrs.options; } else {})
    // (if attrs ? searches then { Searches = attrs.searches; } else {})
    // (if attrs ? servers then { Servers = attrs.servers; } else {})
  );

  mkDispatchPayloadConfigAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? file then { File = attrs.file; } else {})
  );

  mkEphemeralDiskAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? migrate then { Migrate = attrs.migrate; } else {})
    // (if attrs ? size then { SizeMB = attrs.size; } else {})
    // (if attrs ? sticky then { Sticky = attrs.sticky; } else {})
  );

  mkJobAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? affinities && builtins.isList attrs.affinities then { Affinities = builtins.map mkAffinityAPI (attrs.affinities or []); } else {})
    // (if attrs ? allAtOnce then { AllAtOnce = attrs.allAtOnce; } else {})
    // (if attrs ? constraints && builtins.isList attrs.constraints then { Constraints = builtins.map mkConstraintAPI (attrs.constraints or []); } else {})
    // (if attrs ? consulToken then { ConsulToken = attrs.consulToken; } else {})
    // (if attrs ? datacenters then { Datacenters = attrs.datacenters; } else {})
    // (if attrs ? groups && builtins.isAttrs attrs.groups then { TaskGroups = lib.mapAttrsToList (k: v: (mkTaskGroupAPI (v // { Name = k; }))) attrs.groups; } else {})
    // (if attrs ? id then { ID = attrs.id; } else {})
    // (if attrs ? meta then { Meta = attrs.meta; } else {})
    // (if attrs ? migrate then { Migrate = mkMigrateStrategyAPI attrs.migrate; } else {})
    // (if attrs ? multiregion then { Multiregion = mkMultiregionAPI attrs.multiregion; } else {})
    // (if attrs ? name then { Name = attrs.name; } else {})
    // (if attrs ? namespace then { Namespace = attrs.namespace; } else {})
    // (if attrs ? parameterized then { ParameterizedJob = mkParameterizedJobConfigAPI attrs.parameterized; } else {})
    // (if attrs ? periodic then { Periodic = mkPeriodicConfigAPI attrs.periodic; } else {})
    // (if attrs ? priority then { Priority = attrs.priority; } else {})
    // (if attrs ? region then { Region = attrs.region; } else {})
    // (if attrs ? reschedule then { Reschedule = mkReschedulePolicyAPI attrs.reschedule; } else {})
    // (if attrs ? spreads && builtins.isList attrs.spreads then { Spreads = builtins.map mkSpreadAPI (attrs.spreads or []); } else {})
    // (if attrs ? type then { Type = attrs.type; } else {})
    // (if attrs ? update then { Update = mkUpdateStrategyAPI attrs.update; } else {})
    // (if attrs ? vaultToken then { VaultToken = attrs.vaultToken; } else {})
  );

  mkLogConfigAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? maxFileSize then { MaxFileSizeMB = attrs.maxFileSize; } else {})
    // (if attrs ? maxFiles then { MaxFiles = attrs.maxFiles; } else {})
  );

  mkMigrateStrategyAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? healthCheck then { HealthCheck = attrs.healthCheck; } else {})
    // (if attrs ? healthyDeadline then { HealthyDeadline = attrs.healthyDeadline; } else {})
    // (if attrs ? maxParallel then { MaxParallel = attrs.maxParallel; } else {})
    // (if attrs ? minHealthyTime then { MinHealthyTime = attrs.minHealthyTime; } else {})
  );

  mkMultiregionAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? regions && builtins.isAttrs attrs.regions then { Regions = lib.mapAttrsToList (k: v: (mkMultiregionRegionAPI (v // { Name = k; }))) attrs.regions; } else {})
    // (if attrs ? strategy then { Strategy = mkMultiregionStrategyAPI attrs.strategy; } else {})
  );

  mkMultiregionRegionAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? count then { Count = attrs.count; } else {})
    // (if attrs ? datacenters then { Datacenters = attrs.datacenters; } else {})
    // (if attrs ? meta then { Meta = attrs.meta; } else {})
  );

  mkMultiregionStrategyAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? maxParallel then { MaxParallel = attrs.maxParallel; } else {})
    // (if attrs ? onFailure then { OnFailure = attrs.onFailure; } else {})
  );

  mkNetworkResourceAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? cidr then { CIDR = attrs.cidr; } else {})
    // (if attrs ? device then { Device = attrs.device; } else {})
    // (if attrs ? dns then { DNS = mkDNSConfigAPI attrs.dns; } else {})
    // (if attrs ? hostname then { Hostname = attrs.hostname; } else {})
    // (if attrs ? ip then { IP = attrs.ip; } else {})
    // (if attrs ? mbits then { MBits = attrs.mbits; } else {})
    // (if attrs ? mode then { Mode = attrs.mode; } else {})
    // (if attrs ? ports && builtins.isAttrs attrs.ports then { DynamicPorts = lib.mapAttrsToList (k: v: (mkPortAPI (v // { Label = k; }))) attrs.ports; } else {})
    // (if attrs ? reservedPorts && builtins.isAttrs attrs.reservedPorts then { ReservedPorts = lib.mapAttrsToList (k: v: (mkPortAPI (v // { Label = k; }))) attrs.reservedPorts; } else {})
  );

  mkParameterizedJobConfigAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? metaOptional then { MetaOptional = attrs.metaOptional; } else {})
    // (if attrs ? metaRequired then { MetaRequired = attrs.metaRequired; } else {})
    // (if attrs ? payload then { Payload = attrs.payload; } else {})
  );

  mkPeriodicConfigAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? cron then { Spec = attrs.cron; } else {})
    // (if attrs ? enabled then { Enabled = attrs.enabled; } else {})
    // (if attrs ? prohibitOverlap then { ProhibitOverlap = attrs.prohibitOverlap; } else {})
    // (if attrs ? timeZone then { TimeZone = attrs.timeZone; } else {})
  );

  mkPortAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? hostNetwork then { HostNetwork = attrs.hostNetwork; } else {})
    // (if attrs ? static then { Value = attrs.static; } else {})
    // (if attrs ? to then { To = attrs.to; } else {})
  );

  mkRequestedDeviceAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? affinities && builtins.isList attrs.affinities then { Affinities = builtins.map mkAffinityAPI (attrs.affinities or []); } else {})
    // (if attrs ? constraints && builtins.isList attrs.constraints then { Constraints = builtins.map mkConstraintAPI (attrs.constraints or []); } else {})
    // (if attrs ? count then { Count = attrs.count; } else {})
  );

  mkReschedulePolicyAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attempts then { Attempts = attrs.attempts; } else {})
    // (if attrs ? delay then { Delay = attrs.delay; } else {})
    // (if attrs ? delayFunction then { DelayFunction = attrs.delayFunction; } else {})
    // (if attrs ? interval then { Interval = attrs.interval; } else {})
    // (if attrs ? maxDelay then { MaxDelay = attrs.maxDelay; } else {})
    // (if attrs ? unlimited then { Unlimited = attrs.unlimited; } else {})
  );

  mkResourcesAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? cores then { Cores = attrs.cores; } else {})
    // (if attrs ? cpu then { CPU = attrs.cpu; } else {})
    // (if attrs ? devices && builtins.isAttrs attrs.devices then { Devices = lib.mapAttrsToList (k: v: (mkRequestedDeviceAPI (v // { Name = k; }))) attrs.devices; } else {})
    // (if attrs ? disk then { DiskMB = attrs.disk; } else {})
    // (if attrs ? iops then { IOPS = attrs.iops; } else {})
    // (if attrs ? memory then { MemoryMB = attrs.memory; } else {})
    // (if attrs ? memoryMax then { MemoryMaxMB = attrs.memoryMax; } else {})
    // (if attrs ? networks && builtins.isList attrs.networks then { Networks = builtins.map mkNetworkResourceAPI (attrs.networks or []); } else {})
  );

  mkRestartPolicyAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attempts then { Attempts = attrs.attempts; } else {})
    // (if attrs ? delay then { Delay = attrs.delay; } else {})
    // (if attrs ? interval then { Interval = attrs.interval; } else {})
    // (if attrs ? mode then { Mode = attrs.mode; } else {})
  );

  mkScalingPolicyAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? enabled then { Enabled = attrs.enabled; } else {})
    // (if attrs ? max then { Max = attrs.max; } else {})
    // (if attrs ? min then { Min = attrs.min; } else {})
    // (if attrs ? policy then { Policy = attrs.policy; } else {})
    // (if attrs ? type then { Type = attrs.type; } else {})
  );

  mkServiceAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? addressMode then { AddressMode = attrs.addressMode; } else {})
    // (if attrs ? canaryMeta then { CanaryMeta = attrs.canaryMeta; } else {})
    // (if attrs ? canaryTags then { CanaryTags = attrs.canaryTags; } else {})
    // (if attrs ? checkRestart then { CheckRestart = mkCheckRestartAPI attrs.checkRestart; } else {})
    // (if attrs ? checks && builtins.isList attrs.checks then { Checks = builtins.map mkServiceCheckAPI (attrs.checks or []); } else {})
    // (if attrs ? connect then { Connect = mkConsulConnectAPI attrs.connect; } else {})
    // (if attrs ? enableTagOverride then { EnableTagOverride = attrs.enableTagOverride; } else {})
    // (if attrs ? id then { Id = attrs.id; } else {})
    // (if attrs ? meta then { Meta = attrs.meta; } else {})
    // (if attrs ? name then { Name = attrs.name; } else {})
    // (if attrs ? onUpdate then { OnUpdate = attrs.onUpdate; } else {})
    // (if attrs ? port then { PortLabel = attrs.port; } else {})
    // (if attrs ? tags then { Tags = attrs.tags; } else {})
    // (if attrs ? task then { TaskName = attrs.task; } else {})
  );

  mkServiceCheckAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? addressMode then { AddressMode = attrs.addressMode; } else {})
    // (if attrs ? args then { Args = attrs.args; } else {})
    // (if attrs ? body then { Body = attrs.body; } else {})
    // (if attrs ? checkRestart then { CheckRestart = mkCheckRestartAPI attrs.checkRestart; } else {})
    // (if attrs ? command then { Command = attrs.command; } else {})
    // (if attrs ? expose then { Expose = attrs.expose; } else {})
    // (if attrs ? failuresBeforeCritical then { FailuresBeforeCritical = attrs.failuresBeforeCritical; } else {})
    // (if attrs ? grpcService then { GRPCService = attrs.grpcService; } else {})
    // (if attrs ? grpcUseTls then { GRPCUseTLS = attrs.grpcUseTls; } else {})
    // (if attrs ? header then { Header = attrs.header; } else {})
    // (if attrs ? id then { Id = attrs.id; } else {})
    // (if attrs ? initialStatus then { InitialStatus = attrs.initialStatus; } else {})
    // (if attrs ? interval then { Interval = attrs.interval; } else {})
    // (if attrs ? method then { Method = attrs.method; } else {})
    // (if attrs ? name then { Name = attrs.name; } else {})
    // (if attrs ? onUpdate then { OnUpdate = attrs.onUpdate; } else {})
    // (if attrs ? path then { Path = attrs.path; } else {})
    // (if attrs ? port then { PortLabel = attrs.port; } else {})
    // (if attrs ? protocol then { Protocol = attrs.protocol; } else {})
    // (if attrs ? successBeforePassing then { SuccessBeforePassing = attrs.successBeforePassing; } else {})
    // (if attrs ? task then { TaskName = attrs.task; } else {})
    // (if attrs ? timeout then { Timeout = attrs.timeout; } else {})
    // (if attrs ? tlsSkipVerify then { TLSSkipVerify = attrs.tlsSkipVerify; } else {})
    // (if attrs ? type then { Type = attrs.type; } else {})
  );

  mkSidecarTaskAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? config then { Config = attrs.config; } else {})
    // (if attrs ? driver then { Driver = attrs.driver; } else {})
    // (if attrs ? env then { Env = attrs.env; } else {})
    // (if attrs ? killSignal then { KillSignal = attrs.killSignal; } else {})
    // (if attrs ? killTimeout then { KillTimeout = attrs.killTimeout; } else {})
    // (if attrs ? logs then { LogConfig = mkLogConfigAPI attrs.logs; } else {})
    // (if attrs ? meta then { Meta = attrs.meta; } else {})
    // (if attrs ? name then { Name = attrs.name; } else {})
    // (if attrs ? resources then { Resources = mkResourcesAPI attrs.resources; } else {})
    // (if attrs ? shutdownDelay then { ShutdownDelay = attrs.shutdownDelay; } else {})
    // (if attrs ? user then { User = attrs.user; } else {})
  );

  mkSpreadAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? attribute then { Attribute = attrs.attribute; } else {})
    // (if attrs ? targets && builtins.isAttrs attrs.targets then { SpreadTarget = lib.mapAttrsToList (k: v: (mkSpreadTargetAPI (v // { Value = k; }))) attrs.targets; } else {})
    // (if attrs ? weight then { Weight = attrs.weight; } else {})
  );

  mkSpreadTargetAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? percent then { Percent = attrs.percent; } else {})
  );

  mkTaskAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? affinities && builtins.isList attrs.affinities then { Affinities = builtins.map mkAffinityAPI (attrs.affinities or []); } else {})
    // (if attrs ? artifacts && builtins.isList attrs.artifacts then { Artifacts = builtins.map mkTaskArtifactAPI (attrs.artifacts or []); } else {})
    // (if attrs ? config then { Config = attrs.config; } else {})
    // (if attrs ? constraints && builtins.isList attrs.constraints then { Constraints = builtins.map mkConstraintAPI (attrs.constraints or []); } else {})
    // (if attrs ? csiPlugin then { CSIPluginConfig = mkTaskCSIPluginConfigAPI attrs.csiPlugin; } else {})
    // (if attrs ? dispatchPayload then { DispatchPayload = mkDispatchPayloadConfigAPI attrs.dispatchPayload; } else {})
    // (if attrs ? driver then { Driver = attrs.driver; } else {})
    // (if attrs ? env then { Env = attrs.env; } else {})
    // (if attrs ? killSignal then { KillSignal = attrs.killSignal; } else {})
    // (if attrs ? killTimeout then { KillTimeout = attrs.killTimeout; } else {})
    // (if attrs ? kind then { Kind = attrs.kind; } else {})
    // (if attrs ? leader then { Leader = attrs.leader; } else {})
    // (if attrs ? lifecycle then { Lifecycle = mkTaskLifecycleAPI attrs.lifecycle; } else {})
    // (if attrs ? logs then { LogConfig = mkLogConfigAPI attrs.logs; } else {})
    // (if attrs ? meta then { Meta = attrs.meta; } else {})
    // (if attrs ? resources then { Resources = mkResourcesAPI attrs.resources; } else {})
    // (if attrs ? restart then { RestartPolicy = mkRestartPolicyAPI attrs.restart; } else {})
    // (if attrs ? scalings && builtins.isList attrs.scalings then { ScalingPolicies = builtins.map mkScalingPolicyAPI (attrs.scalings or []); } else {})
    // (if attrs ? services && builtins.isList attrs.services then { Services = builtins.map mkServiceAPI (attrs.services or []); } else {})
    // (if attrs ? shutdownDelay then { ShutdownDelay = attrs.shutdownDelay; } else {})
    // (if attrs ? templates && builtins.isList attrs.templates then { Templates = builtins.map mkTemplateAPI (attrs.templates or []); } else {})
    // (if attrs ? user then { User = attrs.user; } else {})
    // (if attrs ? vault then { Vault = mkVaultAPI attrs.vault; } else {})
    // (if attrs ? volumeMounts && builtins.isList attrs.volumeMounts then { VolumeMounts = builtins.map mkVolumeMountAPI (attrs.volumeMounts or []); } else {})
  );

  mkTaskArtifactAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? destination then { RelativeDest = attrs.destination; } else {})
    // (if attrs ? headers then { GetterHeaders = attrs.headers; } else {})
    // (if attrs ? mode then { GetterMode = attrs.mode; } else {})
    // (if attrs ? options then { GetterOptions = attrs.options; } else {})
    // (if attrs ? source then { GetterSource = attrs.source; } else {})
  );

  mkTaskCSIPluginConfigAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? id then { ID = attrs.id; } else {})
    // (if attrs ? mountDir then { MountDir = attrs.mountDir; } else {})
    // (if attrs ? type then { Type = attrs.type; } else {})
  );

  mkTaskGroupAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? affinities && builtins.isList attrs.affinities then { Affinities = builtins.map mkAffinityAPI (attrs.affinities or []); } else {})
    // (if attrs ? constraints && builtins.isList attrs.constraints then { Constraints = builtins.map mkConstraintAPI (attrs.constraints or []); } else {})
    // (if attrs ? consul then { Consul = mkConsulAPI attrs.consul; } else {})
    // (if attrs ? count then { Count = attrs.count; } else {})
    // (if attrs ? ephemeralDisk then { EphemeralDisk = mkEphemeralDiskAPI attrs.ephemeralDisk; } else {})
    // (if attrs ? meta then { Meta = attrs.meta; } else {})
    // (if attrs ? migrate then { Migrate = mkMigrateStrategyAPI attrs.migrate; } else {})
    // (if attrs ? networks && builtins.isList attrs.networks then { Networks = builtins.map mkNetworkResourceAPI (attrs.networks or []); } else {})
    // (if attrs ? reschedule then { ReschedulePolicy = mkReschedulePolicyAPI attrs.reschedule; } else {})
    // (if attrs ? restart then { RestartPolicy = mkRestartPolicyAPI attrs.restart; } else {})
    // (if attrs ? scaling then { Scaling = mkScalingPolicyAPI attrs.scaling; } else {})
    // (if attrs ? services && builtins.isList attrs.services then { Services = builtins.map mkServiceAPI (attrs.services or []); } else {})
    // (if attrs ? shutdownDelay then { ShutdownDelay = attrs.shutdownDelay; } else {})
    // (if attrs ? spreads && builtins.isList attrs.spreads then { Spreads = builtins.map mkSpreadAPI (attrs.spreads or []); } else {})
    // (if attrs ? stopAfterClientDisconnect then { StopAfterClientDisconnect = attrs.stopAfterClientDisconnect; } else {})
    // (if attrs ? tasks && builtins.isAttrs attrs.tasks then { Tasks = lib.mapAttrsToList (k: v: (mkTaskAPI (v // { Name = k; }))) attrs.tasks; } else {})
    // (if attrs ? update then { Update = mkUpdateStrategyAPI attrs.update; } else {})
    // (if attrs ? volumes && builtins.isAttrs attrs.volumes then { Volumes = lib.mapAttrsToList (k: v: (mkVolumeRequestAPI (v // { Name = k; }))) attrs.volumes; } else {})
  );

  mkTaskLifecycleAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? hook then { Hook = attrs.hook; } else {})
    // (if attrs ? sidecar then { Sidecar = attrs.sidecar; } else {})
  );

  mkTemplateAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? changeMode then { ChangeMode = attrs.changeMode; } else {})
    // (if attrs ? changeSignal then { ChangeSignal = attrs.changeSignal; } else {})
    // (if attrs ? data then { EmbeddedTmpl = attrs.data; } else {})
    // (if attrs ? destination then { DestPath = attrs.destination; } else {})
    // (if attrs ? env then { Envvars = attrs.env; } else {})
    // (if attrs ? leftDelimiter then { LeftDelim = attrs.leftDelimiter; } else {})
    // (if attrs ? perms then { Perms = attrs.perms; } else {})
    // (if attrs ? rightDelimiter then { RightDelim = attrs.rightDelimiter; } else {})
    // (if attrs ? source then { SourcePath = attrs.source; } else {})
    // (if attrs ? splay then { Splay = attrs.splay; } else {})
    // (if attrs ? vaultGrace then { VaultGrace = attrs.vaultGrace; } else {})
    // (if attrs ? wait then { Wait = mkWaitConfigAPI attrs.wait; } else {})
  );

  mkUpdateStrategyAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? autoPromote then { AutoPromote = attrs.autoPromote; } else {})
    // (if attrs ? autoRevert then { AutoRevert = attrs.autoRevert; } else {})
    // (if attrs ? canary then { Canary = attrs.canary; } else {})
    // (if attrs ? healthCheck then { HealthCheck = attrs.healthCheck; } else {})
    // (if attrs ? healthyDeadline then { HealthyDeadline = attrs.healthyDeadline; } else {})
    // (if attrs ? maxParallel then { MaxParallel = attrs.maxParallel; } else {})
    // (if attrs ? minHealthyTime then { MinHealthyTime = attrs.minHealthyTime; } else {})
    // (if attrs ? progressDeadline then { ProgressDeadline = attrs.progressDeadline; } else {})
    // (if attrs ? stagger then { Stagger = attrs.stagger; } else {})
  );

  mkVaultAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? changeMode then { ChangeMode = attrs.changeMode; } else {})
    // (if attrs ? changeSignal then { ChangeSignal = attrs.changeSignal; } else {})
    // (if attrs ? env then { Env = attrs.env; } else {})
    // (if attrs ? namespace then { Namespace = attrs.namespace; } else {})
    // (if attrs ? policies then { Policies = attrs.policies; } else {})
  );

  mkVolumeMountAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? destination then { Destination = attrs.destination; } else {})
    // (if attrs ? propagationMode then { PropagationMode = attrs.propagationMode; } else {})
    // (if attrs ? readOnly then { ReadOnly = attrs.readOnly; } else {})
    // (if attrs ? volume then { Volume = attrs.volume; } else {})
  );

  mkVolumeRequestAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? accessMode then { AccessMode = attrs.accessMode; } else {})
    // (if attrs ? attachmentMode then { AttachmentMode = attrs.attachmentMode; } else {})
    // (if attrs ? mountOptions then { MountOptions = mkCSIMountOptionsAPI attrs.mountOptions; } else {})
    // (if attrs ? perAlloc then { PerAlloc = attrs.perAlloc; } else {})
    // (if attrs ? readOnly then { ReadOnly = attrs.readOnly; } else {})
    // (if attrs ? source then { Source = attrs.source; } else {})
    // (if attrs ? type then { Type = attrs.type; } else {})
  );

  mkWaitConfigAPI = attrs: if !(builtins.isAttrs attrs) then null else (
    {}
    // (if attrs ? max then { Max = attrs.max; } else {})
    // (if attrs ? min then { Min = attrs.min; } else {})
  );

}
