{ lib, config, pkgs, inputs, ... }:

{
  # All packages I use for development or artwork, among other things.
  # As I write this, I realize I am not very productive.

  home-manager.users.shardion = {
    programs.git = {
      enable = true;
      userEmail = "22127191+Shardion@users.noreply.github.com";
      userName = "Shardion";
      signing = {
        key = "EA3D1FC9BCA5E338";
        signByDefault = true;
      };
    };
    programs.git.lfs.enable = true;
    programs.gh.enable = true;
    home.packages = [
      (with pkgs.dotnetCorePackages; combinePackages [
        sdk_7_0
        sdk_6_0
      ])
      pkgs.omnisharp-roslyn
      pkgs.msbuild
      pkgs.helix

      pkgs.krita
      pkgs.apostrophe
    ];
  };
}
