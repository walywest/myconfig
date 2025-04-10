{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = [
    pkgs.nixd
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  # ...
}
