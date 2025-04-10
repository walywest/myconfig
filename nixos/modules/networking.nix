{

  networking.hostName = "nixos"; # Define your hostname.
    networking.hosts = {
      "192.168.56.110" = ["app2.com" "app1.com" "app3.com" "app4.com"];
        "127.0.0.1" = [ "gitlab.example.com" ];
    };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking

  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 6443 1021];
  # networking.firewall.allowedUDPPorts = [ 6443 8080 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

}
