({
  pkgs,
  pkgs-stable,
  config,
  inputs,
  ...
}: {
  hardware.bluetooth = {
    enable = true;
    package = pkgs-stable.bluez;
    powerOnBoot = true;
  };

  environment.systemPackages = [
    inputs.devenv.packages.${pkgs.system}.default
  ];
})
