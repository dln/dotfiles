{ config, lib, ... }:
{
  config = lib.mkIf config.patagia.desktop.enable {

    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./../../files/config/wezterm/wezterm.lua;
    };

  };
}
