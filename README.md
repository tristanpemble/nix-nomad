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

### Overview

The `mkNomadJobs` function takes in a module, path to a module, a list of modules, or a list of paths to modules. The
output is an attrset where each attr is a derivation that builds a JSON job file for the Nomad job of the same name.

Module options are enumerated in [the documentation](https://tristanpemble.github.io/nix-nomad/).

```nix
mkNomadJobs {
  pkgs = import <nixpkgs> {};
  config = {
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

      update = with time; {
        healthyDeadline = 15 * minute;
        progressDeadline = 1 * hour;
      };
    };
  };
}
```

The above example evaluates to a derivation, that when built, outputs a folder containing a file named "hello.json".
The contents of the file, when prettified for readability, look like:

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
  "Type": "batch",
  "Update": {
    "HealthyDeadline": 900000000000,
    "ProgressDeadline": 3600000000000
  }
}
```

You can run this job with the Nomad CLI on Nomad v1.3 and later:

```bash
nomad run -json ./result/hello.json
```

Older versions of Nomad will require using Nomad's JSON API to run the job.

### Migrating from HCL

You can import an HCL job file using the method `importNomadModule`. It takes a path to an HCL job file, and an attrset
of variables to pass to the job.

```nix
{ lib, ... }:

{
  imports = [
    (lib.importNomadModule ./my-job.hcl { foo = "bar"; })
  ];
  
  job.my-job.region = lib.mkForce "global";  
}
```

This is using [import from derivation](https://nixos.wiki/wiki/Import_From_Derivation) with the `nomad job run -output [file]`
command; so it will be pretty slow. This is best used as an intermediate step for migrating your jobs to Nix.
