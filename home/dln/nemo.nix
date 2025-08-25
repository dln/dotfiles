{ lib, pkgs, ... }:
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

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [ "azclock@azclock.gitlab.com" ];
    };
  };

  home.packages = with pkgs; [
    endeavour
    picard
    stable.calibre
  ];

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableScDaemon = false;
    pinentry.package = pkgs.pinentry-curses;
  };
}
