{ pkgs }:

let
  nix-nomad = import ../default.nix { inherit pkgs; };
  system = pkgs.stdenv.hostPlatform.system;
  modules = [{
    jobs.test = {
      type = "batch";
      datacenters = [ "dc1" ];
      group.test.task.test = {
        driver = "raw_exec";
        config.command = "/bin/true";
      };
    };
  }];
  configuration = nix-nomad.lib.nomadConfiguration { inherit modules; };
in
assert builtins.attrNames nix-nomad == [ "lib" ];
assert builtins.attrNames nix-nomad.lib == [ "nomadConfiguration" "time" ];
assert !(nix-nomad ? packages);
assert builtins.attrNames configuration == [ system ];
assert pkgs.lib.isDerivation configuration.${system}.jobsPackage;
"ok"
