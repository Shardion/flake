{ lib, config, pkgs, inputs, ... }:

{
  # Enable Intel microcode updates
  hardware.cpu.intel.updateMicrocode = true;
}
