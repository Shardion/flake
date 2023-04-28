{ lib, config, pkgs, inputs, ... }:

{
  imports = [
    ./utilities.nix
    ./shells.nix
  ];

  users.users.shardion = {
    description = "Shardion";
    isNormalUser = true;
    extraGroups = [ "doas" "wheel" ];
  };
}
