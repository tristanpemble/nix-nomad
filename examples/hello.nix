{
  jobs.hello.type = "batch";
  jobs.hello.datacenters = [ "dc1" ];

  jobs.hello.group.webs = {
    count = 1;

    task.frontend = {
      driver = "raw_exec";

      config = {
        command = "echo";
        args = [ "hello" ];
      };
    };
  };
}
