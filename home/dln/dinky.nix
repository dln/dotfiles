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

  home.packages = with pkgs; [
    stable.calibre
  ];

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
  };
}
