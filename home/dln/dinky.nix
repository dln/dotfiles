{ pkgs, ... }:
{
  imports = [
    ./home.nix
    ./desktop.nix
  ];

  patagia = {
    oled.enable = true;
  };

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [ "Battery-Health-Charging@maniacx.github.com" ];
    };
  };

  home.packages = with pkgs; [ ];

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
