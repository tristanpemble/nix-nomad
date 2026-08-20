{ self, pkgs }:

let
  mkJob = network: {
    job.test = {
      datacenters = [ "dc1" ];
      group.servers = {
        networks = [ network ];
        task.server = {
          driver = "raw_exec";
          config.command = "/bin/true";
        };
      };
    };
  };

  evalNetwork = network:
    let
      evaluated = self.lib.evalNomadJobs {
        inherit pkgs;
        config = mkJob network;
      };
      job = evaluated.nomad.build.apiJob.test;
    in
    builtins.head ((builtins.head job.TaskGroups).Networks);

  evalFromJSON = value:
    (self.lib.evalNomadJobs {
      inherit pkgs;
      config = { config, lib, ... }: {
        options.test.network = lib.mkOption {
          type = lib.types.raw;
        };
        config.test.network = config._module.transformers.NetworkResource.fromJSON value;
      };
    }).test.network;

  dynamic = evalNetwork {
    port.http.to = 8080;
  };

  static = evalNetwork {
    port.http = {
      static = 80;
      to = 8080;
    };
  };

  mixed = evalNetwork {
    port.http.to = 8080;
    port.https = {
      static = 443;
      to = 8443;
    };
  };

  legacy = evalNetwork {
    reservedPorts.http = {
      static = 80;
      to = 8080;
    };
  };

  duplicate = builtins.tryEval (builtins.deepSeq
    (evalNetwork {
      port.http.static = 80;
      reservedPorts.http.static = 80;
    })
    true);

  invalidLegacy = builtins.tryEval (builtins.deepSeq
    (evalNetwork {
      reservedPorts.http.to = 8080;
    })
    true);

  imported = evalFromJSON {
    CIDR = "10.0.0.0/24";
    DynamicPorts = [{
      Label = "http";
      Value = 24567;
      To = 8080;
    }];
    ReservedPorts = [{
      Label = "https";
      Value = 443;
      To = 8443;
    }];
  };

  duplicateJSON = builtins.tryEval (builtins.deepSeq
    (evalFromJSON {
      DynamicPorts = [{ Label = "http"; }];
      ReservedPorts = [{ Label = "http"; Value = 80; }];
    })
    true);
in
assert dynamic.DynamicPorts == [{ Label = "http"; To = 8080; }];
assert !(dynamic ? ReservedPorts);
assert static.ReservedPorts == [{ Label = "http"; To = 8080; Value = 80; }];
assert !(static ? DynamicPorts);
assert mixed.DynamicPorts == [{ Label = "http"; To = 8080; }];
assert mixed.ReservedPorts == [{ Label = "https"; To = 8443; Value = 443; }];
assert legacy == static;
assert !duplicate.success;
assert !invalidLegacy.success;
assert imported.cidr == "10.0.0.0/24";
assert imported.port.http.static == null;
assert imported.port.http.to == 8080;
assert imported.port.https.static == 443;
assert imported.port.https.to == 8443;
assert !(imported ? reservedPorts);
assert !duplicateJSON.success;
"ok"
