{ config, pkgs, ... }:

{

  # 1. Enable the Ethernet interface with a static IP
  networking.interfaces.enp3s0.ipv4.addresses = [{
    address = "192.168.1.11";
    prefixLength = 24;
  }];

  # 2. Ensure the firewall is open for LocalSend
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];

  # 3. Optional: Prevent NixOS from waiting for online status on this port
  # (Useful if you boot without the cable plugged in)
  systemd.network.wait-online.enable = false;

}
