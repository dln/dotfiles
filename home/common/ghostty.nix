{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.patagia.desktop.enable {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        font-size = 10;
        font-family = "Go Mono";
        font-synthetic-style = false;

        adjust-cell-height = 6;
        adjust-font-baseline = 1;
        adjust-cursor-thickness = 4;
        adjust-underline-position = 3;
        adjust-underline-thickness = -1;

        mouse-hide-while-typing = true;
        unfocused-split-opacity = 0.9;
        unfocused-split-fill = "#056157";

        shell-integration = "fish";

        gtk-tabs-location = "hidden";
        gtk-titlebar = false;
        gtk-titlebar-hide-when-maximized = true;
        window-height = 45;
        window-width = 120;
        window-padding-balance = true;
        window-padding-color = "extend";
        window-padding-x = 10;
        window-padding-y = 10;
        window-theme = "system";
        theme = "light:PatagiaLight,dark:PatagiaDark";

        keybind = [
          "alt+shift+c=copy_to_clipboard"
          "alt+shift+v=paste_from_clipboard"
          "ctrl+i=text:\\x09"
          "ctrl+m=text:\\x0D"
          "ctrl+tab=goto_split:previous"
          "alt+`=goto_split:previous"
          "ctrl+[=text:\\x1B"
          "super+enter=toggle_fullscreen"
        ];
      };
      themes = {
        PatagiaDark = {
          background = "#14151a";
          foreground = "#b7bec7";
          cursor-color = "#e7e7b7";
          selection-background = "#84979f";
          selection-foreground = "#000000";
          palette = [
            "0=#43454b"
            "1=#ff8a7a"
            "2=#83c9bc"
            "3=#d9c668"
            "4=#4ec4e6"
            "5=#ff85b8"
            "6=#cda1ff"
            "7=#ffffff"
            "8=#838991"
            "9=#ff8a7a"
            "10=#b1faeb"
            "11=#ffa14f"
            "12=#6bdfff"
            "13=#ff85b8"
            "14=#e5cfff"
            "15=#ffffff"
          ];
        };
        PatagiaLight = {
          background = "#fefeff";
          foreground = "#222222";
          cursor-color = "#aa0000";
          selection-background = "#ffe6a4";
          selection-foreground = "#483600";
          palette = [
            "0=#b4d8fd"
            "1=#ad1805"
            "2=#355d61"
            "3=#78492a"
            "4=#0058a1"
            "5=#9c2191"
            "6=#703daa"
            "7=#000000"
            "8=#8a99a6"
            "9=#ad1805"
            "10=#174145"
            "11=#78492a"
            "12=#003f73"
            "13=#9c2191"
            "14=#441ea1"
            "15=#000000"
          ];
        };
      };
    };

    xdg.desktopEntries = {
      ghostty-secondary = {
        categories = [
          "System"
          "TerminalEmulator"
        ];
        exec = ''
          ghostty --class=com.mitchellh.ghostty-secondary --background-opacity=0.8 --font-style="UltraCondensed" --font-style-bold="Bold UltraCondensed" --font-style-italic="UltraCondensed Oblique" -e bash
        '';
        genericName = "Secondary Ghostty";
        icon = "com.mitchellh.ghostty";
        name = "Secondary Ghostty";
        settings = {
          StartupWMClass = "com.mitchellh.ghostty-secondary";
          TryExec = "ghostty";
        };
        terminal = false;
        type = "Application";
      };

      ghostty-devel = {
        categories = [
          "System"
          "TerminalEmulator"
        ];
        exec = ''
          ghostty --class=com.mitchellh.ghostty-devel --command="ssh -t devel" --initial-command="ssh -t devel"
        '';
        genericName = "Ghostty (devel)";
        icon = "com.mitchellh.ghostty";
        name = "Ghostty (devel)";
        settings = {
          StartupWMClass = "com.mitchellh.ghostty-devel";
          TryExec = "ghostty";
        };
        terminal = false;
        type = "Application";
      };

      ghostty-devel-secondary = {
        categories = [
          "System"
          "TerminalEmulator"
        ];
        exec = ''
          ghostty --class=com.mitchellh.ghostty-devel-secondary --background-opacity=0.8 --font-style="ExtraCondensed" --font-style-bold="Bold ExtraCondensed" --font-style-italic="ExtraCondensed Oblique" --command="ssh -t devel" --initial-command="ssh -t devel"
        '';
        genericName = "Secondary Ghostty (devel)";
        icon = "com.mitchellh.ghostty";
        name = "Secondary Ghostty (devel)";
        settings = {
          StartupWMClass = "com.mitchellh.ghostty-devel-secondary";
          TryExec = "ghostty";
        };
        terminal = false;
        type = "Application";
      };
    };

  };
}
