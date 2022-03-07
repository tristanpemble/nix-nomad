{
  description = "A very basic flake";

  inputs.flake-compat.url = "github:edolstra/flake-compat";
  inputs.flake-compat.flake = false;
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system: let
    inherit (pkgs) callPackage mkShell;
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    lib = callPackage ./lib {};
    devShell = mkShell {
      buildInputs = with pkgs; [ jq nomad ];
    };
  });
}
