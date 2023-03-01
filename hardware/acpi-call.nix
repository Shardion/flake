{ lib, config, pkgs, inputs, ... }:

{
  # To be honest, I have no idea what acpi_call does, but nixos-hardware says I should have it
  boot.kernelModules = [ "acpi_call" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
}
