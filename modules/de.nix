{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  # environment.systemPackages = with pkgs; [
  #   #NOTE: ZOOMING TOOLS

  # kdePackages.kwin
  # kdePackages.plasma-desktop
  # ];

  # KDE Plasma disabled - using GNOME as primary DE
  # services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;

  # GNOME Desktop Environment (currently active)
  services.xserver.enable = true;  # Required for GNOME
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.defaultSession = "gnome";  # Make GNOME default
  services.desktopManager.gnome.enable = true;
  # 
  # NOTE: To switch safely:
  # 1. Uncomment the 4 lines above
  # 2. Comment out SDDM: # services.displayManager.sddm.enable = true;
  # 3. Rebuild: sudo nixos-rebuild switch
  # 4. Reboot and choose GNOME at login screen
  # 5. To go back: reverse the process

  # SSH askPassword for GNOME
  programs.ssh.askPassword = lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";

  # Intel graphics configuration for stability
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # VAAPI driver for newer Intel GPUs
      intel-vaapi-driver # VAAPI driver for older Intel GPUs
      libvdpau-va-gl     # VDPAU driver
    ];
  };

  # XDG portal for GNOME (screen sharing, file dialogs, etc.)
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gnome];
    config.common.default = "gnome";
  };

}
