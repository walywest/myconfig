{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.k3d;
in {
  # Define module options
  options.services.k3d = {
    enable = mkEnableOption "k3d - A lightweight wrapper to run k3s in docker";

    package = mkOption {
      type = types.package;
      default = pkgs.callPackage ({ buildGoModule, fetchFromGitHub }:
        buildGoModule rec {
          pname = "k3d";
          version = "5.8.3";

          src = fetchFromGitHub {
            owner = "k3d-io";
            repo = "k3d";
            rev = "v${version}";
            # You'll need to replace this hash
            hash = "sha256-UBiDDZf/UtgPGRV9WUnoC32wc64nthBpBheEYOTp6Hk=";
          };

          vendorHash = null;

          # Comprehensive version injection
          ldflags = [
            "-s" # strip debugging symbols
            "-w" # omit DWARF symbol table
            "-X" # inject version information
            "github.com/k3d-io/k3d/v5/version.Version=v${version}"
            "-X"
            "github.com/k3d-io/k3d/v5/version.RuntimeData=nix"
          ];

          doCheck = true;
          subPackages = [ "." ];

          meta = with lib; {
            description = "K3d - A lightweight wrapper to run k3s in docker";
            homepage = "https://k3d.io/";
            license = licenses.mit;
            platforms = platforms.unix;
          };
        }) {};

      description = "K3d package to use";
    };
  };

  # Configuration when the module is enabled
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
