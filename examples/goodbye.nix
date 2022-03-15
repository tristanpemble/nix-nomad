{
  jobs.goodbye.type = "batch";
  jobs.goodbye.datacenters = ["dc1"];

  jobs.goodbye.groups.webs = {
    count = 1;

    tasks.frontend = {
      driver = "raw_exec";

      config = {
        command = "echo";
        args = ["goodbye"];
      };
    };
  };
}
