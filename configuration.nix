{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [./hardware-configuration.nix ./modules/includes.nix];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  #NOTE: auto-mount
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  
  security.polkit.enable = true;

  #FHS
  programs.nix-ld.enable = true;

  services.flatpak.enable = true;

  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  #BOOTLOADER
  #BOOTLOADER
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];

  #HYPRLAND
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable zsh system-wide
  programs.zsh.enable = true;
  networking.hostName = "dumbledoor";
  networking.networkmanager.enable = true;
  networking.nameservers = ["1.1.1.1" "8.8.8.8"];

  time.timeZone = "Africa/Casablanca";

  environment.shells = with pkgs; [bash zsh ];
  users.users.dumbledoor = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel" "networkmanager" "docker"];
  };
  services.blueman.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
