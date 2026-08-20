{ buildGoModule
, lib
, makeWrapper
, nix
}:

buildGoModule {
  pname = "nix-nomad";
  version = "0.1.0";

  src = lib.cleanSource ./.;
  vendorHash = "sha256-Fx5aHPDPjwe9iomWBJa3yMcuIHx4W2CtHwMg1q62rDI=";

  nativeBuildInputs = [ makeWrapper ];

  ldflags = [ "-s" "-w" "-X main.version=0.1.0" ];

  postInstall = ''
    mv "$out/bin/cli" "$out/bin/nix-nomad"
    wrapProgram "$out/bin/nix-nomad" \
      --prefix PATH : ${lib.makeBinPath [ nix ]}
  '';

  meta = {
    description = "Build and deploy Nomad jobs from a nix-nomad flake";
    license = lib.licenses.mit;
    mainProgram = "nix-nomad";
    platforms = lib.platforms.unix;
  };
}
