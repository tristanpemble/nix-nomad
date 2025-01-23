{
  inputs = {
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
    flake-utils.url = "github:numtide/flake-utils";
    gomod2nix.url = "github:tweag/gomod2nix";
    gomod2nix.inputs.flake-utils.follows = "flake-utils";
    nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
  };

  outputs = { self, nixpkgs, nixpkgs-lib, flake-utils, gomod2nix, ... }: flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs {
      inherit system; overlays = [ gomod2nix.overlays.default ];
      config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) ["nomad"];
    };
  in {
    packages.default = self.packages.${system}.generator;
    packages.generator = pkgs.callPackage ./generator {};
    packages.docs = pkgs.callPackage ./docs { inherit self; };
    devShells.default = pkgs.callPackage ./shell.nix {};
    checks.hello = self.lib.mkNomadJobs {
       inherit system pkgs;
       config = [ ./examples/hello.nix ./examples/goodbye.nix ./examples/docs.nix ];
    };
  }) // {
    lib = import ./lib/without-pkgs.nix { inherit self nixpkgs nixpkgs-lib; };
    overlays.default = final: prev:                   {
      lib = prev.lib
        // (import ./lib/without-pkgs.nix { inherit self nixpkgs nixpkgs-lib; })
        // (import ./lib/with-pkgs.nix { inherit (prev) lib; pkgs = final; });
    };
  };
}
