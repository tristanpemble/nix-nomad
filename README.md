# nix-nomad

Generate [HashiCorp Nomad](https://nomadproject.io) JSON job files with [Nix](https://nixos.org) using
[NixOS modules](https://github.com/NixOS/nixpkgs/blob/master/lib/modules.nix).

## Why?

On its own, if used for a single job definition, this is overkill. However, NixOS modules becomes most  powerful when
working with many job definitions across multiple environments. You can compose jobs as modules, and create an API for
configuring each environment by defining your own NixOS module options.

The goal of this project is, if used with a tool like [terranix](https://terranix.org), to help adopt a fully Nix-ified
HashiCorp stack.

## Usage

The `mkNomadJobs` function takes in a module, path to a module, a list of modules, or a list of paths to modules. The
output is an attrset where each attr is a derivation that builds a JSON job file for the Nomad job of the same name.

Module options are enumerated in [the documentation](https://tristanpemble.github.io/nix-nomad/).

```nix
let myJobs = mkNomadJobs {
  job.hello = {
    type = "batch";
    datacenters = ["dc1"];

    group.webs = {
      count = 1;

      task.frontend = {
        driver = "raw_exec";

        config = {
          command = "echo";
          args = ["hello"];
        };
      };
    };
  };
}; in myJobs.hello
```

The above example evaluates to a derivation, that when built, outputs a JSON file containing the following (which has
been prettified for readability):

```json
{
  "Datacenters": [
    "dc1"
  ],
  "ID": "hello",
  "Name": "hello",
  "TaskGroups": [
    {
      "Count": 1,
      "Name": "webs",
      "Tasks": [
        {
          "Config": {
            "args": [
              "hello"
            ],
            "command": "echo"
          },
          "Driver": "raw_exec",
          "Name": "frontend"
        }
      ]
    }
  ],
  "Type": "batch"
}
```

You can run this job with the Nomad CLI on Nomad v1.3 and later:

```bash
nomad run -json ./result
```

Older versions of Nomad will require using Nomad's JSON API to run the job.
