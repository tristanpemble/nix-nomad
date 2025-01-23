{ pkgs }: with pkgs;

mkShell {
  buildInputs = [
    go
    gomod2nix
    jq
    nomad_1_9
  ];
}
