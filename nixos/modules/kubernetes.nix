{ config, pkgs, ... }:
{
    networking.firewall.enable = true;
    # networking.firewall.allowedTCPPorts = [ 6443 ];
    # networking.firewall.allowedUDPPorts = [ 6443 8080 ];
    # options.services.k3d.enable = true;
    services.k3d.enable = true;
    environment.systemPackages = with pkgs; [
        kubectl
      ];
    services.k3s = {
        enable = false;
        role = "server";
        extraFlags = [
            "--node-ip=192.168.1.9" 
        ];
    };
}
