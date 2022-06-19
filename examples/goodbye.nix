{
  job.goodbye.type = "batch";
  job.goodbye.datacenters = ["dc1"];

  job.goodbye.group.webs = {
    count = 1;

    task.frontend = {
      driver = "raw_exec";

      config = {
        command = "echo";
        args = ["goodbye"];
      };
    };
  };
}
