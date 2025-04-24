{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11"; # Adjust version as needed
  };
  
  outputs = { self, nixpkgs, nixpkgs-stable }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { 
        inherit inputs; 
        # Pass stable pkgs for bluetooth
        pkgs-stable = import nixpkgs-stable {
          system = "x86_64-linux"; # Adjust if you use a different architecture
          config.allowUnfree = true; # Keep this if you need unfree packages
        };
      };
      modules = [ 
        ./configuration.nix
        # Add an overlay module to use stable bluetooth
        ({ pkgs, pkgs-stable, config, ... }: {
          # Replace bluetooth-related packages with stable versions
          hardware.bluetooth = {
            enable = true;
            package = pkgs-stable.bluez;
            powerOnBoot = true;
          };
          # You might need additional overrides depending on your setup:
        })
      ];
    };
  };
}
