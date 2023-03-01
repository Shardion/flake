{ lib, config, pkgs, inputs, ... }:

{
  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluez;
}
