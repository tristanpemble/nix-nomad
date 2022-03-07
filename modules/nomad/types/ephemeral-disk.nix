{ lib, ... }:

let
  inherit (lib) mkOption types;
  nomad = import ./. types;
in
{
  options.migrate = mkOption {
    type = types.bool;
    default = false;
    description = ''
       When sticky is true, this specifies that the Nomad client should make a best-effort attempt to migrate the data
       from a remote machine if placement cannot be made on the original node. During data migration, the task will
       block starting until the data migration has completed. Migration is atomic and any partially migrated data will
       be removed if an error is encountered.
    '';
  };

  options.size = mkOption {
    type = types.ints.unsigned;
    default = 300;
    description = ''
      Specifies the size of the ephemeral disk in MB. The current Nomad ephemeral storage implementation does not
      enforce this limit; however, it is used during job placement.
    '';
  };

  options.sticky = mkOption {
    type = types.bool;
    default = false;
    description = ''
      Specifies that Nomad should make a best-effort attempt to place the updated allocation on the same machine. This
      will move the local/ and alloc/data directories to the new allocation.
    '';
  };
}
