{ lib, config, pkgs, inputs, ... }:

{
  # All DE-independent desktop settings
  imports = [
    ../universal
  ];

  # Enable the X server
  services.xserver.enable = true;

  # Gvfs
  services.gvfs.enable = true;

  # Request the use of XDG portals
  xdg.portal.enable = true;

  # Sound with PipeWire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;

  # Graphics tablets
  services.xserver.wacom.enable = true;
  services.udev.packages = [ pkgs.opentabletdriver ]; # OTD udev rules, so applications can take over the tablet
}
