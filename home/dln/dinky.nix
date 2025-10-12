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
    beets
    essentia-extractor
    picard
    renameutils
    rsgain
    stable.calibre
    wrtag
  ];
}
