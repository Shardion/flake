{ lib, config, pkgs, inputs, ... }:

{
  # Enable hardware acceleration for graphics
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  # Strange bug: default was bumped to `pkgs.mesa_23`, but `pkgs.mesa` refers to `pkgs.mesa_22`
  hardware.opengl.mesaPackage = pkgs.mesa;
}
