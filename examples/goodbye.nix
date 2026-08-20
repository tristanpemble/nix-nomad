{
  jobs.goodbye.type = "batch";
  jobs.goodbye.datacenters = [ "dc1" ];

  jobs.goodbye.group.webs = {
    count = 1;

    task.frontend = {
      driver = "raw_exec";

      config = {
        command = "echo";
        args = [ "goodbye" ];
      };
    };
  };
}
