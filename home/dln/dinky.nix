{ lib, pkgs, ... }:
{
  imports = [
    ./home.nix
    ./desktop.nix
  ];

  patagia = {
    laptop.enable = true;
    oled.enable = true;
  };

  programs.helix.settings.theme = lib.mkForce "alabaster";
  programs.zellij.settings.theme = "iceberg-light";

  home.packages = with pkgs; [
    beets
    essentia-extractor
    picard
    renameutils
    rsgain
    stable.calibre
    wrtag
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs; [
      obs-studio-plugins.wlrobs
      obs-studio-plugins.obs-vaapi
      obs-studio-plugins.obs-pipewire-audio-capture
    ];
  };
}
