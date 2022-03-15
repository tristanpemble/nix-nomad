{ lib, nomad }:

configuration:

let evaluated = lib.evalModules {
  modules = [ ({ _module.args = { inherit nomad; }; }) ../modules/core.nix ] ++ (lib.toList configuration);
}; in
let jobs = lib.mapAttrs nomad.mkJobAPI evaluated.config.jobs; in
jobs
