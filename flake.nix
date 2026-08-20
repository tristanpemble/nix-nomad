{
  inputs = {
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
    flake-utils.url = "github:numtide/flake-utils";
    gomod2nix.url = "github:tweag/gomod2nix";
    gomod2nix.inputs.flake-utils.follows = "flake-utils";
    nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-lib, flake-utils, gomod2nix, ... }: flake-utils.lib.eachDefaultSystem
    (system:
      let
        pkgs = import nixpkgs {
          inherit system; overlays = [ gomod2nix.overlays.default ];
          config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [ "nomad" ];
        };
        nomad = pkgs.callPackage ./nomad.nix { };
      in
      {
        packages.default = self.packages.${system}.generator;
        packages.generator = pkgs.callPackage ./generator { };
        packages.nomad = nomad;
        packages.docs = pkgs.callPackage ./docs.nix {
          inherit self;
        };
        devShells.default = pkgs.callPackage ./shell.nix { inherit nomad; };
        checks.hello = self.lib.mkNomadJobs {
          inherit system pkgs;
          config = [ ./examples/hello.nix ./examples/goodbye.nix ./examples/docs.nix ];
        };
        checks.network-ports = pkgs.writeText "network-port-tests" (import ./tests/network-ports.nix {
          inherit self pkgs;
        });
      }) // {
    lib = import ./lib/without-pkgs.nix { inherit self nixpkgs nixpkgs-lib; };
    overlays.default = final: prev: {
      lib = prev.lib
        // (import ./lib/without-pkgs.nix { inherit self nixpkgs nixpkgs-lib; })
        // (import ./lib/with-pkgs.nix { inherit (prev) lib; pkgs = final; });
    };
  };
}
