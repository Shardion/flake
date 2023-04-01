{ lib, config, pkgs, inputs, ... }:

{
  # Enable battery optimizations
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  powerManagement.cpuFreqGovernor = "ondemand";
}
