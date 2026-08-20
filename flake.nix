{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;

      pkgsFor = system: import nixpkgs {
        inherit system;
        config.allowUnfreePredicate = package:
          builtins.elem (nixpkgs.lib.getName package) [ "nomad" ];
      };

      packagesFor = system:
        let
          pkgs = pkgsFor system;
        in
        {
          docs = pkgs.callPackage ./docs.nix { inherit self; };
        };
    in
    {
      lib = import ./lib {
        inherit pkgsFor systems;
        inherit (nixpkgs) lib;
      };

      packages = forAllSystems packagesFor;

      devShells = forAllSystems
        (system:
          let
            pkgs = pkgsFor system;
            nomad = pkgs.nomad;
          in
          {
            default = pkgs.callPackage ./shell.nix { inherit nomad; };
          });

      checks = forAllSystems
        (system:
          let
            pkgs = pkgsFor system;
            nomad = pkgs.nomad;
          in
          {
            hello = (self.lib.nomadConfiguration {
              modules = [
                ./examples/hello.nix
                ./examples/goodbye.nix
                ./examples/docs.nix
              ];
            }).${system}.jobsPackage;

            network-ports = pkgs.writeText "network-port-tests" (import ./tests/network-ports.nix {
              inherit nomad pkgs system;
              api = self.lib;
            });

            hcl-json-parity = pkgs.writeText "hcl-json-parity-tests" (import ./tests/hcl-json-parity.nix {
              inherit nomad pkgs system;
              api = self.lib;
            });

            api = pkgs.writeText "api-tests" (import ./tests/api.nix {
              inherit nomad pkgs system;
              api = self.lib;
            });

            non-flake = pkgs.writeText "non-flake-tests" (import ./tests/non-flake.nix {
              inherit pkgs;
            });
          });
    };
}
