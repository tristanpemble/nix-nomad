{ nomad, pkgs }: with pkgs;

mkShell {
  buildInputs = [
    go
    jq
    nomad
  ];
}
