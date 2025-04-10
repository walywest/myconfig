{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  outputs = { self, nixpkgs }@inputs: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.nixos= nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };  # This passes inputs to your modules
        modules = [ ./configuration.nix ];
    };
  };
}
