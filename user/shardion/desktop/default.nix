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
    home = {
      file."backgrounds" = {
        target = ".local/share/backgrounds";
        source = ../../../assets/backgrounds;
      };
      packages = [
        pkgs.adw-gtk3
        pkgs.adwaita-qt6
      ];
    };
    gtk.theme = {
      package = pkgs.adw-gtk3;
      theme = "Adw-gtk3";
    };
    qt.platformTheme = "gnome";
    qt.style = {
      package = pkgs.adwaita-qt6;
      name = "adwaita";
    };
  };
}
