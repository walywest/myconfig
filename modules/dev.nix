{ config, pkgs, inputs, ... }: {
  virtualisation.docker.enable = true;
  documentation.man.enable = true;
  documentation.dev.enable = true;
  environment.systemPackages = with pkgs; [
    #NOTE: special
    # unityhub
    # godotPackages_4_4.godot
    # nodejs_24
    uv
    neovide
    lsof
    # code-cursor-fhs
    # kiro-fhs
    # antigravity-fhs
    # man-pages
    cargo
    go
    # swayimg
  ];
}
