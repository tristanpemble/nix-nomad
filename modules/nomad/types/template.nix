{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.changeMode = mkOption {
    type = types.enum ["noop" "restart" "signal"];
    default = "restart";
    description = ''
      Specifies the behavior Nomad should take if the rendered template changes. Nomad will always write the new contents of the template to the specified destination. The possible values below describe Nomad's action after writing the template to disk.
        - "noop" - take no action (continue running the task)
        - "restart" - restart the task
        - "signal" - send a configurable signal to the task
    '';
  };

  options.changeSignal = mkOption {
    type = types.str;
    default = "";
    description = ''
      Specifies the signal to send to the task as a string like "SIGUSR1" or "SIGINT". This option is required if the
      change_mode is signal.
    '';
  };

  options.data = mkOption {
    type = types.str;
    default = "";
    description = ''
      Specifies the raw template to execute. One of source or data must be specified, but not both. This is useful for
      smaller templates, but we recommend using source for larger templates.
    '';
  };

  options.destination = mkOption {
    type = types.str;
    description = ''
      Specifies the location where the resulting template should be rendered, relative to the task working directory.
      Only drivers without filesystem isolation (ex. raw_exec) or that build a chroot in the task working directory (ex.
      exec) can render templates outside of the NOMAD_ALLOC_DIR, NOMAD_TASK_DIR, or NOMAD_SECRETS_DIR. For more details
      on how destination interacts with task drivers, see the Filesystem internals documentation.
    '';
  };

  options.env = mkOption {
    type = types.bool;
    default = false;
    description = ''
      Specifies the template should be read back in as environment variables for the task (see below). To update the
      environment on changes, you must set change_mode to restart. Setting env when the change_mode is signal will
      return a validation error. Setting env when the change_mode is noop is permitted but will not update the
      environment variables in the task.
    '';
  };

  options.leftDelimiter = mkOption {
    type = types.str;
    default = "{{";
    description = ''
      Specifies the left delimiter to use in the template. The default is "{{" for some templates, it may be easier to
      use a different delimiter that does not conflict with the output file itself.
    '';
  };

  options.perms = mkOption {
    type = types.str;
    default = "644";
    description = ''
      Specifies the rendered template's permissions. File permissions are given as octal of the Unix file permissions
      rwxrwxrwx.
    '';
  };

  options.rightDelimiter = mkOption {
    type = types.str;
    default = "}}";
    description = ''
      Specifies the right delimiter to use in the template. The default is "}}" for some templates, it may be easier to
      use a different delimiter that does not conflict with the output file itself.
    '';
  };

  options.source = mkOption {
    type = types.str;
    default = "";
    description = ''
      Specifies the path to the template to be rendered. One of source or data must be specified, but not both. This
      source can optionally be fetched using an artifact resource. This template must exist on the machine prior to
      starting the task; it is not possible to reference a template inside a Docker container, for example.
    '';
  };

  options.splay = mkOption {
    type = types.ints.unsigned;
    default = 5*1000000000;
    description = ''
      Specifies a random amount of time to wait between 0ns and the given splay value before invoking the change mode.
      This is specified in nanoseconds, and is often used to prevent a thundering herd problem where all task instances
      restart at the same time.
    '';
  };

  options.wait.min = mkOption {
    type = types.nullOr types.ints.unsigned;
    default = null;
    description = ''
      Defines the minimum and maximum amount of time to wait for the Consul cluster to reach a consistent state before
      rendering a template. This is useful to enable in systems where network connectivity to Consul is degraded,
      because it will reduce the number of times a template is rendered. This setting can be overridden by the
      client.template.wait_bounds. If the template configuration has a min lower than client.template.wait_bounds.min
      or a max greater than client.template.wait_bounds.max, the client's bounds will be enforced, and the template wait
      will be adjusted before being sent to consul-template.
    '';
  };

  options.wait.max = mkOption {
    type = types.nullOr types.ints.unsigned;
    default = null;
    description = ''
      Defines the minimum and maximum amount of time to wait for the Consul cluster to reach a consistent state before
      rendering a template. This is useful to enable in systems where network connectivity to Consul is degraded,
      because it will reduce the number of times a template is rendered. This setting can be overridden by the
      client.template.wait_bounds. If the template configuration has a min lower than client.template.wait_bounds.min
      or a max greater than client.template.wait_bounds.max, the client's bounds will be enforced, and the template wait
      will be adjusted before being sent to consul-template.
    '';
  };

  options.vaultGrace = mkOption {
    type = types.ints.unsigned;
    default = 15 * 1000000000;
    description = ''
      DEPRECATED
    '';
  };
}
