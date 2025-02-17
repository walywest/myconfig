{config, pkgs, ...}:
{

    virtualisation.docker.enable = true;
# NOTE: I don't remember why i needed this, not using docker for the moment
# docker home-manager
#   virtualisation.docker.rootless = {
#   	enable = true;
#   	setSocketVariable = true;
# 	data-root = "~/Desktop/docker-data/";
# };

  # environment.systemPackages = with pkgs; [
  #       docker
  #   ]
}
