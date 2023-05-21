{ lib, config, pkgs, inputs, ... }:

{
  networking = {
    useDHCP = lib.mkDefault true;
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
