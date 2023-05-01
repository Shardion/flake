{
  lib,
  pkgs,
  fetchzip,
  makeDesktopItem,
  symlinkJoin,
  writeShellScriptBin,
  wine64 ? pkgs.wine64Packages.wayland,
  winePrefix ? "$HOME/.local/share/empire/wineprefixes/holocure",
  preCommands ? "",
  postCommands ? "",
  wrapperCommands ? "${pkgs.gamemode}/bin/gamemoderun"
}: let
  pname = "holocure";
  version = "0.5.1676587910";

  src = fetchzip {
    # This game is only available on itch.io, which requires an API key, and
    # thus would require a prohibitive amount of nix spaghetti to download
    # from automatically. Thus, Tama hosts the files for the latest version
    # of the game, which I manually update.
    url = "https://tama.tail354c3.ts.net/cdn/holocure-0.5.1676587910.zip";
    sha256 = lib.fakeSha256;
  };

  # This game doesn't use an installer, so we just store it directly in the
  # Nix store to acquire a warm, fuzzy feeling and save valuable /home space.
  script = writeShellScriptBin pname ''
    export WINEPREFIX="${winePrefix}"
    PATH=$PATH:${wine64}/bin
    
    if [ ! -d "$WINEPREFIX" ]; then
      mkdir -p $WINEPREFIX
    fi
    ${preCommands}
    pushd ${src}
    ${wrapperCommands + " "}wine64 HoloCure.exe;
    popd
    wineserver -w
    ${postCommands}
  '';

  desktopItems = makeDesktopItem {
    name = "HoloCure";
    exec = "${script}/bin/${pname}";
    desktopName = "HoloCure";
    categories = ["Game"];
  };
in
  symlinkJoin {
    name = pname;
    paths = [desktopItems script];

    meta = {
      description = pname;
      license = lib.licenses.unfree;
      platforms = with lib.platforms; ["x86_64-linux"];
    };
  }