{ lib, config, pkgs, inputs, ... }:

# This is a plate of networking spaghetti. It menaces with spikes of DNS.

# This file sets up Tailscale MagicDNS to handle all DNS requests for machines in your tailnet,
# and dnscrypt-proxy2 to handle all DNS requests for the public internet.
# All DNS requests to dnscrypt-proxy2 are encrypted with
# DNSCrypt and forwarded to Quad9's DNS servers.

# All of this is done without systemd-resolved, due to it having connection
# leak issues in my experiences.

# Non-obvious things:
# - tailscaled sets up a local DNS server at `100.100.100.100`.
#   This DNS server handles any requests for a domain name in your tailnet,
#   e.g. `mocha.tail354c3.ts.net`. If a domain name not in your tailnet is requested,
#   e.g. `google.com`, then it silently forwards the request to
#   the next nameserver in `networking.nameservers`, which is very much non-obvious.
#   I have no clue how it does this.
# 
# - resolvconf, for some confusing reason, refuses to add `100.100.100.100` to the list of
#   nameservers if you add `::1` and `127.0.0.1`. Thankfully, due to the above non-obvious thing,
#   this is fine, as we can simply add only `100.100.100.100`.

{
  services.tailscale.enable = true;

  networking = {
    nameservers = [
      "100.100.100.100"
      "::1"
    ];
    search = [
      "tail354c3.ts.net"
    ];
    firewall = {
      trustedInterfaces = [ "tailscale0" ];
    };

    resolvconf = {
      enable = true;
      extraConfig = ''
        name_servers='100.100.100.100'
      '';
    };

    # I am unsure if this is needed, but I am too scared to remove it.
    networkmanager = {
      enable = true;
      insertNameservers = [ "100.100.100.100" ];
    };

    # NOTE: This option is deprecated, and set to false out of necessity;
    # DHCP is instead set individually for each interface in its relevant `machines/` configuration.
    useDHCP = false;
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      # Some defaults are repeated here to protect them from changes that might reduce privacy,
      # e.g. a default address changing from Quad9 to Cloudflare.
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

  # Configure some general Caddy settings
  # Does not enable Caddy
  services.caddy = {
    virtualHosts."tama.tail354c3.ts.net" = {
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
