{ pkgs, ... }:
{
  imports = [
    ./home.nix
    ./desktop.nix
  ];

  patagia = {
    laptop.enable = true;
    oled.enable = true;
  };

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [ "Battery-Health-Charging@maniacx.github.com" ];
    };
  };

  wayland.windowManager.sway.config.output = {
    eDP-1 = {
      scale = "2";
    };
  };

  home.packages = with pkgs; [ ];

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
