{ lib, config, pkgs, inputs, ... }:

{ 
  services.xserver.layout = "us";
  console = {
    keyMap = "us";
  };
}
