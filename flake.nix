{
  description = "shardion's NixOS configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    nix-gaming = {
      url = github:fufexan/nix-gaming;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nix-gaming, home-manager }: {
    nixosConfigurations.mocha = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./machines/mocha.nix
        ./hardware-configuration.nix
        inputs.nix-gaming.nixosModules.pipewireLowLatency
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
