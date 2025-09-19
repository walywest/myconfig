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

})
