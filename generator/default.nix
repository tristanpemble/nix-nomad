{ buildGoApplication }:

buildGoApplication {
  pname = "nix-nomad";
  version = "0.1";
  src = ./.;
  modules = ./gomod2nix.toml;
}
