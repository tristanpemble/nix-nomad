# nix-nomad

nix-nomad lets you define [Nomad](https://developer.hashicorp.com/nomad) jobs
with the Nix module system. It builds each job as a Nomad JSON file.

Use nix-nomad when multiple jobs must share policies or service definitions.
You can also use it to define controlled differences between environments. For
one small job, plain Nomad HCL is usually simpler.

## Nomad version

By default, nix-nomad uses `pkgs.nomad` from its pinned Nixpkgs input. The
current Nixpkgs lock provides **Nomad 1.11.3**.

To use a different Nomad package, set the `nomad` argument of
`nomadConfiguration`. For details, see
[Select the Nomad version](#select-the-nomad-version).

## Why use nix-nomad

A Nomad job file describes one deployment. However, the same rules often apply
to many jobs. These rules can include datacenters, update policies, resource
limits, service registration, and environment values. If you copy these rules
into each HCL file, you must update and review each copy separately.

nix-nomad puts the related jobs in one Nix module configuration:

- **Apply shared policies.** Modules can add defaults, define options for your
  organization, and check rules across all jobs.
- **Show differences explicitly.** Nix module priorities and `lib.mkForce` let
  an environment override a shared definition. You do not have to copy the
  definition.
- **Build files that you can inspect.** The result is a derivation that contains
  one JSON file for each job. You can inspect, test, cache, and submit these
  files to Nomad.

The library produces JSON because Nomad accepts JSON directly. The
`nix-nomad` command can build, validate, plan, and submit the generated files.
Nomad continues to manage the deployment state.

## Quick start

This example defines and builds a small batch job. Add nix-nomad to your flake.
Then export a module through `nomadModules` and evaluate it through
`nomadConfigurations`:

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nomad.url = "github:tristanpemble/nix-nomad";
    nomad.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nomad, ... }:
  let
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-linux"
    ];
  in
  {
    nomadModules.default = {
      jobs.hello = {
        type = "batch";
        datacenters = [ "dc1" ];

        group.webs.task.frontend = {
          driver = "raw_exec";
          config = {
            command = "echo";
            args = [ "hello" ];
          };
        };

        update = with nomad.lib.time; {
          healthyDeadline = 15 * minute;
          progressDeadline = 1 * hour;
        };
      };
    };

    nomadConfigurations.default = nomad.lib.nomadConfiguration {
      modules = [ self.nomadModules.default ];
    };

    packages = forAllSystems (system: {
      default = self.nomadConfigurations.default.${system}.jobsPackage;
    });
  };
}
```

Build and inspect the output:

```console
$ nix build
$ ls result
hello.json
$ nomad job run -json result/hello.json
```

## Command-line interface

Install the `nix-nomad` package, or run it from this flake. The command reads
`nomadConfigurations.<name>.<system>` from the selected flake. It builds the
job files and the Nomad package that the configuration selects.

```console
$ nix-nomad --flake .#default build
$ nix-nomad --flake .#default validate
$ nix-nomad --flake .#default plan
$ nix-nomad --flake .#default apply
```

If you do not specify a flake, the command uses `.#default`. It uses
`builtins.currentSystem` because it must run the selected Nomad package.
`build` creates the `result` link. The other commands process all JSON files in
the job package in name order. Before `apply` submits any job, it validates all
jobs. If you do not give a command, `nix-nomad` shows help.

Use the standard Nomad environment variables to configure the cluster
connection and authentication. These variables include `NOMAD_ADDR`,
`NOMAD_NAMESPACE`, `NOMAD_TOKEN`, and the Nomad TLS variables.

`apply` has two important limits:

- It does not remove jobs that are not in the configuration.
- An apply operation for multiple jobs is not atomic.

