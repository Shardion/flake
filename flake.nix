{
  description = "shardion's NixOS configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
    nix-gaming = {
      url = github:fufexan/nix-gaming;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };



  outputs = inputs @ { self, nixpkgs, nixos-hardware, nix-gaming, home-manager }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ]; # The only systems I own
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
  {
    packages = forAllSystems (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in import ./packages { inherit inputs pkgs; }
    );

    nixosConfigurations.mocha = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./machines/mocha.nix
        ./hardware-configuration.nix
         home-manager.nixosModules.home-manager
         nix-gaming.nixosModules.pipewireLowLatency
      ];
    };
    nixosConfigurations.tama = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "aarch64-linux";
      modules = [
        ./machines/tama.nix
        # tama doesn't have hardware-configuration.nix
        nixos-hardware.nixosModules.raspberry-pi-4
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
