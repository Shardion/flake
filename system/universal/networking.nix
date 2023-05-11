{ lib, config, pkgs, inputs, ... }:

{
  networking = {
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
}
