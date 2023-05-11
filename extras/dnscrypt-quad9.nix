{ lib, config, pkgs, inputs, ... }:

# NOTE: A strange issue with this file exists;
# systems can lose internet access seemingly randomly.
# This is fine for systems that can restart at nearly any time, like Mocha,
# but ends up inconvenient for those that can't, like Tama.
# For those systems, a separate file is provided that still routes all DNS
# requests through Quad9, but does so insecurely, avoiding trouble with
# dnscrypt-proxy. Of course, there is an obvious downside to that method.

{
  networking = {
    nameservers = [
      "::1"
    ];
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
}