See the [option reference](https://tristanpemble.github.io/nix-nomad/) for the
full list of Nomad job options.

## Combine jobs and environments

Modules separate reusable policies from individual jobs. Multiple modules can
add values to the same job. They do not have to copy the full job definition.
For example, a shared module can set defaults for an organization:

```nix
{ lib, nix-nomad, ... }:

{
  jobs.api = {
    datacenters = lib.mkDefault [ "dc1" ];
    update = with nix-nomad.lib.time; {
      healthyDeadline = lib.mkDefault (15 * minute);
      progressDeadline = lib.mkDefault (1 * hour);
    };
  };
}
```

The job module defines the tasks and services in `jobs.api`. A production
environment module can set `jobs.api.datacenters` to a value with a higher
priority. Large configurations can define options for an organization and use
them to produce Nomad jobs. nix-nomad provides the Nomad types and JSON
conversion. Local modules provide the interface for the organization.

## Public API

The flake exports a function that creates configurations. It also exports
duration constants for Nomad jobs.

| API                      | Result                                                              | Use                                         |
| ------------------------ | ------------------------------------------------------------------- | ------------------------------------------- |
| `lib.nomadConfiguration` | Evaluated configurations and job packages for each supported system | Define a named flake configuration          |
| `lib.time`               | Nanosecond-based duration constants                                 | Write Nomad durations such as `15 * minute` |

`nomadConfiguration` has these arguments:

- `modules`: A required list of Nix modules.
- `nomad`: An optional function with the form
  `system: packages.${system}.nomad`.
- `extraSpecialArgs`: Optional extra arguments for each module.

`nomad` is a function, not a single Nomad derivation. nix-nomad calls this
function one time for each supported system. It passes the returned package to
the module evaluation for that system:

```nix
nomad.lib.nomadConfiguration {
  nomad = system: packages.${system}.nomad;
  modules = [ self.nomadModules.default ];
}
```

If you omit `nomad`, nix-nomad uses its default Nomad package for every system.

The function returns an attribute set. The keys are the supported systems. The
value for each system has these fields:

- `config`: The evaluated Nix configuration.
- `options`: The evaluated option declarations and metadata.
- `jobsPackage`: A derivation that contains one `<job-name>.json` file for each
  job.
- `nomad`: The selected Nomad package.
- `extendModules`: A function that adds more modules to the evaluation and
  returns the same type of result.

Each Nomad module also receives `nomad` and `nix-nomad`. `nix-nomad` contains
the duration constants and the HCL import helper.

## Select the Nomad version

For each build system, `nomadConfiguration` uses `pkgs.nomad` from the pinned
Nixpkgs input. Use the `nomad` argument to select a different package family.
This also selects a different Nomad API schema:

```nix
nix-nomad.lib.nomadConfiguration {
  nomad = system: pkgsFor.${system}.nomad_2_0;
  modules = [ ./jobs.nix ];
}
```

nix-nomad builds and runs a schema generator against the source of that Nomad
package. It then imports the generated Nix module. This process is an import
from derivation (IFD). Therefore, the first evaluation for a Nomad version can
be slow. The evaluation must permit IFD. The package must provide the Nomad
source and the vendored Go modules that the generator uses.

The selected Nomad package determines the API schema. This prevents a static,
hand-maintained option set from silently becoming different from the Nomad
server or CLI. However, version selection does not replace Nomad validation or
compatibility rules. Use a Nomad package that matches the target cluster.
Validate the generated jobs during deployment.

## Import an existing HCL job

You can include an existing HCL job in the same module evaluation:

```nix
{ lib, nix-nomad, nomad, ... }:

{
  imports = [
    (nix-nomad.hcl.importModule {
      inherit nomad;
      path = ./my-job.hcl;
      variables.foo = "bar";
    })
  ];

  jobs.my-job.region = lib.mkForce "global";
}
```

During evaluation, the helper runs `nomad job run -output`. It converts the
result to a Nix module and then applies the other modules. You can use this
process for a gradual migration:

1. Import the existing HCL.
2. Add policies or overrides in Nix.
3. Replace the HCL when you are ready.

This process also uses IFD. It is slower than a native Nix job definition. Use
it for migration, not as the primary method to define jobs.

## Non-flake use

For use without flakes, pass an existing Nixpkgs package set to `default.nix`.
This interface supports only the host system:

```nix
let
  lib = import <nixpkgs/lib>;
  pkgs = import <nixpkgs> {
    config.allowUnfreePredicate = package: lib.getName package == "nomad";
  };
  system = pkgs.stdenv.hostPlatform.system;
  nix-nomad = import ./nix-nomad { inherit pkgs; };
in
(nix-nomad.lib.nomadConfiguration {
  modules = [ ./jobs.nix ];
}).${system}.jobsPackage
```

## Development

Run all evaluation, conversion, API, and documentation checks:

```console
$ nix flake check
```

The development shell provides Go, Nomad, and `jq`:

```console
$ nix develop
```

The generator is an internal implementation detail. The supported interface is
the flake `lib` API described in [Public API](#public-api).
