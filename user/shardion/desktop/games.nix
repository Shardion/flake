{ config, pkgs, inputs, self, ... }:

{
  # All packages I use for gaming.

  home-manager.users.shardion.home.packages = [
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    pkgs.wineWowPackages.stagingFull # TODO: contribute some games to nix-gaming to remove this

    pkgs.dwarf-fortress
    pkgs.dwarf-fortress-packages.dwarf-therapist
    pkgs.prismlauncher
    pkgs.mindustry-wayland
  ];

  programs.steam.enable = true;
  programs.gamemode.enable = true;
}
