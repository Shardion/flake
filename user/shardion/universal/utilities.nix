{ lib, config, pkgs, inputs, ... }:

{
  home-manager.users.shardion.home.packages = with pkgs; [
    fortune
  ];
}
