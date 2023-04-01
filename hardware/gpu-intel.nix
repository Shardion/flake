{ lib, config, pkgs, inputs, ... }:

{
  imports = [
    ./gpu.nix
  ];

  # Enable optimizations for Intel integrated graphics >= Gen8
  # !!! ASSUMES THE ONLY GPU IN THE SYSTEM IS THE INTEL IGPU !!!

  # Force the modesetting driver as the only driver available
  services.xserver.videoDrivers = lib.mkForce [
    "modesetting"
  ];
  
  # Enable all manner of 3D acceleration-related packages
  hardware.opengl.extraPackages = [
    pkgs.mesa                  # iris OpenGL, Vulkan driver
    pkgs.intel-compute-runtime # Intel OpenCL driver
    pkgs.intel-media-driver    # Intel VAAPI driver
    pkgs.libvdpau-va-gl        # VDPAU with VAAPI and OpenGL fallback
  ];

  hardware.opengl.extraPackages32 = [
    pkgs.driversi686Linux.mesa
    pkgs.intel-compute-runtime # TODO: unsure if this does anything here
    pkgs.driversi686Linux.intel-media-driver
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

  # DANGER DANGER: kernel parameters
  boot.kernelParams = [
    "i915.enable_fbc=1"
  ];
}
