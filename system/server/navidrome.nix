{ lib, config, pkgs, inputs, ... }:

{
  services.navidrome = {
    enable = true;
    settings = {
      Address = "::1";
      Port = 7271;
      MusicFolder = "/var/lib/navidrome/music";
      BaseUrl = "/navidrome";
      DefaultTheme = "Light";
      EnableExternalServices = false;
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