{ lib, config, pkgs, inputs, ... }:

{
  # Enable hardware acceleration for graphics
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
}
