# fancy stuff
export PS1="☕ \$ "

# add to path and prioritize: local scripts, dotnet tools
export PATH=/home/shardion/.local/bin:/home/shardion/.dotnet/tools:$PATH

# welcome to the future
export SDL_VIDEODRIVER=wayland
export SDL_AUDIODRIVER=pipewire

# cruft that shouldn't be necessary but it is
export GPG_TTY=$(tty)
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# accursed unutterable hacks
export DOTNET_ROOT=$(dirname $(dirname $(readlink $(whereis dotnet))))
