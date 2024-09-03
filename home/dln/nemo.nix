{ lib, pkgs, ... }:
{
  imports = [
    ./home.nix
    ./desktop.nix
  ];

  # Host specific user config goes here
  #
  programs.ghostty.settings = {
    font-size = lib.mkForce 18;
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs; [
      obs-studio-plugins.wlrobs
      obs-studio-plugins.obs-vaapi
      obs-studio-plugins.obs-pipewire-audio-capture
    ];
  };

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [ "azclock@azclock.gitlab.com" ];
    };
  };

  home.packages = with pkgs; [ calibre ];
}
