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
      Specifies the behavior Nomad should take if the Vault token changes. The possible values are:
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

  options.env = mkOption {
    type = types.bool;
    default = true;
    description = ''
      Specifies if the VAULT_TOKEN and VAULT_NAMESPACE environment variables should be set when starting the task.
    '';
  };

  options.namespace = mkOption {
    type = types.str;
    default = "";
    description = ''
      Specifies the Vault Namespace to use for the task. The Nomad client will retrieve a Vault token that is scoped to
      this particular namespace.
    '';
  };

  options.policies = mkOption {
    type = types.listOf types.str;
    default = [];
    description = ''
      Specifies the set of Vault policies that the task requires. The Nomad client will retrieve a Vault token that is
      limited to those policies.
    '';
  };
}
