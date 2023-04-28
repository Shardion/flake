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
          sha256 = "sha256-q1tPjrjm+mI4uL1pg3g/Xn2nBBeWZ07YneWmtpIw7kI="; # changeme
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
          imageDigest = "sha256:9af8e788d5f7f4dc82fd49cf4a7efff1a0b5b4673085bc88f3ccb8a1c772ab3e";
          sha256 = "sha256-c4yzC2Kp8p7tmaC8xpTFqLe/hubeBxZkQ7znEuVnMMY="; # changeme
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
          sha256 = "16imi3l60b392jlmi499yz829cn01xxq60kxbfnjw0psk010p8fq"; # changeme
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
    virtualHosts."${config.networking.hostname}.tail354c3.ts.net" = {
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
