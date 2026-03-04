{
  config,
  pkgs,
  ...
}: {
  # Enable Hyprland window manager
  wayland.windowManager.hyprland = {enable = true;};

  # Terminal emulator
  programs.kitty.enable = true;

  # Link Hyprland config files
  home.file.".config/hypr".source = ../config/hypr;
  home.file.".config/foot".source = ../config/foot;
  home.file.".config/waybar".source = ../config/waybar;
}
