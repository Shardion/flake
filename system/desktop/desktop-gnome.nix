{ lib, config, pkgs, inputs, ... }:

{
  # A basic GNOME desktop.

  imports = [
    ./desktop.nix
  ];

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = [ pkgs.gnome.epiphany pkgs.gnome.cheese pkgs.gnome.gedit pkgs.gnome.gnome-music pkgs.orca pkgs.gnome.yelp pkgs.gnome.gnome-logs pkgs.gnome.evince pkgs.gnome.seahorse pkgs.gnome.simple-scan pkgs.gnome-connections pkgs.gnome.file-roller pkgs.gnome.gnome-font-viewer pkgs.gnome-tour pkgs.gnome.gnome-characters pkgs.gnome.gnome-maps pkgs.gnome.gnome-system-monitor pkgs.gnome.geary pkgs.gnome-console ];

  # For some reason this doesn't get enabled by default
  programs.dconf.enable = true;
}
