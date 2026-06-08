{
  config,
  pkgs,
  inputs,
  ...
}:
{
  programs.man.enable = true;
  home.packages = with pkgs; [
    neovim
    # #added this for man pages
    # docker
    # # localsend
    # #WINDOWS BOTTLES
    # bottles
    # #GAMING
    # steam-run-free
    # vscode-fhs
    # # heroic
    #
    # #Filesystem
    # xfce.thunar # File manager
    # udiskie # Automounter
    # exfat # exFAT support
    # polkit_gnome # Authentication agent for root access
    # # Filelight wrapper with proper display handling
    # (pkgs.writeShellScriptBin "filelight" ''
    #   exec pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY WAYLAND_DISPLAY=$WAYLAND_DISPLAY XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR ${pkgs.kdePackages.filelight}/bin/filelight "$@"
    # '')
    # # GParted wrapper with proper display handling
    # (pkgs.writeShellScriptBin "gparted" ''
    #   exec pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY WAYLAND_DISPLAY=$WAYLAND_DISPLAY XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR ${pkgs.gparted}/bin/gparted "$@"
    # '')
    #
    inputs.devenv.packages.${pkgs.system}.default
    # #Media
    # unrar
    # zathura
    libreoffice-qt-fresh
    #
    # # Audio
    # pipewire
    # pavucontrol
    # playerctl
    #
    # # System utilities
    # brightnessctl
    # networkmanagerapplet
    # libnotify
    # anydesk
    #
    # # Development tools
    # nixpkgs-fmt
    #
    # # Applications
    # nitch
    # rofi
    # pcmanfm

    # Custom scripts
    # (pkgs.writeShellApplication {
    #   name = "ns";
    #   runtimeInputs = with pkgs; [
    #     fzf
    #     (nix-search-tv.overrideAttrs {env.GOEXPERIMENT = "jsonv2";})
    #   ];
    #   text = ''exec "${pkgs.nix-search-tv.src}/nixpkgs.sh" "$@"'';
    # })
  ];
}
