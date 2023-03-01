{ lib, config, pkgs, inputs, ... }:

{
  # Imports files for things that relatively recent laptops have
  imports = [
    ./acpi-call.nix
    ./bluetooth.nix
    ./fingerprint.nix
    ./battery.nix
  ];
}
