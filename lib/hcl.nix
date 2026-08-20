{ lib
, pkgs
}:

{
  importModule =
    { nomad
    , path
    , variables ? { }
    }:
    let
      parsed = lib.importJSON (pkgs.runCommand "${baseNameOf path}.json"
        {
          JOB_FILE = path;
          VAR_FILE = pkgs.writeText "${baseNameOf path}-variables.json" (builtins.toJSON variables);
        }
        ''
          ${lib.getExe nomad} job run \
            -var-file="$VAR_FILE" \
            -output "$JOB_FILE" \
            > "$out"
        '');
    in
    { config, ... }:
    let
      job = config._module.transformers.Job.fromJSON parsed.Job;
    in
    {
      jobs.${job.name} = builtins.removeAttrs job [ "id" "name" ];
    };
}
