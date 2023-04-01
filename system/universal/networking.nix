{ lib, config, pkgs, inputs, ... }:

{
  # Set up Tailscale
  services.tailscale.enable = true;

  services.resolved = {
    enable = true;
    domains = [ "tail354c3.ts.net" ];
  };

  networking = {
    nameservers = [
      "100.100.100.100"
      "::1"
      "127.0.0.1"
    ];
    search = [
      "tail354c3.ts.net"
    ];
    firewall = {
      trustedInterfaces = [ "tailscale0" ];
    };
    dhcpcd.extraConfig = "nohook resolv.conf";
    useDHCP = false;
  };

  # Set up system-wide DNS encryption
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;
      require_nolog = true;
      require_nofilter = false;
      server_names = [ 
        "quad9-dnscrypt-ip4-filter-pri"
        "quad9-dnscrypt-ip4-filter-alt"
        "quad9-dnscrypt-ip4-filter-alt2"
        "quad9-dnscrypt-ip6-filter-pri"
        "quad9-dnscrypt-ip6-filter-alt"
        "quad9-dnscrypt-ip6-filter-alt2"
      ];

      sources.quad9-resolvers = {
        urls = [
          "https://www.quad9.net/quad9-resolvers.md"
          "https://raw.githubusercontent.com/Quad9DNS/dnscrypt-settings/main/dnscrypt/quad9-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy/quad9-resolvers.md";
        minisign_key = "RWQBphd2+f6eiAqBsvDZEBXBGHQBJfeG6G+wJPPKxCZMoEQYpmoysKUN";
        prefix = "quad9-";
        refresh_delay = 72;
      };

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
    };
  };
}
