{ config, lib, pkgs, inputs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        ./git.nix
        ./cachix.nix
        ./fonts.nix
        ./window_sys.nix
        ./fhs.nix
        ./networking.nix
        ./kubernetes.nix
        ./local.nix
        ./virtualization.nix
        ./sh.nix
        ./scripts.nix
        ./custom_k3d.nix
        ./custom_helm.nix
        ./nixd.nix
        ./giming.nix
        ./postgresql.nix
        ./java.nix
        ./dev_env.nix
        ./appImageSupport.nix
        # ./safety.nix
        ];
}
