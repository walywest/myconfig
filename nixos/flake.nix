{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    devenv.url = "github:cachix/devenv/v1.6.1";
    rio.url = "github:raphamorim/rio/main";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
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
        ./configuration.nix
        ./flakes/bluetooth.nix
        ./flakes/chrome.nix
        # ./flakes/rio.nix
      ];
    };
  };
}
