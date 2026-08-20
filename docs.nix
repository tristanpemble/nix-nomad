{ lib
, ndg
, nixosOptionsDoc
, pkgs
, runCommandLocal
, self
, writeTextDir
, writers
}:

let
  evaluatedModules = lib.evalModules {
    class = "nomad";
    modules = [
      {
        options._module.args = lib.mkOption { visible = false; };
      }
      ./modules
    ];
  };

  options = nixosOptionsDoc {
    inherit (evaluatedModules) options;
    variablelistId = "nix-nomad-options";
    warningsAreErrors = false;

    transformOptions = option: option // {
      declarations = map
        (declaration:
          let
            declarationString = toString declaration;
            projectRoot = toString self;
          in
          if lib.hasPrefix projectRoot declarationString then
            let
              relativePath = lib.removePrefix "/" (lib.removePrefix projectRoot declarationString);
            in
            {
              name = "<nix-nomad/${relativePath}>";
              url = "https://github.com/tristanpemble/nix-nomad/blob/main/${relativePath}";
            }
          else if declarationString == "lib/modules.nix" then
            {
              name = "<nixpkgs/lib/modules.nix>";
              url = "https://github.com/NixOS/nixpkgs/blob/master/lib/modules.nix";
            }
          else
            declaration)
        option.declarations;
    };
  };

  documentationSource = writeTextDir "index.md" (builtins.readFile ./README.md);

  ndgConfig = writers.writeTOML "ndg.toml" {
    highlight_code = true;
    search.enable = true;
    sidebar = {
      ordering = "custom";
      matches = [
        {
          path = "index.md";
          new_title = "Start here";
          position = 1;
        }
      ];
      options.depth = 2;
    };
  };
in
runCommandLocal "nix-nomad-docs" {
  nativeBuildInputs = [ ndg ];
  meta.description = "nix-nomad manual and Nix module option reference";
} ''
  ndg \
    --config-file ${ndgConfig} \
    html \
    --input-dir ${documentationSource} \
    --output-dir "$out" \
    --title "nix-nomad" \
    --module-options ${options.optionsJSON}/share/doc/nixos/options.json \
    --jobs "$NIX_BUILD_CORES"
''
