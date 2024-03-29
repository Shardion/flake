{ lib, config, pkgs, inputs, ... }:

{
  # All packages I use *indirectly* that didn't fit into `productivity` or `games`.

  home-manager.users.shardion.home.packages = with pkgs; [
    appimage-run # Only from scripts.
    hunspell     # Discord uses it.
    wl-clipboard # Helix uses it.
  ];
}
