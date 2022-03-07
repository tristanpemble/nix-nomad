{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  # TODO: verify sysbatch job type

  options.metaOptional = mkOption {
    type = types.listOf types.str;
    default = [];
    description = ''
      Specifies the set of metadata keys that may be provided when dispatching against the job.
    '';
  };

  options.metaRequired = mkOption {
    type = types.listOf types.str;
    default = [];
    description = ''
      Specifies the set of metadata keys that may be provided when dispatching against the job.
    '';
  };

  options.payload = mkOption {
    type = types.enum ["optional" "required" "forbidden"];
    default = "optional";
    description = ''
      Specifies the requirement of providing a payload when dispatching against the parameterized job. The maximum size
      of a payload is 16 KiB. The options for this field are:
        - "optional" - A payload is optional when dispatching against the job.
        - "required" - A payload must be provided when dispatching against the job.
        - "forbidden" - A payload is forbidden when dispatching against the job.
    '';
  };
}
