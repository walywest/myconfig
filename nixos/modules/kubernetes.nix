{pkgs, ... }:
{
  # kubernetes
  services.kubernetes.roles = ["master" "node"];
  services.kubernetes.masterAddress = "localhost";
  # services.kubernetes.apiserver.insecurePort = 8080;
  environment.systemPackages = with pkgs; [
        kubectl
    ];
}
