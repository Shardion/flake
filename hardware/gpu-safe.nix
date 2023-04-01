{ lib, config, pkgs, inputs, ... }:

{
  imports = [
    ./gpu.nix
  ];

  # Enable no optimizations whatsoever
  # Tries to be as safe as possible

  # TODO: force software rendering
}
