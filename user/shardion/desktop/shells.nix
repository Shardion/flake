{ lib, config, pkgs, inputs, ... }:

{
  home-manager.users.shardion = {
    programs.bash = {
      enableVteIntegration = true;

      sessionVariables = {
        # Use and prioritize local tooling, use dotnet tools if nothing else works.
        PATH = "/home/shardion/.local/bin:$PATH:/home/shardion/.dotnet/tools";

        # Embrace the future.
        SDL_VIDEODRIVER = "wayland";
        SDL_AUDIODRIVER = "pipewire";

        # I'm not sure if I still need these.
        DOTNET_ROOT = "$(dirname $(dirname $(readlink $(whereis dotnet))))";
        GPG_TTY = "$(tty)";
      };
    };
  };
}
