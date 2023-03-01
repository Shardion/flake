{ lib, config, pkgs, inputs, ... }:

{
  imports = [
    ./misc.nix
    ./networking.nix
    ./utilities.nix
    ./nix.nix
  ];
}
