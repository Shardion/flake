{ lib, config, pkgs, inputs, ... }:

{
  home-manager.users.shardion = {
    programs.bash = {
      enable = true;
      enableVteIntegration = true;

      shellAliases = {
        loadtop = "ps xo pcpu,pmem,pid,command";
        login-fortune = "fortune 50% computers 50% linux";
      };

      sessionVariables = {
        # Hostname emoji - a script that returns an emoji which depends on the current hostname.
        # !!! CURSED HACK !!! Scripts loaded into env vars like this can't have any quotes in them.
        # FIXME: Figure out if there's a better way to do this.
        HOSTNAME_EMOJI = "$(eval '" + builtins.readFile ./hostname-emoji.sh + "')";

        # Use and prioritize local tooling, use dotnet tools if nothing else works.
        PATH = "/home/shardion/.local/bin:$PATH:/home/shardion/.dotnet/tools";

        # Embrace the future.
        SDL_VIDEODRIVER = "wayland";
        SDL_AUDIODRIVER = "pipewire";

        # I'm not sure if I still need these.
        DOTNET_ROOT = "$(dirname $(dirname $(readlink $(whereis dotnet))))";
        GPG_TTY = "$(tty)";

        # In a perfect world, we wouldn't need these.
        DOTNET_CLI_TELEMETRY_OPTOUT = 1;
      };

      initExtra = ''
        login-fortune
      '';
    };

    programs.starship = {
      enable = true;
      settings = {
        format = ''
          $env_var$nix_shell$git_branch$character
        '';
        env_var = {
          variable = "HOSTNAME_EMOJI";
          default = "❓";
          format = "$env_value ";
        };
        character = {
          success_symbol = "[\\$](green)";
          error_symbol = "[\\$](red)";
        };
        nix_shell = {
          format = "$symbol ";
          symbol = "❄️ ";
        };
        line_break.disabled = true;
      };
    };
  };
}
