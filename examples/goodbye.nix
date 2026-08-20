{ nix-nomad, ... }:

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

  jobs.goodbye.update = with nix-nomad.time; {
    healthyDeadline = 15 * minute;
    progressDeadline = 1 * hour;
  };
}
