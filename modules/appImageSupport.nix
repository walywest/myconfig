{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pkgs.appimage-run
  ];
  programs.appimage.binfmt = true;
}
