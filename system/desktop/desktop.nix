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

  # Sound with PipeWire (feat. low-latency)
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true; # Needed for BASS, notably used by osu!lazer
    lowLatency.enable = true;
  };
  security.rtkit.enable = true;

  # Graphics tablets
  services.xserver.wacom.enable = true;
  services.udev.packages = [ pkgs.opentabletdriver ]; # OTD udev rules, so applications can take over the tablet
}
