{ go
, lib
, nomad
, stdenv
}:

assert lib.assertMsg (nomad ? src) "nix-nomad generator requires nomad.src";
assert lib.assertMsg (nomad ? goModules) "nix-nomad generator requires nomad.goModules";

stdenv.mkDerivation {
  pname = "nix-nomad-generator";
  inherit (nomad) version;

  dontUnpack = true;
  nativeBuildInputs = [ (nomad.go or go) ];

  generatorSource = lib.cleanSource ./.;

  buildPhase = ''
    runHook preBuild

    build_root="$TMPDIR/nix-nomad-generator"
    mkdir -p "$build_root/api" "$build_root/tools/nix-nomad-generator" "$build_root/vendor"

    cp ${nomad.src}/go.mod "$build_root/go.mod"
    cp -R ${nomad.src}/api/. "$build_root/api/"
    cp -R ${nomad.goModules}/. "$build_root/vendor/"

    cp -R "$generatorSource"/. "$build_root/tools/nix-nomad-generator/"
    rm "$build_root/tools/nix-nomad-generator/go.mod"
    rm "$build_root/tools/nix-nomad-generator/go.sum"

    export GOCACHE="$TMPDIR/go-cache"
    GOWORK=off GOFLAGS="-mod=vendor -buildvcs=false" \
      go -C "$build_root" build -trimpath -o nix-nomad-generator ./tools/nix-nomad-generator

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 "$TMPDIR/nix-nomad-generator/nix-nomad-generator" "$out/bin/nix-nomad-generator"
    runHook postInstall
  '';

  passthru = { inherit nomad; };

  meta = {
    description = "Generate nix-nomad modules for Nomad ${nomad.version}";
    license = lib.licenses.mit;
    mainProgram = "nix-nomad-generator";
    platforms = nomad.meta.platforms or lib.platforms.unix;
  };
}
