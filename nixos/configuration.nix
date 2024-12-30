# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #AUTO-UPDATE
  system.autoUpgrade.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Casablanca";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ar_MA.UTF-8";
    LC_IDENTIFICATION = "ar_MA.UTF-8";
    LC_MEASUREMENT = "ar_MA.UTF-8";
    LC_MONETARY = "ar_MA.UTF-8";
    LC_NAME = "ar_MA.UTF-8";
    LC_NUMERIC = "ar_MA.UTF-8";
    LC_PAPER = "ar_MA.UTF-8";
    LC_TELEPHONE = "ar_MA.UTF-8";
    LC_TIME = "ar_MA.UTF-8";
  };

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
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

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

  # Install firefox.
  # programs.firefox.enable = true;
  # Enable linked libraries packages
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  	gtk3
	nss
	sqlite
	libstdcxx5
  ];
  #GIT
  programs.git = {
	enable = true;
	};

  # programs.appimage.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # environment.homeBinInPath = true;

  # Uncomment the next 2 lines if you're not using GNOME
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";


  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
  	pkgs.linux-router
  	vim
	unzip
	luajitPackages.luarocks_bootstrap #luarocks
	tree-sitter
	nodejs_23
	xclip
	python3
	gnumake
	gcc
	zig
  	wget
	neovim
	ripgrep
	lua
	alacritty
	libclang
	spotify
	pkgs.discord
	google-chrome
	zoxide
    	pkgs.plemoljp-nf # nerdfonts for neovim icons
	obsidian
	docker
	pkgs.foliate
  ];

# docker home-manager
#   virtualisation.docker.rootless = {
#   	enable = true;
#   	setSocketVariable = true;
# 	data-root = "~/Desktop/docker-data/";
# };


services.create_ap = {
  enable = true;
  settings = {
    INTERNET_IFACE = "eth0";
    WIFI_IFACE = "wlan0";
    SSID = "My Wifi Hotspot";
    PASSPHRASE = "12345678";
  };
};

  programs.zsh = {
	  enable = true;
	  enableCompletion = true;
	  autosuggestions.enable = true;
	  syntaxHighlighting.enable = true;
	  #initExtra = "eval '$(zoxide init zsh)'";

	  shellAliases = {
	    ll = "ls -l";
	    update = "sudo nixos-rebuild switch";
	    conf = "sudo nvim /etc/nixos/configuration.nix";
	    hardclean = "sudo nix-collect-garbage; sudo nix-collect-garbage -d; update";
	  };
	  histSize = 10000;
	  ohMyZsh = { enable = true; plugins = [ "git" ]; theme = "robbyrussell";
	  };
	};

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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}