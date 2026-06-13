{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./common.nix
    ./personal.nix
    ./dev.nix
    ./nix.nix
    ./secrets.nix
    # ./cache-server.nix
    # ./giming.nix
    ./networking.nix
  ];
}
