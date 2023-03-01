{ lib, config, pkgs, inputs, ... }:

{
  imports = [
    ./productivity.nix
    ./tools.nix
    ./utilities.nix
    ./games.nix
    ./shells.nix
  ];

  users.users.shardion = {
    description = "Shardion";
    isNormalUser = true;
    extraGroups = [ "doas" "audio" "video" "wheel" "networkmanager" ];
  };

  fonts.fonts = [
    (pkgs.nerdfonts.override { fonts = ["Hack" "Ubuntu" "UbuntuMono"]; })
  ];

  home-manager.users.shardion = {
    home.file."backgrounds" = {
      target = ".local/share/backgrounds";
      source = ../../../assets/backgrounds;
    };
  };
}
