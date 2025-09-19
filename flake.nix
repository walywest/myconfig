{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    # devenv.url = "github:cachix/devenv/v1.6.1";
    # Browser previews flake for Chrome variants
    browser-previews = {
      url = "github:nix-community/browser-previews";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #NOTE: SNAPD
    nix-snapd.url = "github:nix-community/nix-snapd";
    nix-snapd.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    nix-snapd,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        pkgs-stable = import nixpkgs-stable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
      modules = [
        #NOTE: snapD
        nix-snapd.nixosModules.default
        {
          services.snap.enable = true;
        }
        ./configuration.nix
        ./flakes/bluetooth.nix
        ./flakes/chrome.nix
        # ./flakes/rio.nix
      ];
    };
  };
}
