{ pkgs, ... }:
{
  imports = [
    ./home.nix
    ./desktop.nix
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [ "Battery-Health-Charging@maniacx.github.com" ];
    };
  };

  home.packages = with pkgs; [ calibre ];
}
