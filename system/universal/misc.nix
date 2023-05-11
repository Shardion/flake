{ lib, config, pkgs, inputs, ... }:

{
  # Settings that didn't really fit into any other category

  # I live here
  time.timeZone = "America/Los_Angeles";

  # "Obey EarlyOOM, kill swap!"
  swapDevices = lib.mkForce [ ];
  services.earlyoom.enable = true;
  services.earlyoom.freeMemThreshold = 1;
  services.earlyoom.freeSwapThreshold = 1;

  # Garbage collect the Nix store every once in a while
  nix.gc.automatic = true;
  nix.gc.dates = "daily";

  # Disable webcam drivers (who needs tape (I probably do))
  boot.blacklistedKernelModules = [ "uvcvideo" "videodev" ];

  # Technically, this should be in `hardware`, but I don't know where I'd put it
  hardware.enableAllFirmware = true;
}
