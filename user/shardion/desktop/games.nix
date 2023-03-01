{ config, pkgs, inputs, self, ... }:

{
  # All packages I use for gaming.

  home-manager.users.shardion.home.packages = [
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    (pkgs.grapejuice.override { wine = pkgs.wineWowPackages.stagingFull; })
    pkgs.wineWowPackages.stagingFull

#    pkgs.dwarf-fortress
#    pkgs.dwarf-fortress-packages.dwarf-therapist
#    pkgs.dwarf-fortress-packages.legends-browser
    pkgs.prismlauncher
  ];

  programs.steam.enable = true;
  programs.gamemode.enable = true;
}
