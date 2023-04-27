{ lib, config, pkgs, inputs, ... }:

{
  # Set up Tailscale
  services.tailscale.enable = true;

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
    useDHCP = false;
    resolvconf = {
      useLocalResolver = true;
    };
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      require_dnssec = true;
      require_nolog = true;
      require_nofilter = false;

      listen_addresses = ["[::1]:53" "127.0.0.1:53"];
      bootstrap_resolvers = ["[2620:fe::11]:53" "[2620:fe::fe:11]:53" "9.9.9.9:53" "149.112.112.11:53"];
      netprobe_address = "9.9.9.9:53";

      sources.quad9-resolvers = {
        urls = ["https://www.quad9.net/quad9-resolvers.md"];
        minisign_key = "RWQBphd2+f6eiAqBsvDZEBXBGHQBJfeG6G+wJPPKxCZMoEQYpmoysKUN";
        cache_file = "/tmp/quad9-resolvers.md";
        prefix = "quad9-";
      };
    };
  };
}
