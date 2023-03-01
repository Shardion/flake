{ lib, config, pkgs, inputs, ... }:

{
  # Enable battery optimizations
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  powerManagement.cpuFreqGovernor = "ondemand";

  environment.systemPackages = [
    powertop # Not sure if this is actually needed
  ];
}
