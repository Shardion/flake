{ lib, config, pkgs, inputs, ... }:

{
  # All packages I use directly that didn't fit into `productivity` or `games`.

  home-manager.users.shardion.home.packages = with pkgs; [
    newsflash
    seafile-client
    wl-clipboard
    celluloid
    keepassxc
    yt-dlp
    fortune
    lolcat
    discord-ptb
    ffmpeg
    tilix
    imgbrd-grabber
    gnomeExtensions.thinkpad-battery-threshold
    gnomeExtensions.bluetooth-battery
    gnomeExtensions.bluetooth-quick-connect
    protonvpn-cli
  ];

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
  programs.firefox = { # Librewolf for Wayland + extensions
    enable = true;
    package = pkgs.librewolf-wayland;
    policies = {
      ExtensionSettings = {
        # uBO isn't here because LibreWolf installs it automatically.

        # KeePassXC Firefox integration
        "keepassxc-browser@keepassxc.org" = {
          "installation_mode" = "force_installed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/file/4023682/keepassxc_browser-1.8.3.1.xpi";
        };
        # Modrinthify
        "{5183707f-8a46-4092-8c1f-e4515bcebbad}" = {
          "installation_mode" = "force_installed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/file/4004840/modrinthify-1.5.1.1.xpi";
        };
        # Privacy Redirect
        "{b7f9d2cd-d772-4302-8c3f-eb941af36f76}" = {
          "installation_mode" = "force_installed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/file/3815058/privacy_redirect-1.1.49.xpi";
        };
        # ClearURLs
        "{74145f27-f039-47ce-a470-a662b129930a}" = {
          "installation_mode" = "force_installed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/file/3980848/clearurls-1.25.0.xpi";
        };
      };
    };
  };
}
