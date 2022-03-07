{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
  signals = [
    "SIGHUP"
    "SIGINT"
    "SIGQUIT"
    "SIGILL"
    "SIGTRAP"
    "SIGABRT"
    "SIGIOT"
    "SIGBUS"
    "SIGEMT"
    "SIGFPE"
    "SIGKILL"
    "SIGUSR1"
    "SIGSEGV"
    "SIGUSR2"
    "SIGPIPE"
    "SIGALRM"
    "SIGTERM"
    "SIGSTKFLT"
    "SIGCHLD"
    "SIGCLD"
    "SIGCONT"
    "SIGSTOP"
    "SIGTSTP"
    "SIGTTIN"
    "SIGTTOU"
    "SIGURG"
    "SIGXCPU"
    "SIGXFSZ"
    "SIGVTALRM"
    "SIGPROF"
    "SIGWINCH"
    "SIGIO"
    "SIGPOLL"
    "SIGPWR"
    "SIGINFO"
    "SIGLOST"
    "SIGSYS"
    "SIGUNUSED"
  ];
in
{
  options.artifacts = mkOption {
    type = types.listOf nomad.artifact;
    default = [];
    description = ''
      A list of Artifact objects which define artifacts to be downloaded before the task is run.
    '';
    example = {
    };
  };

  options.config = mkOption {
    type = types.attrs;
    default = {};
    description = ''
      A map of key-value configuration passed into the driver to start the task. The details of configurations are specific to each driver.
    '';
    example = {

    };
  };

  options.constraints = mkOption {
    type = types.listOf nomad.constraint;
    default = [];
    description = ''
      A list to define additional constraints where a task can be run.
    '';
    example = {
      constraints = [{
        operator = "distinct_hosts";
        value = "true";
      }];
    };
  };

  options.affinities = mkOption {
    type = types.listOf nomad.affinity;
    default = [];
    description = ''
      A list to define placement preferences on nodes where a task can be run.
    '';
    example = {

    };
  };

  options.spreads = mkOption {
    type = types.listOf nomad.spread;
    default = [];
    description = ''
      A list to define allocation spread across attributes.
    '';
    example = {

    };
  };

  options.dispatchPayload = mkOption {
    type = types.nullOr nomad.dispatchPayload;
    default = null;
    description = ''
      Configures the task to have access to dispatch payloads.
    '';
    example = {

    };
  };

  options.driver = mkOption {
    type = types.either (types.enum ["docker" "qemu" "java" "exec"]) types.str;
    description = ''
      Specifies the task driver that should be used to run the task. See the driver documentation for what is available.
      Examples include docker, qemu, java, and exec.
    '';
    example = {
      driver = "qemu";
    };
  };

  options.env = mkOption {
    type = types.attrsOf types.str;
    default = {};
    description = ''
      A map of key-value representing environment variables that will be passed along to the running process. Nomad
      variables are interpreted when set in the environment variable values.
    '';
    example = {
      NODE_CLASS = "$${nomad.class}";
    };
  };

  options.killSignal = mkOption {
    type = types.enum signals;
    default = "SIGINT";
    description = ''
      Specifies a configurable kill signal for a task, where the default is SIGINT.
    '';
    example = {
      killSignal = "SIGHUP";
    };
  };

  options.killTimeout = mkOption {
    type = types.ints.unsigned;
    default = 5000000000;
    description = ''
      A time duration in nanoseconds. It can be used to configure the time between signaling a task it will be killed
      and actually killing it. Drivers first sends a task the SIGINT signal and then sends SIGTERM if the task doesn't
      die after the KillTimeout duration has elapsed. The default KillTimeout is 5 seconds.
    '';
    example = {
      killTimeout = 10000000000;
    };
  };

  options.leader = mkOption {
    type = types.bool;
    default = false;
    description = ''
      Specifies whether the task is the leader task of the task group. If set to true, when the leader task completes,
      all other tasks within the task group will be gracefully shutdown.
    '';
    example = {
      leader = true;
    };
  };

  options.logConfig = mkOption {
    type = types.nullOr nomad.logs;
    default = null;
    description = ''
      This allows configuring log rotation for the stdout and stderr buffers of a Task.
    '';
    example = {

    };
  };

  options.meta = mkOption {
    type = types.attrs;
    default = {};
    description = ''
      Annotates the task with opaque metadata.
    '';
    example = {
      meta = {
        foo = "bar";
      };
    };
  };

  options.resources = mkOption {
    type = types.nullOr nomad.resources;
    default = null;
    description = ''
      Provides the resource requirements of the task.
    '';
    example = {

    };
  };

  options.restartPolicy = mkOption {
    type = types.nullOr nomad.restart;
    default = null;
    description = ''
      Specifies the task-specific restart policy. If omitted, the restart policy from the encapsulating task group is
      used. If both are present, they are merged.
    '';
    example = {

    };
  };

  options.services = mkOption {
    type = types.listOf nomad.service;
    default = [];
    description = ''
      A list of Service objects. Nomad integrates with Consul for service discovery. A Service object represents a
      routable and discoverable service on the network. Nomad automatically registers when a task is started and
      de-registers it when the task transitions to the dead state.
    '';
    example = {

    };
  };

  options.shutdownDelay = mkOption {
    type = types.nullOr types.ints.unsigned;
    default = null;
    description = ''
      Specifies the duration to wait when killing a task between removing it from Consul and sending it a shutdown
      signal. Ideally services would fail healthchecks once they receive a shutdown signal. Alternatively ShutdownDelay
      may be set to give in flight requests time to complete before shutting down.
    '';
    example = {
      shutdownDelay = 3000000000;
    };
  };

  options.templates = mkOption {
    type = types.listOf nomad.template;
    default = [];
    description = ''
      Specifies the set of Template objects to render for the task. Templates can be used to inject both static and
      dynamic configuration with data populated from environment variables, Consul and Vault.
    '';
    example = {

    };
  };

  options.user = mkOption {
    type = types.nullOr types.str;
    default = null;
    description = ''
      Set the user that will run the task. It defaults to the same user the Nomad client is being run as. This can only
      be set on Linux platforms
    '';
    example = {
      user = "stanley";
    };
  };
}
