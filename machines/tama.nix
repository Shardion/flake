{ config, pkgs, inputs, self, ... }:

{
  # Tama, my Raspberry Pi 4B 8GB
  imports = [
    ../extras/openssh.nix
    ../extras/miniflux.nix
    ../extras/navidrome.nix
    ../extras/seafile-oci.nix
    ../extras/cdn.nix
    ../extras/tailscale.nix
    ../extras/insecure-quad9.nix
    ../system/universal

    ../user/shardion/universal
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking.hostName = "tama";

  # Nested containers are not supported on stateVersion = 22.11
  boot.enableContainers = false;

  system.stateVersion = "21.11";
  home-manager.users.shardion.home.stateVersion = "23.05";
}