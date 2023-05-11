{ lib, config, pkgs, inputs, ... }:

{
  services.tailscale.enable = true;

  networking = {
    nameservers = [
      "100.100.100.100"
    ];
    search = [
      "tail354c3.ts.net"
    ];
    firewall = {
      trustedInterfaces = [ "tailscale0" ];
    };

    # resolvconf support
    resolvconf = {
      extraConfig = ''
        name_servers='100.100.100.100'
      '';
    };

    # NetworkManager support
    networkmanager = {
      insertNameservers = [ "100.100.100.100" ];
    };
  };

  # Allow Caddy to ask for certificates from Tailscale
  systemd.services.tailscaled = {
    serviceConfig.Environment = [ "TS_PERMIT_CERT_UID=caddy" ];
  };
}