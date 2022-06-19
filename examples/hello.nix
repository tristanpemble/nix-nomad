{
  job.hello.type = "batch";
  job.hello.datacenters = ["dc1"];

  job.hello.group.webs = {
    count = 1;

    task.frontend = {
      driver = "raw_exec";

      config = {
        command = "echo";
        args = ["hello"];
      };
    };
  };
}
