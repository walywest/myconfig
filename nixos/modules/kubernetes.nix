{ config, pkgs, ... }:
{
  # resolve master hostname

  # packages for administration tasks
  environment.systemPackages = with pkgs; [
    kubectl
  ];

  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = "localhost";
  };
}
