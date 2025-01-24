{ pkgs
, lib
, fetchFromGitLab
, self
}:

let
  nmdSrc = fetchFromGitLab {
    name = "nmd";
    owner = "rycee";
    repo = "nmd";
    rev = "527245ff605bde88c2dd2ddae21c6479bb7cf8aa";
    sha256 = "1zi0f9y3wq4bpslx1py3sfgrgd9av41ahpandvs6rvkpisfsqqlp";
  };

  nmd = import nmdSrc { inherit lib pkgs; };

  moduleDocs = nmd.buildModulesDocs {
    moduleRootPaths = [ ../. ];
    mkModuleUrl = path: "https://github.com/tristanpemble/nix-nomad/blob/main/${path}#blob-path";
    channelName = "nix-nomad";
    modules = [
      {
        options._module.args = lib.mkOption { visible = false; };
        config._module.args = { inherit lib; nomad = self.lib; };
      }
      ../modules
    ];
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
in
docs.html
