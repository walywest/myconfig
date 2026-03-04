{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./shell.nix
    ./hyprland.nix
    ./packages.nix
    ./services.nix
    ./theming.nix
    ./xdg.nix
  ];
  programs.chromium.enable = true;
  home.sessionVariables.EDITOR = "nvim";
  home.sessionVariables.VISUAL = "nvim";
  home.sessionVariables.NIXOS_OZONE_WL = 1;
  home.sessionVariables.XDG_DATA_DIRS = "$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS";

  home.username = "dumbledoor";
  home.homeDirectory = "/home/dumbledoor";
  home.stateVersion = "25.05";
}
