{
  jobs.docs = {
    region = "us";

    datacenters = ["us-west-1" "us-east-1"];

    type = "service";

    affinities = [{}];
    constraints = [{}];
    #multiregion = {};
    parameterized = {};
    periodic = {
      cron = "* * * * * *";
    };
    reschedule = {};
    spreads = [{}];
    vault = {};

    migrate = {};

    update = {
      stagger = 30*1000000000;
      maxParallel = 2;
    };

    groups.webs = {
      affinities = [{}];
      constraints = [{}];
      consul = {};
      ephemeralDisk = {};
      migrate = {};
      reschedule = {};
      restart = {};
      scaling = {
        max = 10;
      };
      spreads = [{}];
      update = {};
      vault = {};
      volumes.foo = {
        source = "somewhere";
        type = "host";
      };

      count = 5;

      networks = [{
        dns = {};

        ports.http = {};

        ports.https = {
          static = 443;
        };
      }];

      services = [{
        port = "http";
        connect = {
          gateway = {};
          sidecarService = {};
          sidecarTask = {};
        };

        checkRestart = {};
        checks = [{
          type = "http";
          path = "/health";
          interval = 10*1000000000;
          timeout = 2*1000000000;
        }];
      }];

      tasks.frontend = {
        affinities = [{}];
        artifacts = [{
          source = "hello";
        }];
        constraints = [{}];
        logs = {};
        restart = {};
        services  = [{}];
        templates = [{
          destination = "foobar.json";
        }];
        dispatchPayload = {};

        driver = "docker";

        config = {
          image = "hashicorp/web-frontend";
          ports = ["http" "https"];
        };

        env = {
          DB_HOST = "db01.example.com";
          DB_USER = "web";
          DB_PASS = "loremipsum";
        };

        resources  = {
          cpu = 500; # MHz
          memory = 128; # MB
        };
      };
    };
  };
}
