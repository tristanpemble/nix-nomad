# nix-nomad

Generate Nomad JSON jobs files by writing Nix/NixOS modules.

```nix
let jobs = mkNomadJobs {
  jobs.hello = {
    type = "batch";
    datacenters = ["dc1"];

    groups.webs = {
      count = 1;

      tasks.frontend = {
        driver = "raw_exec";

        config = {
          command = "echo";
          args = ["hello"];
        };
      };
    };
  };
}; in jobs.hello
```
