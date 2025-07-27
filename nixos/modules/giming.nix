# This is a modular configuration for gaming on NixOS using flakes
# Add this to your flake.nix inputs:
#
# inputs = {
#   # Your existing inputs...
#   nix-gaming.url = "github:fufexan/nix-gaming";
# };
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  # Enable 32-bit libraries for games
  # This is crucial for many games, especially those run through Wine/Proton
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;

    # Enable Vulkan support
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];

    # 32-bit support for Vulkan
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vulkan-loader
    ];
  };

  # Enable Steam with Proton
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Steam Dedicated Server
  };
  #NOTE: CONTROLLER DUALSHOCK 4
  hardware.steam-hardware.enable = true;
  services.udev.extraRules = ''
    # DualShock 4 over USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0666"
    # DualShock 4 over bluetooth
    KERNEL=="hidraw*", KERNELS=="*054C:05C4*", MODE="0666"
  '';

  # Install essential gaming tools and libraries
  environment.systemPackages = with pkgs; [
    # Wine and Wine dependencies
    wineWowPackages.stable
    winetricks

    # Gaming platforms and tools
    lutris
    gamemode # Optimizes system performance for gaming
    mangohud # Performance overlay

    # Libraries and dependencies
    giflib
    libpng
    gnutls
    mpg123
    openal
    v4l-utils
    libpulseaudio
    libgpg-error
    libjpeg
    libv4l
    xorg.libXcomposite
    xorg.libXtst
    libGLU
    libpcap
    glib
    gtk3
    gtk4
    gdk-pixbuf
    cairo
    pango

    # Optional: Controllers support
    # inputs.nix-gaming.packages.${pkgs.system}.gamepad-tool
  ];

  # Optimize system for gaming
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10; # Lower value means higher priority
      };

      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high"; # For AMD GPUs
      };

      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };

  # Configure sound for gaming
  # sound.enable = true;

  # Optional: If you want to use nix-gaming's Wine-tkg
  # This provides a more optimized Wine build for gaming
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     wine-tkg = inputs.nix-gaming.packages.${prev.system}.wine-tkg;
  #   })
  # ];
}
