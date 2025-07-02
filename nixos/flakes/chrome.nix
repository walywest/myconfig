{
  pkgs,
  pkgs-stable,
  config,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    google-chrome
  ];
}
