{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  launch-ghostty = pkgs.writeShellApplication {
    name = "launch-ghostty";
    text = ''
      if [ "$(gsettings get org.gnome.desktop.interface color-scheme)" = "'prefer-dark'" ]; then
        theme="theme_dark"
      else
        theme="theme_light"
      fi
      exec ghostty --config-file="$HOME/.config/ghostty/$theme" "$@"
    '';
  };
in
{
  config = lib.mkIf config.shelman.desktop.enable {

    home.packages = with pkgs; [
      inputs.ghostty.packages.${pkgs.system}.default
      launch-ghostty
    ];

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
        unfocused-split-opacity = 1.0;

        shell-integration = "fish";

        window-decoration = true;
        gtk-tabs-location = "bottom";
        window-padding-x = 12;
        window-padding-y = 0;
        window-padding-balance = true;
        window-padding-color = "extend";
        window-theme = "system";

        keybind = [
          "alt+shift+c=copy_from_clipboard"
          "alt+shift+v=paste_from_clipboard"
          "ctrl+tab=goto_split:previous"
          "alt+enter=toggle_fullscreen"
        ];
      };
    };

    xdg.configFile."ghostty/theme_dark".text = ''
      background = #0d1117
      foreground = #b2b2b2
      cursor-color = #00d992
      selection-background = #d7d7d7
      selection-foreground = #000000
      palette = 0=#000000
      palette = 1=#ff0035
      palette = 2=#85ff00
      palette = 3=#ffc900
      palette = 4=#00a7ff
      palette = 5=#cb01ff
      palette = 6=#00e0ff
      palette = 7=#f0f0f0
      palette = 8=#000000
      palette = 9=#ff8c88
      palette = 10=#baff94
      palette = 11=#ffe090
      palette = 12=#88ccff
      palette = 13=#e38dff
      palette = 14=#97eeff
      palette = 15=#ffffff
    '';

    xdg.configFile."ghostty/theme_light".text = ''
      background = #fefeff
      foreground = #222222
      cursor-color = #aa0000
      selection-background = #ffe6a4
      selection-foreground = #483600
      palette = 0=#000000
      palette = 1=#9e001d
      palette = 2=#306300
      palette = 3=#deae00
      palette = 4=#00669e
      palette = 5=#7d009e
      palette = 6=#008a9e
      palette = 7=#f7f7f7
      palette = 8=#000000
      palette = 9=#ff0035
      palette = 10=#509e00
      palette = 11=#ffc900
      palette = 12=#00a7ff
      palette = 13=#cb01ff
      palette = 14=#00e0ff
      palette = 15=#ffffff
    '';

    xdg.desktopEntries = {
      ghostty-local = {
        categories = [
          "System"
          "TerminalEmulator"
        ];
        exec = ''launch-ghostty --class=com.mitchellh.ghostty-local'';
        genericName = "Ghostty (local)";
        icon = "com.mitchellh.ghostty";
        name = "Ghostty (local)";
        settings = {
          StartupWMClass = "com.mitchellh.ghostty-local";
          TryExec = "launch-ghostty";
        };
        terminal = false;
        type = "Application";
      };

      ghostty-nemo = {
        categories = [
          "System"
          "TerminalEmulator"
        ];
        exec = ''launch-ghostty --class=com.mitchellh.ghostty-nemo -e "ssh nemo"'';
        genericName = "Ghostty (nemo)";
        icon = "com.mitchellh.ghostty";
        name = "Ghostty (nemo)";
        settings = {
          StartupWMClass = "com.mitchellh.ghostty-nemo";
          TryExec = "launch-ghostty";
        };
        terminal = false;
        type = "Application";
      };
    };

  };
}
