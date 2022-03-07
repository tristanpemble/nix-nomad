{ pkgs ? import <nixpkgs> {}
}:

let
  inherit (pkgs) lib;

  nmdSrc = pkgs.fetchFromGitLab {
    name = "nmd";
    owner = "rycee";
    repo = "nmd";
    rev = "527245ff605bde88c2dd2ddae21c6479bb7cf8aa";
    sha256 = "1zi0f9y3wq4bpslx1py3sfgrgd9av41ahpandvs6rvkpisfsqqlp";
  };

  nmd = import nmdSrc { inherit lib pkgs; };

  moduleDocs = nmd.buildModulesDocs {
    moduleRootPaths = [ ../modules ];
    mkModuleUrl = path: "https://github.com/tristanpemble/nix-nomad/blob/main/${path}#blob-path";
    channelName = "nix-nomad";
    modules = import ../modules/modules.nix;
    docBook.id = "nix-nomad-options";
  };

  docs = nmd.buildDocBookDocs {
    pathName = "nix-nomad";
    modulesDocs = [ moduleDocs ];
    documentsDirectory = ./.;
    documentType = "book";
    chunkToc = ''
      <toc>
        <d:tocentry xmlns:d="http://docbook.org/ns/docbook" linkend="book-nix-nomad-manual"><?dbhtml filename="index.html"?>
          <d:tocentry linkend="ch-nix-nomad"><?dbhtml filename="nix-nomad.html"?></d:tocentry>
        </d:tocentry>
      </toc>
    '';
  };
in docs
