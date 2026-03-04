{ config, pkgs, ... }: {
  #NOTE: BROWSER
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

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
      ed = "cd /home/dumbledoor/Desktop/nix-config/ && nvim .";
      conf = "cd /home/dumbledoor/Desktop/nix-config";
      x = "exit";

      docker-cleanup =
        "sudo docker stop $(sudo docker ps -aq) && sudo docker rm $(sudo docker ps -aq)";
      dex = "docker exec -it insurance-app-1 /bin/bash";
      dcu = "docker compose up -d";
      dcd = "docker compose down";
      dps = "docker ps";
      dpsa = "docker ps -a";
      dim = "docker images";
      dima = "docker images -a";
      docker-prune =
        "\ndocker container prune\ndocker image prune\ndocker network prune\n";
      docker-volumes = "docker volume ls";
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

  # Zoxide for smart directory jumping
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
}
