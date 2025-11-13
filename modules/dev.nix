{config, pkgs, ...}: 
{

  environment.systemPackages = with pkgs; [
        neovide
        lsof
        code-cursor-fhs
        kiro-fhs
        man-pages
        cargo
        go
        swayimg
    ];
}
