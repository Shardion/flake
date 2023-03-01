{ lib, config, pkgs, inputs, ... }:

{
  # Fingerprint reader
  services.fprintd.enable = true;
}
