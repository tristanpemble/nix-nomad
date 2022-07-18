{ lib, pkgs }:

let inherit (pkgs) hcl2json nomad runCommand writeText; in

rec {
  importNomadHCL = path: vars: lib.importJSON (runCommand "${baseNameOf path}.json" {
    buildInputs = [ nomad ];
    VAR_FILE = writeText "${baseNameOf path}-vars.json" (builtins.toJSON vars);
  } ''
    nomad job run -var-file="$VAR_FILE" -output ${path} > $out
  '');

  fromNomadHCL = text: importNomadHCL (writeText "source.hcl" text);
}
