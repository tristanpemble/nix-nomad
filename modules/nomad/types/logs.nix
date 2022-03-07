{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.maxFiles = mkOption {
    type = types.ints.unsigned;
    default = 10;
    description = ''
      Specifies the maximum number of rotated files Nomad will retain for stdout and stderr. Each stream is tracked
      individually, so specifying a value of 2 will create 4 files - 2 for stdout and 2 for stderr
    '';
  };

  options.maxFileSize = mkOption {
    type = types.ints.unsigned;
    default = 10;
    description = ''
      Specifies the maximum size of each rotated file in MB. If the amount of disk resource requested for the task is
      less than the total amount of disk space needed to retain the rotated set of files, Nomad will return a validation
      error when a job is submitted.
    '';
  };
}
