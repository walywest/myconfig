{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # vscodium
    # cargo
    devenv
    # boot entries listing
    efibootmgr
    # disk utilities
    gparted
    # bootable usb solution
    # ventoy-full
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
    #LSP
    # basedpyright
    # ruff-lsp
    #Linters
    # ruff
    # Languages
    zig
    python3
    lua
    luajitPackages.luarocks_bootstrap #luarocks in3lbo lismak sa3tayn wana kan9lb 3liha b9
    pnpm
    nodejs_24
    # SDKs for mobile dev
    # flutter327
    # android-studio
    #
    # recording
    obs-studio
    # browser
    brave
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
    # essential
    zoxide
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
    cmake
    gnumake
    # NOTE: DISK USAGE STATISTICS
    libsForQt5.filelight
    #NOTE: VMs images management/deployment/creation
    # vagrant
    packer
    # token generation
    openssl
    # testing
    postman
    #hardware listing
    dmidecode # BIOS/motherboard/RAM/CPU serials
    lshw # Hardware topology (JSON)
    inxi # Human-friendly summary
    util-linux # lsblk
    pciutils # lspci
    smartmontools # smartctl
    jq # JSON processing
    edid-decode # Decodes EDID (panel model/serial)
    xorg.xrandr # Screen resolution/refresh rate
    ddcutil # External monitor control (if supported)
    # database
    postgresql
    pgadmin4-desktopmode
    #Community Cached Binaries
    # cachix
  ];
}
