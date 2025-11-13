{ config, pkgs, ... }:
{
  services.dunst.enable = true; # optional: for notifications
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;  # or enableZshIntegration, enableFishIntegration, etc.
  };

  home.packages = with pkgs; [
        pipewire        # includes wpctl binary in recent Nixpkgs
        pavucontrol     # audio GUI
        playerctl       # media keys control
        brightnessctl   # optional, brightness control
        networkmanagerapplet  # nm-applet for network management
        libnotify       # provides notify-send for notifications

    nixpkgs-fmt
    nitch
    rofi
    pcmanfm
    (pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        (nix-search-tv.overrideAttrs {
          env.GOEXPERIMENT = "jsonv2";
        })
      ];
      text = ''exec "${pkgs.nix-search-tv.src}/nixpkgs.sh" "$@"'';
    })
  ];

  programs.kitty.enable = true; # required for the default Hyprland config
  wayland.windowManager.hyprland = {
    enable = true;
  };

  home.username = "albus";
  home.homeDirectory = "/home/albus";


  # Enable bash (keep it as fallback and for Hyprland autostart)
  programs.bash = {
    enable = true;
    
    # The 'profileExtra' section - critical for Hyprland autostart
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec hyprland
      fi
    '';
  };

  # Enable and configure zsh as primary shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Aliases
    shellAliases = {
      re = "sudo nixos-rebuild switch --flake .";
      nixgc = "sudo nix-collect-garbage -d";
      nv = "nvim .";
      ed = "cd /home/albus/Desktop/nix-config/ && nvim .";
      conf = "cd /home/albus/Desktop/nix-config";
      x = "exit";
    };

    # Oh My Zsh configuration
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" "docker" "kubectl" ];
    };

    # Autostart Hyprland on TTY1 login
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec Hyprland
      fi
    '';

    # Additional zsh configuration
    initExtra = ''
      # History settings
      HISTSIZE=10000
      SAVEHIST=10000
      setopt SHARE_HISTORY
      
      # Better completion
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
    '';
  };


  #NOTE: HYPRLAND
  home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/foot".source = ./config/foot;
  home.file.".config/waybar".source = ./config/waybar;
  home.stateVersion = "25.05";

}



#   # --- Network ---
#   # Requires system NetworkManager to be enabled in configuration.nix:
#   # networking.networkmanager.enable = true;
#
#   # --- Bluetooth ---
#   services.blueman-applet.enable = true;
#   # Requires system Bluetooth in configuration.nix:
#   # hardware.bluetooth.enable = true;
#
#   # --- System Tray + Widgets ---
#   programs.waybar = {
#     enable = true;
#     settings = {
#       mainBar = {
#         layer = "top";
#         position = "top";
#         modules-left = [ "hyprland/workspaces" ];
#         modules-center = [ ];
#         modules-right = [ "network" "bluetooth" "pulseaudio" "battery" "clock" ];
#
#         "network" = {
#           format-wifi = "  {essid}";
#           format-ethernet = "󰈁  {ifname}";
#           format-disconnected = "󰤭  Disconnected";
#           tooltip = true;
#         };
#
#         "bluetooth" = {
#           format = " {status}";
#           tooltip = true;
#         };
#
#         "pulseaudio" = {
#           format = "{icon} {volume}%";
#           format-icons = [ "" "" "" ];
#           on-click = "pavucontrol";
#         };
#
#         "battery" = {
#           format = "{icon} {capacity}%";
#         };
#
#         "clock" = {
#           format = "{:%a %H:%M}";
#         };
#       };
#     };
#     style = ''
#       * {
#         font-family: "JetBrainsMono Nerd Font", monospace;
#         font-size: 12px;
#       }
#     '';
#   };
#
#   # --- Hyprland autostarts ---
#   wayland.windowManager.hyprland = {
#     enable = true;
#     settings = {
#       exec-once = [
#         "waybar"
#         "nm-applet"
#         "blueman-applet"
#       ];
#     };
#   };
#
#   # --- Volume & Brightness Keys ---
#   # Using Hyprland's own keybindings
#   wayland.windowManager.hyprland.extraConfig = ''
#     bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
#     bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
#     bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
#
#     bind = , XF86MonBrightnessUp, exec, brightnessctl set +5%
#     bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
#   '';
# }
