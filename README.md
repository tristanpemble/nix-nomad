# nix-nomad

nix-nomad defines [Nomad](https://developer.hashicorp.com/nomad) jobs with the
Nix module system and builds them as Nomad JSON files.

It is for job sets that need shared policy, reusable service definitions, and
controlled differences between environments. For one small job, plain Nomad
HCL is usually simpler.

## Why

A Nomad job file describes one deployment. A deployment system usually has
rules that apply across many job files: common datacenters, update policy,
resource limits, service registration, and environment-specific values.
Copying those rules into each HCL file makes the copies independent. Changes
then require coordinated edits and review.

nix-nomad makes the job set one Nix module configuration instead:

- **Compose policy with jobs.** Modules can add defaults, define organization
  options, and apply assertions across all jobs.
- **Keep differences explicit.** Nix module priorities and `lib.mkForce` let an
  environment override a shared definition without copying it.
- **Build inspectable artifacts.** The result is a derivation with one JSON file
  per job. The same files can be inspected, tested, cached, and submitted to
  Nomad.

JSON is the output boundary because Nomad accepts it directly. nix-nomad does
not submit jobs or manage deployment state. A deployment command, CI system, or
another Nix tool must consume the generated files.

## Quick start

Add nix-nomad to a flake, expose a module through `nomadModules`, and evaluate
it under `nomadConfigurations`:

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

See the [option reference](https://tristanpemble.github.io/nix-nomad/) for the
full list of Nomad job options.

## Compose jobs and environments

The main reason to use modules is to separate reusable policy from each job.
Modules can contribute to the same job without copying its full definition.
For example, a shared module can set organization defaults:

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

The job module defines `jobs.api` tasks and services. A production environment
module can set `jobs.api.datacenters` to a higher-priority value. Larger
configurations can define their own organization-level options and derive Nomad
jobs from them. nix-nomad supplies the Nomad-facing types and JSON conversion;
local modules supply that organization-specific interface.

## Public API

The flake exports one configuration constructor and the duration constants
used by Nomad jobs.

| API                      | Result                                                                          | Use                                         |
| ------------------------ | ------------------------------------------------------------------------------- | ------------------------------------------- |
| `lib.nomadConfiguration` | Evaluated configurations and job packages for each supported system | Define a named flake configuration |
| `lib.time`               | Nanosecond-based duration constants                                             | Write Nomad durations such as `15 * minute` |

`nomadConfiguration` accepts:

- `modules`: required list of Nix modules;
- `nomad`: optional function with the shape `system: packages.${system}.nomad`;
- `extraSpecialArgs`: optional extra arguments passed to each module.

`nomad` is a function, not one Nomad derivation. nix-nomad calls it once for
each supported system and passes the returned package into that system's module
evaluation:

```nix
nomad.lib.nomadConfiguration {
  nomad = system: packages.${system}.nomad;
  modules = [ self.nomadModules.default ];
}
```

Omit `nomad` to use nix-nomad's default Nomad package for every system.

It returns an attribute set keyed by supported system. Each system value has
these fields:

- `config`: the evaluated Nix configuration;
- `options`: the evaluated option declarations and metadata;
- `jobsPackage`: a derivation containing one `<job-name>.json` file per job;
- `nomad`: the selected Nomad package;
- `extendModules`: a function that extends the evaluation with more modules and
  returns the same result shape.

Every Nomad module also receives `nomad` and `nix-nomad`. `nix-nomad` contains the
duration constants and HCL import helper.

## Select the Nomad version

`nomadConfiguration` uses the project default Nomad package for each build
system. `nomad` selects a different package family and therefore a
different Nomad API schema:

```nix
nix-nomad.lib.nomadConfiguration {
  nomad = system: pkgsFor.${system}.nomad_1_11;
  modules = [ ./jobs.nix ];
}
```

nix-nomad builds a schema generator against that package's Nomad source, runs
it, and imports the generated Nix module. This is import from derivation (IFD).
The first evaluation for a Nomad version can therefore be slow, and evaluation
must permit IFD. The package must expose the Nomad source and vendored Go
modules used by the generator.

Version selection is explicit because a static, hand-maintained option set can
silently differ from the Nomad server or CLI. It does not replace Nomad's own
validation or compatibility rules. Use a Nomad package that matches the target
cluster and validate the generated jobs as part of deployment.

## Import an existing HCL job

An HCL job can participate in the same module evaluation:

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

The helper runs `nomad job run -output` during evaluation, converts the result
to a Nix module, and then applies other modules to it. This permits gradual
migration: import the existing HCL first, add policy or overrides in Nix, and
replace the HCL when useful.

This path also uses IFD and is slower than a native Nix job definition. It is a
migration boundary, not the primary authoring path.

## Non-flake use

Pass an existing Nixpkgs package set to `default.nix`. Only the host system is
available through this interface:

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

Run all evaluation, conversion, API, and documentation checks with:

```console
$ nix flake check
```

The development shell provides Go, Nomad, and `jq`:

```console
$ nix develop
```

The generator is an implementation detail. The supported interface is the
flake `lib` API described above.
