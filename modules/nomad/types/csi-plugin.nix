{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.id = mkOption {
    type = types.str;
    description = ''
      This is the ID for the plugin. Some plugins will require both controller and node plugin types (see below); you
      need to use the same ID for both so that Nomad knows they belong to the same plugin.
    '';
  };

  options.type = mkOption {
    type = types.enum ["node" "controller" "monolith"];
    description = ''
      One of node, controller, or monolith. Each plugin supports one or more types. Each Nomad client node where you
      want to mount a volume will need a node plugin instance. Some plugins will also require one or more controller
      plugin instances to communicate with the storage provider's APIs. Some plugins can serve as both controller and
      node at the same time, and these are called monolith plugins. Refer to your CSI plugin's documentation.
    '';
  };

  options.mountDir = mkOption {
    type = types.str;
    description = ''
      The directory path inside the container where the plugin will expect a Unix domain socket for bidirectional
      communication with Nomad.
    '';
  };
}
