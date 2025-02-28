{ config, pkgs, ... }:
{
  # resolve master hostname

  # packages for administration tasks
  environment.systemPackages = with pkgs; [
    kubectl
    # cri-o
  ];

  services.kubernetes = {
    # roles = ["master" "node"];
    # roles = ["master"];
    masterAddress = "localhost";
  };
}
