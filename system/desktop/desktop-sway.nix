{ lib, config, pkgs, inputs, ... }:

{
  # An extremely minimal environment for running demanding games, such as... Minecraft?
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      st
      rofi
    ];
  };
}
