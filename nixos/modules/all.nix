{ config, lib, pkgs, inputs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        ./networking.nix
        ./kubernetes.nix
        ./local.nix
        ./virtualization.nix
        ./sh.nix
        ./scripts.nix
        ./custom_k3d.nix
        ./custom_helm.nix
        ./nixd.nix
        ];
}
