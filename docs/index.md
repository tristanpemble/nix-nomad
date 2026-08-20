# nix-nomad

`nix-nomad` evaluates Nix modules into HashiCorp Nomad JSON job files. It does
not submit jobs or manage Nomad state.

## System model

```text
Nix module(s) -> Nix module evaluation -> Nomad API JSON -> Nomad CLI or API
```

All user configuration starts under `job.<name>`. Each job contains named task
groups. Each group contains named tasks that Nomad places together.

```text
job.<job name>
└── group.<group name>
    ├── count, networks, services, volumes, ...
    └── task.<task name>
        ├── driver and driver-specific config
        └── env, resources, services, templates, ...
```

For example, `job.hello.group.web.task.main` defines the task named `main` in
the group named `web` in the job named `hello`.

## Smallest job

Save this module as `jobs.nix`:

```nix
{
  job.hello = {
    type = "batch";
    datacenters = [ "dc1" ];

    group.web = {
      count = 1;

      task.main = {
        driver = "raw_exec";
        config = {
          command = "echo";
          args = [ "hello" ];
        };
      };
    };
  };
}
```

Expose the result from `mkNomadJobs` as a package in your flake. In this
example, `nixNomad` is the nix-nomad flake input and `pkgs` is the package set
for `system`:

```nix
packages.${system}.nomad-jobs = nixNomad.lib.mkNomadJobs {
  inherit pkgs;
  config = ./jobs.nix;
};
```

The result is a derivation that contains one JSON file for each job. The
example produces `hello.json`:

```console
$ nix build .#nomad-jobs
$ nomad job run -json result/hello.json
```

## Find an option

Start with the main structure, then use the filter field on the option page for
the exact field:

| Area | Option entry points |
| --- | --- |
| Job | [`job`](options.html#option-job), [`type`](options.html#option-job._name_.type), [`datacenters`](options.html#option-job._name_.datacenters) |
| Group | [`group.<name>`](options.html#option-job._name_.group), [`count`](options.html#option-job._name_.group._name_.count), [`networks`](options.html#option-job._name_.group._name_.networks) |
| Task | [`task.<name>`](options.html#option-job._name_.group._name_.task), [`driver`](options.html#option-job._name_.group._name_.task._name_.driver), [`config`](options.html#option-job._name_.group._name_.task._name_.config), [`resources`](options.html#option-job._name_.group._name_.task._name_.resources) |
| Integrations | [group services](options.html#option-job._name_.group._name_.services), [task services](options.html#option-job._name_.group._name_.task._name_.services), [volumes](options.html#option-job._name_.group._name_.volume) |

Option paths use two placeholders:

- `<name>` means an attribute-set key that you select, such as `hello` or
  `web`.
- `*` means one item in a Nix list.

The generated option reference is authoritative for Nix field names, types,
defaults, and source locations. Many generated fields do not contain local
descriptions. Use the [Nomad job specification](https://developer.hashicorp.com/nomad/docs/job-specification)
for their runtime meaning and driver-specific `config` fields.
