{ lib, config, pkgs, inputs, bootdevice, ... }:

{
  # GRUB2
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = bootdevice;
}
