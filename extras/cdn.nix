{ lib, config, pkgs, inputs, ... }:

{
  # It's only a CDN if you squint
  # Serves everything in /var/www/cdn at hostname.tail354c3.ts.net/cdn
  services.caddy = {
    enable = true;
    globalConfig = ''
      order file_server before reverse_proxy
    '';
    virtualHosts."${config.networking.hostName}.tail354c3.ts.net" = {
      extraConfig = ''
        file_server /cdn/* {
          root /var/www
        }
      '';
    };
  };
}