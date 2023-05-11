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

    # NOTE: This option is deprecated, and set to false out of necessity;
    # DHCP is instead set individually for each interface in its relevant `machines/` configuration.
    useDHCP = false;
  };

  # Configure some general Caddy settings
  # Does not enable Caddy
  services.caddy = {
    virtualHosts."${config.networking.hostName}.tail354c3.ts.net" = {
      extraConfig = ''
        encode zstd gzip
      '';
    };
  };

  # Allow Caddy to ask for certificates from Tailscale
  systemd.services.tailscaled = {
    serviceConfig.Environment = [ "TS_PERMIT_CERT_UID=caddy" ];
  };
}
