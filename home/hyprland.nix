{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable Hyprland window manager (for the systemd session target + portal wiring).
  wayland.windowManager.hyprland = {enable = true;};

  # We manage the Hyprland config ourselves via the linked ../config/hypr directory
  # (hand-written hyprland.lua for 0.55+). Stop the home-manager module from also
  # writing its own legacy hyprland.conf, which would collide with the directory
  # symlink below and fail with "installing file ... outside $HOME".
  xdg.configFile."hypr/hyprland.conf".enable = lib.mkForce false;

  # Terminal emulator
  programs.kitty.enable = true;

  # Link Hyprland config files
  home.file.".config/hypr".source = ../config/hypr;
  home.file.".config/foot".source = ../config/foot;
  home.file.".config/waybar".source = ../config/waybar;
}
