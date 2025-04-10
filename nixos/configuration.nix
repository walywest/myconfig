# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, lib, pkgs, inputs, ... }:

{
  # services.k3s.enable = true;
  imports =
    [ # Include the results of the hardware scan.
      ./modules/all.nix
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  #AUTO-UPDATE
  system.autoUpgrade.enable = true;

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  # TODO:
  boot.loader = {
    timeout = 5;

    efi = {
      efiSysMountPoint = "/boot";
    };

    grub = {
      enable = true;
      
      efiSupport = true;
      efiInstallAsRemovable = true; # Otherwise /boot/EFI/BOOT/BOOTX64.EFI isn't generated
      devices = [ "nodev" ];
      extraEntriesBeforeNixOS = false;
      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
      '';
    };
  };
    #FIX:-----------

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

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
  
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.dumbledoor = {
    useDefaultShell = true;
    isNormalUser = true;
    description = "Dumbledoor";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kate
    #  thunderbird
    ];
  };
  programs.git = {
	enable = true;
	};

  # programs.appimage.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.homeBinInPath = true;
  programs.kdeconnect.enable = true;
  #Note: Another reason to use GNOME
  # Uncomment the next 2 lines if you're not using GNOME
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  # enable flatpack currently only using zen_browser package
  services.flatpak.enable = true;

  # NOTE: should i add this ?
  nix.settings.auto-optimise-store = true;

  environment.systemPackages = with pkgs; [


    # boot entries listing
    efibootmgr
    # disk utilities
    gparted
    # bootable usb solution
    ventoy-full
	# debugging and profiling
	valgrind
	# terminal filemanager
	yazi-unwrapped
	# cmd tools
	lsof
	porsmo
	libnotify
	fd # simple fast alternative to find
	eza # ls with steroids
	macchina
	tldr # Simplified community driven man pages
	bat # cat on steroid
	fzf # your local fuzzyfinder
	unzip
	zip
  	wget
	#Linters
	# Languages
	zig
	python3
	lua
	luajitPackages.luarocks_bootstrap #luarocks in3lbo lismak sa3tayn wana kan9lb 3liha b9
    pnpm
	nodejs_23
	# SDKs for mobile dev
	flutter327
	android-studio
	# 
	# recording
	obs-studio
	# browser
	brave
	google-chrome
	# security
	vulnix
	# Network
	# haskellPackages.hellnet
	# essential GUI apps
	telegram-desktop
	spotify
	discord
	foliate
	obsidian
	# terminals
	# blackbox
	alacritty
	ghostty
	# #FIX: Fonts
	plemoljp-nf # nerdfonts for neovim icons
	# nerd-fonts
	# Common
	zoxide
	# editors
	# zed-editor
	neovim
	# GUI for neovim
	neovide
	# needed by telescope
	ripgrep
	xclip
	tree-sitter
  	vim # not sure lol
	# Compilers and build tools
	clang
	gcc
    ninja
	#FIX: did not work
	# pkgconf
	cmake
	gnumake
    # NOTE: DISK USAGE STATISTICS
    libsForQt5.filelight
    #NOTE: VMs images management/deployment/creation
    vagrant
    packer
    # token generation
    openssl
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
#   services.create_ap = {
#   enable = true;
#   settings = {
#     INTERNET_IFACE = "eth0";
#     WIFI_IFACE = "wlan0";
#     SSID = "My Wifi Hotspot";
#     PASSPHRASE = "12345678";
#   };
# };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
