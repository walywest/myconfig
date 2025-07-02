{
  config,
  lib,
  pkgs,
  ...
}: let
  # ===== USER-CONFIGURABLE SETTINGS (EDIT ONLY THESE) =====
  settings = {
    enable = true; # Set to `false` to disable all limits
    cores = 4; # Max CPU cores to use (out of 8)
    maxJobs = 2; # Parallel builds (recommended: cores/2)
    minFreeMB = 128; # Minimum free memory (MB) before throttling
    maxFreeMB = 1000; # Maximum free memory (MB) to aim for
    useDevenvCache = true; # Enable Devenv's binary cache
  };
  # ===== END OF USER CONFIG =====

  # Convert MB to bytes for Nix's internal usage
  toBytes = mb: toString (mb * 1024 * 1024);
in {
  options = {
    buildResources = lib.mkOption {
      type = lib.types.attrs;
      default = settings; # Expose settings for external inspection
      internal = true; # Hide from manual (this is your single source of truth)
    };
  };

  config = lib.mkIf settings.enable {
    nix.settings = {
      inherit (settings) cores maxJobs;
      builders-use-substitutes = true;
      warn-dirty = false;
    };

    nix.extraOptions = ''
      min-free = ${toBytes settings.minFreeMB}
      max-free = ${toBytes settings.maxFreeMB}
    '';

    environment.sessionVariables.DEVENV_CACHE =
      lib.mkIf settings.useDevenvCache "1";
  };
}
