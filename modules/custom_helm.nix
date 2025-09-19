# helm.nix
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.helm;

  # Custom package definition for latest Helm
  helm-latest = pkgs.buildGoModule rec {
    pname = "helm";
    version = "3.17.2"; # Updated to version in your error message

    src = pkgs.fetchFromGitHub {
      owner = "helm";
      repo = "helm";
      rev = "v${version}";
      hash = "sha256-EMvKmnf4KfimjPYHoylij2kZVnvClK3Q/+offZvlO1I=";
    };

    vendorHash = "sha256-REPLACEME"; # You'll need to replace this after first attempt

    doCheck = false;

    # The key fix: correct path for the newer version
    subPackages = ["."];

    ldflags = [
      "-s"
      "-w"
      "-X helm.sh/helm/v3/internal/version.version=v${version}"
      "-X helm.sh/helm/v3/internal/version.gitCommit=unknown"
      "-X helm.sh/helm/v3/internal/version.gitTreeState=clean"
    ];

    # Rest of your configuration remains the same
  };
in {
  options.services.helm = {
    enable = mkEnableOption "Enable Helm package manager";

    package = mkOption {
      type = types.package;
      default = helm-latest;
      description = "The Helm package to use";
    };

    enableBashCompletion = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable bash completion for Helm";
    };

    enableZshCompletion = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable zsh completion for Helm";
    };

    enableFishCompletion = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable fish completion for Helm";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [cfg.package];

    programs = {
      bash.shellInit = mkIf cfg.enableBashCompletion ''
        source <(${cfg.package}/bin/helm completion bash)
      '';

      zsh.shellInit = mkIf cfg.enableZshCompletion ''
        source <(${cfg.package}/bin/helm completion zsh)
      '';

      fish.shellInit = mkIf cfg.enableFishCompletion ''
        ${cfg.package}/bin/helm completion fish | source
      '';
    };
  };
}
