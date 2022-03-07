{
  jobs.docs = {
    # Specify this job should run in the region named "us". Regions
    # are defined by the Nomad servers' configuration.
    region = "us";

    # Spread the tasks in this job between us-west-1 and us-east-1.
    datacenters = ["us-west-1" "us-east-1"];

    # Run this job as a "service" type. Each job type has different
    # properties. See the documentation below for more examples.
    type = "service";

    # Specify this job to have rolling updates, two-at-a-time, with
    # 30 second intervals.
    update = {
      stagger = 30*1000000000;
      max_parallel = 2;
    };

    # A group defines a series of tasks that should be co-located
    # on the same client (host). All tasks within a group will be
    # placed on the same host.
    groups.webs = {
      # Specify the number of these tasks we want.
      count = 5;

      network = {
        # This requests a dynamic port named "http". This will
        # be something like "46283", but we refer to it via the
        # label "http".
        ports.http = {};

        # This requests a static port on 443 on the host. This
        # will restrict this task to running once per host, since
        # there is only one port 443 on each host.
        ports.https = {
          static = 443;
        };
      };

      # The service block tells Nomad how to register this service
      # with Consul for service discovery and monitoring.
      services = [{
        # This tells Consul to monitor the service on the port
        # labelled "http". Since Nomad allocates high dynamic port
        # numbers, we use labels to refer to them.
        port = "http";

        checks = [{
          type = "http";
          path = "/health";
          interval = 10*1000000000;
          timeout = 2*1000000000;
        }];
      }];

      # Create an individual task (unit of work). This particular
      # task utilizes a Docker container to front a web application.
      tasks.frontend = {
        # Specify the driver to be "docker". Nomad supports
        # multiple drivers.
        driver = "docker";

        # Configuration is specific to each driver.
        config = {
          image = "hashicorp/web-frontend";
          ports = ["http" "https"];
        };

        # It is possible to set environment variables which will be
        # available to the task when it runs.
        env = {
          DB_HOST = "db01.example.com";
          DB_USER = "web";
          DB_PASS = "loremipsum";
        };

        # Specify the maximum resources required to run the task,
        # include CPU and memory.
        resources  = {
          cpu = 500; # MHz
          memory = 128; # MB
        };
      };
    };
  };
}
