{ config, pkgs, inputs, self, ... }:

{
  # Mocha, my Lenovo ThinkPad X250 laptop
  imports = [
    ../hardware/laptop.nix
    ../hardware/efi.nix
    ../hardware/gpu-intel.nix
    ../hardware/cpu-intel.nix
    ../hardware/keymap-us.nix

    ../system/desktop/desktop-gnome.nix
    ../specializations/openssh.nix

    ../user/shardion/desktop
  ];

  networking.hostName = "mocha";

  # These are unpredictable so I've just left them to machine config lol
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Remember to change this when reimaging
  system.stateVersion = "22.05";
  home-manager.users.shardion.home.stateVersion = "22.11";
}
