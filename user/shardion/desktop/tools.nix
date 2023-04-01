{ lib, config, pkgs, inputs, ... }:

{
  # All packages I use directly that didn't fit into `productivity` or `games`.

  home-manager.users.shardion.home.packages = with pkgs; [
    seafile-client
    keepassxc
    discord-ptb
    ffmpeg
    tilix
    imgbrd-grabber
    gnomeExtensions.thinkpad-battery-threshold
    gnomeExtensions.bluetooth-quick-connect
    gnomeExtensions.caffeine
    protonvpn-cli
  ];

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
  programs.firefox = { # Librewolf for Waylad
    enable = true;
    package = pkgs.librewolf-wayland;
  };
}
