{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./home.nix
    ./desktop.nix
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs; [
      obs-studio-plugins.wlrobs
      obs-studio-plugins.obs-vaapi
      obs-studio-plugins.obs-pipewire-audio-capture
    ];
  };

  home.packages = with pkgs; [
    stable.calibre
  ];
}
