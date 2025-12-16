{ pkgs
, lib
, self
}:

let

  moduleDocs = pkgs.nmd.buildModulesDocs {
    moduleRootPaths = [ self ];
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

  docs = pkgs.nmd.buildDocBookDocs {
    pathName = "nix-nomad";
    modulesDocs = [ moduleDocs ];
    documentsDirectory = ./.;
    documentType = "book";
    chunkToc = ''
      <toc>
        <d:tocentry xmlns:d="http://docbook.org/ns/docbook" linkend="book-nix-nomad-manual"><?dbhtml filename="index.html"?>
        </d:tocentry>
      </toc>
    '';
  };
in
docs.html
