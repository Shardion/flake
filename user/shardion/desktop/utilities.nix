{ lib, config, pkgs, inputs, ... }:

{
  # All packages I use *indirectly* that didn't fit into `productivity` or `games`.

  home-manager.users.shardion.home.packages = [
    pkgs.appimage-run
    pkgs.hunspell
  ];
}
