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
        font-size = 11;
        font-family = "Berkeley Mono";
        font-family-italic = "Monaspace Radon Var";
        font-family-bold-italic = "Monaspace Krypton Var";
        font-style = "Regular";
        font-style-bold = "Bold";
        font-style-italic = "Italic";
        font-style-bold-italic = "ExtraLight";
        font-synthetic-style = false;

        adjust-cursor-thickness = 4;
        adjust-underline-position = 3;
        adjust-underline-thickness = -1;

        mouse-hide-while-typing = true;
        unfocused-split-opacity = 0.8;
        unfocused-split-fill = "#056157";

        shell-integration = "fish";

        gtk-tabs-location = "hidden";
        gtk-titlebar = false;
        gtk-titlebar-hide-when-maximized = true;
        window-height = 60;
        window-width = 160;
        window-padding-balance = true;
        window-padding-color = "extend";
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
        };
        PatagiaLight = {
          background = "#fefeff";
          foreground = "#222222";
          cursor-color = "#aa0000";
          selection-background = "#ffe6a4";
          selection-foreground = "#483600";
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
    };

  };
}
