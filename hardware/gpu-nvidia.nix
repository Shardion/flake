{ lib, config, pkgs, inputs, ... }:

{
  imports = [
    ./gpu.nix
  ];

  # Enable optimizations for Nvidia graphics cards
  # !!! ASSUMES THE ONLY GPU IN THE SYSTEM IS THE NVIDIA GPU !!!

  # Force the Nvidia driver as the only hardware-accelerated driver available
  services.xserver.videoDrivers = [
    "nvidia"
    "modesetting"
    "fbdev"
  ];

  # Enable some hardware acceleration-related packages
  hardware.opengl.extraPackages = [
    pkgs.vaapiVdpau
    pkgs.libvdpau-va-gl
  ];
}
