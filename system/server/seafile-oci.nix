{ lib, config, pkgs, inputs, ... }:

{
  # Runs Seafile in an OCI container
  # This is needed because... it's what I've always done, and I can't
  # be bothered to port my files over
  # Also, v10 is not packaged in nixpkgs

  virtualisation = {
    podman.enable = true;
    oci-containers.containers = {
      db = {
        imageFile = pkgs.dockerTools.pullImage {
          imageName = "mariadb";
          imageDigest = "sha256:ee4c6eb35613704d68beafb841543d5f42ef502edcba61e8476865f087a9ada8";
          sha256 = "1w3q8ikl2y7cb3r4w6m3jzvhs7ak44v9zdxbhr26yg06i3wi01f2";
          finalImageName = "shardion/seafile-mariadb";
          finalImageTag = "10.6";
        };
        image = "shardion/seafile-mariadb:10.6";
        environment = {
          MYSQL_LOG_CONSOLE = "true";
        };
        environmentFiles = [
          /var/lib/seafile-oci/.mariadb_env
        ];
        volumes = [
          "/var/lib/seafile-oci/mariadb/db:/var/lib/mysql"
        ];
        extraOptions = [ "--network=seafile-net" ];
      };

      memcached = {
        imageFile = pkgs.dockerTools.pullImage {
          imageName = "memcached";
          imageDigest = "sha256:3b3fc4d9c49fa284ed6816ea14d990d96187bef2a5fb0ec360e76f36d43c747a";
          sha256 = "16j2d5ya5xc2699k0bf7zri7asxh19kkhgyln0qr0y8m0jakip6g";
          finalImageName = "shardion/seafile-memcached";
          finalImageTag = "1.6.18";
        };
        image = "shardion/seafile-memcached:1.6.18";
        extraOptions = [ "--network=seafile-net" ];
      };

      
      seafile = {
        imageFile = pkgs.dockerTools.pullImage {
          imageName = "seafileltd/seafile-mc";
          imageDigest = "sha256:3fbf015c8998bc42fd436d05602520efbb12da14e53fb3b5caa6561928c32a7f";
          sha256 = "1nxgkcig71i8gvf4wnn7sfhda7c6d61wg7c8vcxgy4placiz6aii";
          finalImageName = "shardion/seafile";
          finalImageTag = "10.0.1";
        };
        image = "shardion/seafile:10.0.1";
        ports = [
          # Exposes container's port 80 to exclusively localhost on port 7270
          "127.0.0.1:7270:80"
        ];
        volumes = [
          "/var/lib/seafile-oci/seafile:/shared"
        ];
        environment = {
          DB_HOST = "db";
          TIME_ZONE = config.time.timeZone;
          # I don't have a public email, so you get a reference instead
          SEAFILE_ADMIN_EMAIL = "world.fr@gments.example";
          SEAFILE_SERVER_LETSENCRYPT = "false"; # HTTPS is handled by nginx
        };
        environmentFiles = [
          /var/lib/seafile-oci/.seafile_env
        ];
        dependsOn = [
          "memcached"
          "db"
        ];
        extraOptions = [ "--network=seafile-net" ];
      };
    };
  };

  # Configure Caddy to expose Seafile
  services.caddy = {
    enable = true;
    virtualHosts."${config.networking.hostName}.tail354c3.ts.net" = {
      extraConfig = ''
        reverse_proxy localhost:7270
      '';
    };
  };

  users = {
    groups = {
      seafile = {};
      seafile-mariadb = {};
      seafile-oci = {};
    };

    users."seafile" = {
      isSystemUser = true;
      group = "seafile";
      extraGroups = [ "seafile-oci" ];
    };
    users."seafile-mariadb" = {
      isSystemUser = true;
      group = "seafile-mariadb";
      extraGroups = [ "seafile-oci" ];
    };
  };
}
