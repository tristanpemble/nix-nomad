{ lib, ... }:
{
  jobs.docs = {
    type = "batch";
    datacenters = ["dc1"];

    groups.webs = {
      count = lib.mkDefault 1;

      tasks.frontend = {
        driver = "raw_exec";

        config = {
          command = "echo";
          args = ["hello"];
        };
      };
    };
  };
}
