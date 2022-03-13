{
  description = "A very basic flake";

  inputs.flake-compat.url = "github:edolstra/flake-compat";
  inputs.flake-compat.flake = false;
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.gomod2nix.url = "github:tweag/gomod2nix";

  outputs = { self, nixpkgs, flake-utils, gomod2nix, ... }: flake-utils.lib.eachDefaultSystem (system: let
    inherit (pkgs) callPackage mkShell;
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        gomod2nix.overlay
      ];
    };
  in rec {
    defaultPackage = pkgs.buildGoApplication {
      pname = "nix-nomad";
      version = "0.1";
      src = ./.;
      modules = ./gomod2nix.toml;
    };
    devShell = pkgs.mkShell {
      buildInputs = [ pkgs.go pkgs.gomod2nix pkgs.jq pkgs.nomad ];
    };
    defaultApp = {
      type = "app";
      program = "${defaultPackage}/bin/nix-nomad";
    };
    overlay = self: super: {
      nix-nomad = defaultPackage;
    };
    lib = callPackage ./lib {};
  });
}
