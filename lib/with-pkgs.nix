{ lib, pkgs }:

let inherit (pkgs) hcl2json runCommand writeText; in

rec {
  importHCL = path: lib.importJSON (runCommand "${baseNameOf path}.json" {} ''
    ${hcl2json}/bin/hcl2json < ${path} > $out
  '');
  fromHCL = text: importHCL (writeText "source.hcl" text);
}
