{ lib, pkgs, ... }:
{
  imports = [
    ./home.nix
    ./desktop.nix
  ];

  # Host specific user config goes here
  #
  programs.ghostty.settings = {
    font-size = lib.mkForce 20;
  };

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [ "azclock@azclock.gitlab.com" ];
    };
  };

  home.packages = with pkgs; [ calibre ];
}
