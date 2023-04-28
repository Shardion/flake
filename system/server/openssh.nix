{ lib, config, pkgs, inputs, ... }:

{
  services.openssh = {
    enable = true;
    allowSFTP = true;
    settings = {
      X11Forwarding = false;
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      AllowTcpForwarding = false;
      AllowAgentForwarding = false;
      AllowStreamLocalForwarding = false;
      AuthenticationMethods = "publickey";
    };
  };
}