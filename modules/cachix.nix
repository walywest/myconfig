# Add to your configuration.nix or as a separate module
{...}: {
  nix.settings = {
    # Binary substituters (where to download pre-built packages)
    substituters = [
      "https://cache.nixos.org/" # Official NixOS cache
      "https://nix-community.cachix.org" # Community packages
    ];

    # Corresponding public keys for signature verification
    trusted-public-keys = [
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    # Allow these users to add more substituters at runtime
    trusted-users = ["root"];

  };
}
