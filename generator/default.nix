{ buildGoApplication, go_1_19 }:

buildGoApplication {
  pname = "nix-nomad";
  version = "0.1";
  src = ./.;
  go = go_1_19;
  modules = ./gomod2nix.toml;
}
