{ lib, config, pkgs, inputs, ... }:

{
  imports = [
    ./gpu.nix
  ];

  # Enable optimizations for Nvidia graphics cards
  # I haven't used Nvidia cards in ages, so this is probably broken
  # !!! ASSUMES THE ONLY GPU IN THE SYSTEM IS THE NVIDIA GPU !!!

  # Force the Nvidia driver as the only driver available
  services.xserver.videoDrivers = [
    "nvidia"
  ];

  # Enable some hardware acceleration-related packages
  hardware.opengl.extraPackages = [
    pkgs.vaapiVdpau
    pkgs.libvdpau-va-gl
  ];
}
