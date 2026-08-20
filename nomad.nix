{ fetchFromGitHub, nomad_2_0 }:

let
  version = "2.0.5";
in
nomad_2_0.overrideAttrs (_: {
  inherit version;

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = "nomad";
    rev = "v${version}";
    hash = "sha256-38FKorYBdjhGdJnuDb6nYt39A5318POmNMOLwYDirls=";
  };

  vendorHash = "sha256-eptrGukLHNTsJxcSAahtft/7UTiBsx65OcWJzXJZtS8=";

  ldflags = [
    "-X github.com/hashicorp/nomad/version.Version=${version}"
    "-X github.com/hashicorp/nomad/version.VersionPrerelease="
    "-X github.com/hashicorp/nomad/version.BuildDate=1970-01-01T00:00:00Z"
  ];

  tags = [
    "hashicorpmetrics"
    "ui"
  ];
})
