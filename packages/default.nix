{
  inputs,
  pkgs,
}: let
  inherit (pkgs) callPackage;
  packages = rec {
    holocure = callPackage ./holocure {};
  };
in
  packages
