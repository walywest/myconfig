{
  config,
  pkgs,
  lib,
  ...
}: {
  fonts.packages = with pkgs; [
    # Main fonts
    fira-code
    jetbrains-mono

    # Nerd Fonts (individual packages)
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only # For fallback icons
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["FiraCode Nerd Font" "JetBrainsMono Nerd Font"];
    };
  };
}
