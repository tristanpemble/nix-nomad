{ lib, ... }:

with lib;

{
  options._module.types = mkOption {
    type = with types; attrsOf optionType;
    visible = false;
    internal = true;
  };
  options._module.transformers = mkOption {
    type = with types; attrsOf raw;
    visible = false;
    internal = true;
  };
}
