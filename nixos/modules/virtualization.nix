{config, pkgs, ...}:
{

    virtualisation.docker.enable = true;
# NOTE:  to clearly see where docker stores its crap
# docker home-manager
#   virtualisation.docker.rootless = {
#   	enable = true;
#   	setSocketVariable = true;
# 	data-root = "~/Desktop/docker-data/";
# };

  # environment.systemPackages = with pkgs; [
  #       docker
  #   ]
   #NOTE: VirtualBox- ->>
   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.vboxusers.members = [ "Dumbledoor" ];
   # NOTE: kvm is not compatible with Vbox at this kernel version 6.12.13
   boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

}
