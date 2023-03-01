{ lib, config, pkgs, inputs, ... }:

{
  # Disable touchpad tap-to-click
  services.xserver.libinput.touchpad.tapping = false;
}
