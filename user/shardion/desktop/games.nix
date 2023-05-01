{ config, pkgs, inputs, self, ... }:

{
  home-manager.users.shardion.home.packages = [
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    pkgs.dwarf-fortress
    pkgs.dwarf-fortress-packages.dwarf-therapist
    pkgs.prismlauncher
    pkgs.mindustry-wayland
  ];

  programs.steam.enable = true;
  programs.gamemode.enable = true;
}
