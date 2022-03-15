{
  jobs.hello.type = "batch";
  jobs.hello.datacenters = ["dc1"];

  jobs.hello.groups.webs = {
    count = 1;

    tasks.frontend = {
      driver = "raw_exec";

      config = {
        command = "echo";
        args = ["hello"];
      };
    };
  };
}
