{ lib, config, pkgs, inputs, ... }:

{
  services.miniflux = {
    enable = true;
    adminCredentialsFile = "/var/lib/miniflux/admin_credentials";
    config = {
      BASE_URL = "${config.networking.hostname}.tail354c3.ts.net/miniflux";
      LISTEN_ADDR = "[::1]:7272";
    };
  };

  # Configure Caddy to expose Navidrome
  services.caddy = {
    enable = true;
    virtualHosts."${config.networking.hostname}.tail354c3.ts.net" = {
      extraConfig = ''
        reverse_proxy /navidrome localhost:7271
      '';
    };
  };
}