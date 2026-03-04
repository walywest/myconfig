{
  description = "Hyperland + Home Manager";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv = {url = "github:cachix/devenv";};
    flatpaks.url = "github:gmodena/nix-flatpak/?ref=latest";

    # 1. Add the generator input
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    # Use 'extra' so you don't override the main NixOS cache
    extra-substituters = [
      # "http://192.168.1.33:5000"
      "https://devenv.cachix.org"
    ];
    extra-trusted-public-keys = [
      # "my-nix-cache-1:qi3NxfRFMznSZEGhHa3fihaD3szdPbIprXpFylvNFw4=%"
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    flatpaks,
    nixos-generators, # 2. Add to outputs arguments
    ...
  } @ inputs: {
    # Your existing system configuration
    nixosConfigurations.dumbledoor = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.dumbledoor.imports = [
              flatpaks.homeManagerModules.nix-flatpak
              ./flatpak.nix
              ./home/home.nix
            ];
            extraSpecialArgs = {inherit inputs;};
            backupFileExtension = "backup";
          };
        }
      ];
    };

    # 3. New Output: The ISO Generator
    packages.x86_64-linux = {
      iso = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        format = "install-iso";
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager

          # Your Home Manager config
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.dumbledoor.imports = [
                flatpaks.homeManagerModules.nix-flatpak
                ./flatpak.nix
                ./home/home.nix
              ];
              extraSpecialArgs = {inherit inputs;};
              backupFileExtension = "backup";
            };
          }

          # THE FIX IS HERE:
          ({
            pkgs,
            lib,
            ...
          }: {
            disabledModules = [./hardware-configuration.nix];

            # Use mkForce to override the default ISO settings
            networking.wireless.enable = lib.mkForce false;
            networking.networkmanager.enable = true;
          })
        ];
      };
    };
  };
}
