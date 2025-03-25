{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kubectl
  ];

#NOTE: server
    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [ 6443 ];
    networking.firewall.allowedUDPPorts = [ 6443 8080 ];
    services.k3s = {
        enable = false;
        role = "server";
        extraFlags = [
            "--node-ip=192.168.1.9" 
        ];
    };
}
