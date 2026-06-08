{ config, pkgs, ... }:

{
  services.nix-serve = {
    enable = false;
    # If you want the faster version (recommended):
    package = pkgs.nix-serve-ng; 
    secretKeyFile = "/var/cache-priv-key.pem";
  };

  # Open the default port 5000 in the firewall
  # networking.firewall.allowedTCPPorts = [ 5000 ];
}
