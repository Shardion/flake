{ lib, config, pkgs, inputs, ... }:

{
  imports = [
    ./gpu.nix
  ];

  # Enable optimizations for Intel integrated graphics
  # !!! ASSUMES THE ONLY GPU IN THE SYSTEM IS THE INTEL IGPU !!!

  # Force the modesetting driver as the only driver available
  services.xserver.videoDrivers = [
    "modesetting"
  ];
  
  # Enable all manner of 3D acceleration-related packages
  
  hardware.opengl.extraPackages = [
    pkgs.mesa
    pkgs.intel-media-driver
    pkgs.intel-compute-runtime
    pkgs.vaapiVdpau
    pkgs.libvdpau-va-gl
  ];

  hardware.opengl.extraPackages32 = [
    pkgs.driversi686Linux.mesa
    pkgs.driversi686Linux.intel-media-driver
    pkgs.intel-compute-runtime
    pkgs.driversi686Linux.vaapiVdpau
    pkgs.driversi686Linux.libvdpau-va-gl
  ];


  # Enable i915 at boot
  boot.initrd.kernelModules = [ "i915" ];

  # Set some environment variable that probably fix something, somewhere
  environment.variables = {
    VDPAU_DRIVER = "va_gl";
    LIBVA_DRIVER_NAME = "iHD";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/intel_hasvk_icd.x86_64.json";
  };
}
