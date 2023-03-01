{ lib, config, pkgs, inputs, ... }:

{
  # Enable some system-wide utilities

  # Packages that can be installed directly
  environment.systemPackages = with pkgs; [
    vim # I use Helix normally, but I can use Vim in a pinch, and it works a little better than nano
    git # Sometimes you need to clone repos as root
  ];

  # Packages behind a setting
  security.sudo.enable = false; # Disable sudo
  security.doas.enable = true;  # doas
  security.doas.extraRules = [ 
    { groups = [ "doas" ]; noPass = false; }
  ];

  services.openssh.enable = true; # OpenSSH
  programs.gnupg.agent.enable = true; # GnuPG

}
