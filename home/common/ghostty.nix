{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.shelman.desktop.enable {

    home.packages = with pkgs; [ inputs.ghostty.packages.${pkgs.system}.default ];

    programs.ghostty = {
      enable = true;
      settings = {
        font-size = 14;
        font-family = "BerkeleyMono Nerd Font";
        font-feature = [
          # "ss02", -- Clean zero
          "ss03" # Slashed zero
          # "ss04", -- Cut zero
        ];

        mouse-hide-while-typing = true;
        cursor-style = "block";
        adjust-cursor-thickness = 5;

        shell-integration = "fish";

        window-decoration = true;
        gtk-tabs-location = "bottom";
        window-padding-x = 4;
        window-padding-y = 4;
        window-padding-balance = true;
        window-padding-color = "extend";

        window-theme = "system";

        unfocused-split-opacity = 1.0;

        background = "#fefeff";
        foreground = "#222222";
        cursor-color = "#aa0000";
        selection-background = "#ffe6a4";
        selection-foreground = "#483600";
        palette = [
          "0=#000000"
          "1=#9e001d"
          "2=#306300"
          "3=#deae00"
          "4=#00669e"
          "5=#7d009e"
          "6=#008a9e"
          "7=#f7f7f7"
          "8=#000000"
          "9=#ff0035"
          "10=#509e00"
          "11=#ffc900"
          "12=#00a7ff"
          "13=#cb01ff"
          "14=#00e0ff"
          "15=#ffffff"
        ];

        keybind = [
          "alt+shift+c=copy_from_clipboard"
          "alt+shift+v=paste_from_clipboard"
          "ctrl+tab=goto_split:previous"
          "ctrl+enter=toggle_split_zoom"
          "alt+enter=toggle_fullscreen"
        ];
      };
    };
  };
}
