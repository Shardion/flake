{ lib, config, pkgs, inputs, ... }:

{
  # Nix configuration

  # Home Manager != Nix but this is the best spot I have
  home-manager.useUserPackages = true;

  # Allow non-free software. (Sorry, Richard.)
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes, the Nix command, and Cachix for the nix-gaming flake.
  nix = {
    package = pkgs.nixUnstable;
    settings = {
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
