{ lib, config, pkgs, inputs, ... }:

{ 
  services.xserver.layout = "us";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
}
