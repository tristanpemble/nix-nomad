{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.destination = mkOption {
    type = types.str;
    default = "local/";
    description = ''
      Specifies the directory path to download the artifact, relative to the root of the task's working directory. If
      omitted, the default value is to place the artifact in local/. The destination is treated as a directory unless
      mode is set to file. Source files will be downloaded into that directory path. For more details on how the
      destination interacts with task drivers, see the Filesystem internals documentation.
    '';
  };

  options.mode = mkOption {
    type = types.str;
    default = "any";
    description = ''
      One of any, file, or dir. If set to file the destination must be a file, not a directory. By default the
      destination will be local/[filename].
    '';
  };

  options.options = mkOption {
    type = types.attrsOf types.str;
    default = {};
    description = ''
      Specifies configuration parameters to fetch the artifact. The key-value pairs map directly to parameters appended
      to the supplied source URL. Please see the go-getter documentation for a complete list of options and examples.
    '';
  };

  options.headers = mkOption {
    type = types.attrsOf types.str;
    default = {};
    description = ''
      Specifies HTTP headers to set when fetching the artifact using http or https protocol. Please see the go-getter
      headers documentation for more information.
    '';
  };

  options.source = mkOption {
    type = types.str;
    description = ''
      Specifies the URL of the artifact to download. See go-getter for details.
    '';
  };
}
