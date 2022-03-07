{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.file = mkOption {
    type = types.str;
    default = "";
    description = ''
       Specifies the file name to write the content of dispatch payload to. The file is written relative to the task's
       local directory.
    '';
  };
}
