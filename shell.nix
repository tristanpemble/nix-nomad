{ pkgs }:
with pkgs;

mkShell {
  buildInputs = [
    go
    gomod2nix
    jq
    nomad_1_10
  ];

  shellHook = ''
    unset DEVELOPER_DIR
  '';
}
