{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.hook = mkOption {
    type = types.enum ["prestart" "poststart" "poststop"];
    description = ''
      Specifies when a task should be run within the lifecycle of a group. The following hooks are available:
        - prestart - Will be started immediately. The main tasks will not start until all prestart tasks with sidecar =
          false have completed successfully.
        - poststart - Will be started once all main tasks are running.
        - poststop - Will be started once all main tasks have stopped successfully or exhausted their failure retries.
    '';
  };

  options.sidecar = mkOption {
    type = types.bool;
    default = false;
    description = ''
      Controls whether a task is ephemeral or long-lived within the task group. If a lifecycle task is ephemeral
      (sidecar = false), the task will not be restarted after it completes successfully. If a lifecycle task is
      long-lived (sidecar = true) and terminates, it will be restarted as long as the allocation is running.
    '';
  };
}
