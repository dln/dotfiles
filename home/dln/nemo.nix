{ lib, pkgs, ... }:
{
  imports = [
    ./home.nix
    ./desktop.nix
  ];

  programs.ghostty.settings = {
    font-size = lib.mkForce 15;
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

  home.packages = with pkgs; [ stable.calibre ];

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableScDaemon = false;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
