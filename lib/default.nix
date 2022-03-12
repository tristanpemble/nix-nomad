{ pkgs }:

let
  inherit (pkgs.lib) concatStrings evalModules filter filterAttrs foldl mapAttrs mapAttrs' mapAttrsToList mkOption nameValuePair stringToCharacters toUpper types;

  evaluateConfiguration = configuration:
    evalModules {
      modules = [
        { imports = [ ../modules/nomad ]; }
        { _module.args = { inherit pkgs; }; }
        configuration
      ];
    };

  titleCase = s: let
    parts = builtins.filter builtins.isString (builtins.split "[ _\-]" s);
    chars = map stringToCharacters parts;
    titleize = chars: ([(toUpper (builtins.head chars))] ++ (builtins.tail chars));
    titled = map titleize chars;
    joined = map concatStrings titled;
  in concatStrings joined;

  titleCaseAttrs = attrs:
    if builtins.isAttrs attrs
    then mapAttrs' (k: v: nameValuePair (titleCase k) v) attrs
    else attrs;

  transform = fns: attrs: (foldl (acc: fn: fn acc) attrs fns);

  renameAll = fn: attrs:
    if builtins.isAttrs attrs
    then mapAttrs' (k: v: nameValuePair (fn k) v) attrs
    else attrs;

  rename = old: new: attrs:
    if builtins.isAttrs attrs
    then renameAll (k: if k == old then new else k) attrs
    else attrs;

  add = key: value: attrs:
    if builtins.isAttrs attrs
    then attrs // { ${key} = value; }
    else attrs;

  update = key: fn: attrs:
    if builtins.isAttrs attrs
    then mapAttrs' (k: v: nameValuePair k (if k == key then fn v else v)) attrs
    else attrs;

  update' = key: fn: attrs:
    if builtins.isAttrs attrs
    then mapAttrs' (k: v: nameValuePair k (if k == key then (fn k v) else v)) attrs
    else attrs;

  filterValueFor = key: fn: attrs: update key (v:
    if builtins.isAttrs v
    then filterAttrs fn v
    else if builtins.isList v
    then filter fn v
    else v
  ) attrs;

  copy = key: to: attrs:
    if builtins.isAttrs attrs
    then attrs // { ${to} = attrs.${key}; }
    else attrs;

  delete = key: attrs:
    if builtins.isAttrs attrs
    then removeAttrs attrs [key]
    else attrs;

  affinityTransform = transform [
    (rename "attribute" "LTarget")
    (rename "value" "RTarget")
    (rename "operator" "operand")
    titleCaseAttrs
  ];
  artifactTransform = transform [
    (rename "source" "getterSource")
    (rename "options" "getterOptions")
    (rename "headers" "getterHeaders")
    (rename "mode" "getterMode")
    (rename "destination" "relativeDest")
    titleCaseAttrs
  ];
  checkRestartTransform = transform [
    titleCaseAttrs
  ];
  checkTransform = transform [
    (rename "grpcService" "GRPCService")
    (rename "grpcUseTls" "GRPCUseTLS")
    (rename "port" "PortLabel")
    (rename "tlsSkipVerify" "TLSSkipVerify")
    (rename "task" "TaskName")
    titleCaseAttrs
  ];
  connectTransform = transform [
    (update "gateway" gatewayTransform)
    (update "sidecarService" sidecarServiceTransform)
    (update "sidecarTask" sidecarTaskTransform)
    titleCaseAttrs
  ];
  constraintTransform = transform [
    (rename "attribute" "LTarget")
    (rename "value" "RTarget")
    (rename "operator" "operand")
    titleCaseAttrs
  ];
  csiPluginTransform = transform [
    titleCaseAttrs
  ];
  defaultTransform = transform [
    titleCaseAttrs
  ];
  deviceTransform = transform [
    (update "affinities" (map affinityTransform))
    (update "constraints" (map constraintTransform))
    titleCaseAttrs
  ];
  dispatchPayloadTransform = transform [
    titleCaseAttrs
  ];
  ephemeralDiskTransform = transform [
    (rename "size" "sizeMB")
    titleCaseAttrs
  ];
  exposeTransform = transform [
    (update "path" titleCaseAttrs)
    titleCaseAttrs
  ];
  gatewayTransform = transform [
    (update "ingress" titleCaseAttrs)
    (update "mesh" titleCaseAttrs)
    (update "proxy" titleCaseAttrs)
    (update "terminating" titleCaseAttrs)
    titleCaseAttrs
  ];
  groupTransform = name: transform [
    (add "name" name)
    (update "affinities" (map affinityTransform))
    (update "constraints" (map constraintTransform))
    (update "consul" titleCaseAttrs)
    (update "ephemeralDisk" ephemeralDiskTransform)
    (update "migrate" migrateTransform)
    (update "networks" (map networkTransform))
    (update "reschedule" rescheduleTransform)
    (update "restart" restartTransform)
    (update "scaling" scalingTransform)
    (update "services" (map serviceTransform))
    (update "spreads" (map spreadTransform))
    (update "tasks" (mapAttrsToList taskTransform))
    (update "update" updateTransform)
    (update "vault" vaultTransform)
    (update "volumes" (mapAttrs volumeTransform))
    (rename "reschedule" "reschedulePolicy")
    (rename "restart" "restartPolicy")
    titleCaseAttrs
  ];
  jobTransform = name: transform [
    (update "affinities" (map affinityTransform))
    (update "constraints" (map constraintTransform))
    (update "groups" (mapAttrsToList groupTransform))
    (update "migrate" migrateTransform)
    (update "parameterized" parameterizedTransform)
    (update "periodic" periodicTransform)
    (update "reschedule" rescheduleTransform)
    (update "spreads" (map spreadTransform))
    (update "update" updateTransform)
    (update "vault" vaultTransform)
    (rename "groups" "taskGroups")
    (rename "parameterized" "parameterizedJob")
    titleCaseAttrs
    (add "ID" name)
    (add "Name" name)
  ];
  lifecycleTransform = transform [
    titleCaseAttrs
  ];
  logsTransform = transform [
    titleCaseAttrs
  ];
  migrateTransform = transform [
    titleCaseAttrs
  ];
  multiregionTransform = transform [
    (update "region" titleCaseAttrs)
    (update "strategy" titleCaseAttrs)
  ];
  networkTransform = transform [
    (update "dns" titleCaseAttrs)
    (update "ports" (mapAttrsToList portTransform))
    (copy "ports" "dynamicPorts")
    (copy "ports" "reservedPorts")
    (update "dynamicPorts" (filter (v: !(v ? Value) || (v.Value == 0))))
    (update "reservedPorts" (filter (v: (v ? Value) && (v.Value != 0))))
    (delete "ports")
    (rename "dns" "DNS")
    (rename "cidr" "CIDR")
    (rename "ip" "IP")
    (rename "mbits" "MBits")
    titleCaseAttrs
  ];
  parameterizedTransform = transform [
    titleCaseAttrs
  ];
  periodicTransform = transform [
    (rename "cron" "Spec")
    titleCaseAttrs
  ];
  portTransform = label: transform [
    (add "label" label)
    (rename "static" "value")
    (update "value" (v: if v == null then 0 else v))
    titleCaseAttrs
  ];
  proxyTransform = transform [
    (update "expose" exposeTransform)
    (update "upstreams" (map upstreamsTransform))
    titleCaseAttrs
  ];
  rescheduleTransform = transform [
    titleCaseAttrs
  ];
  resourcesTransform = transform [
    (update "devices" (mapAttrsToList deviceTransform))
    (rename "cpu" "CPU")
    (rename "disk" "DiskMB")
    (rename "memory" "MemoryMB")
    (rename "memoryMax" "MemoryMaxMB")
    titleCaseAttrs
  ];
  restartTransform = transform [
    titleCaseAttrs
  ];
  scalingTransform = transform [
    titleCaseAttrs
  ];
  serviceTransform = transform [
    (update "checkRestart" checkRestartTransform)
    (update "checks" (map checkTransform))
    (update "connect" connectTransform)
    (rename "port" "PortLabel")
    (rename "task" "TaskName")
    titleCaseAttrs
  ];
  sidecarServiceTransform = transform [
    (update "proxy" proxyTransform)
    titleCaseAttrs
  ];
  sidecarTaskTransform = transform [
    (update "logs" logsTransform)
    (update "resources" resourcesTransform)
    titleCaseAttrs
  ];
  spreadTransform = transform [
    (update "targets" (mapAttrsToList spreadTargetTransform))
    (rename "targets" "spreadTarget")
    titleCaseAttrs
  ];
  spreadTargetTransform = label: transform [
    (add "value" label)
    titleCaseAttrs
  ];
  taskTransform = name: transform [
    (add "name" name)
    (update "affinities" (map affinityTransform))
    (update "artifacts" (map artifactTransform))
    (update "constraints" (map constraintTransform))
    (update "dispatchPayload" dispatchPayloadTransform)
    (update "lifecycle" lifecycleTransform)
    (update "logs" logsTransform)
    (update "resources" resourcesTransform)
    (update "restart" restartTransform)
    (update "services" (map serviceTransform))
    (update "spreads" (map spreadTransform))
    (update "templates" (map templateTransform))
    (update "vault" vaultTransform)
    (update "volumeMounts" (map volumeMountTransform))
    (rename "logs" "logConfig")
    (rename "restart" "RestartPolicy")
    titleCaseAttrs
  ];
  templateTransform = transform [
    (update "wait" titleCaseAttrs)
    (rename "source" "SourcePath")
    (rename "destination" "DestPath")
    (rename "data" "EmbeddedTmpl")
    (rename "leftDelimiter" "LeftDelim")
    (rename "rightDelimiter" "RightDelim")
    (rename "env" "Envvars")
    titleCaseAttrs
  ];
  updateTransform = transform [
    titleCaseAttrs
  ];
  upstreamsTransform = transform [
    (update "meshGateway" titleCaseAttrs)
    titleCaseAttrs
  ];
  vaultTransform = transform [
    titleCaseAttrs
  ];
  volumeMountTransform = transform [
    titleCaseAttrs
  ];
  volumeTransform = name: transform [
    titleCaseAttrs
  ];

  configToJson = jobs: mapAttrs (k: v: { Job = jobTransform k v; }) jobs;
in
rec {
  mkNomadJobSet = configuration:
    if builtins.isPath configuration
    then mkNomadJobSet (import configuration)
    else configToJson (evaluateConfiguration configuration).config.jobs;
}
