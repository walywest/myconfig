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

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Use KDE's portal for better Plasma integration
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
    config.common.default = "kde";
  };

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-gtk # Works with most Wayland compositors
  #     pkgs.xdg-desktop-portal-wlr
  #   ];
  # };

  environment.etc."xdg/kwinrc".text = ''
    [Effect-zoom]
    Enabled=true
  '';
}
