{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.patagia.desktop.enable {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      package = inputs.ghostty.packages.${pkgs.system}.default;
      settings = {
        font-size = 12.5;
        font-family = "TX-02";
        font-family-bold-italic = "Monaspace Xenon";
        font-style-bold = "Bold";
        font-style-italic = "Light Oblique";
        font-style-bold-italic = "ExtraLight Italic";
        font-synthetic-style = false;

        adjust-cursor-thickness = 4;
        adjust-underline-position = 5;
        adjust-underline-thickness = -2;

        mouse-hide-while-typing = true;
        unfocused-split-opacity = 1.0;

        shell-integration = "fish";

        gtk-tabs-location = "hidden";
        gtk-titlebar = true;
        gtk-titlebar-hide-when-maximized = true;
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
          "ctrl+[=text:\\x1B"
          "super+enter=toggle_fullscreen"
        ];
      };
      themes = {
        PatagiaDark = {
          background = if config.patagia.oled.enable then "#000000" else "#14151a";
          foreground = "#b7bec7";
          cursor-color = "#e7e7b7";
          selection-background = "#84979f";
          selection-foreground = "#000000";
          palette = [
            "#000000"
            "#ff0035"
            "#85ff00"
            "#ffc900"
            "#00a7ff"
            "#cb01ff"
            "#00e0ff"
            "#b7bec7"
            "#444444"
            "#ff8c88"
            "#baff94"
            "#ffe090"
            "#88ccff"
            "#e38dff"
            "#97eeff"
            "#ffffff"
          ];
        };
        PatagiaLight = {
          background = "#fefeff";
          foreground = "#222222";
          cursor-color = "#aa0000";
          selection-background = "#ffe6a4";
          selection-foreground = "#483600";
          palette = [
            "#000000"
            "#9e001d"
            "#306300"
            "#deae00"
            "#00669e"
            "#7d009e"
            "#008a9e"
            "#f7f7f7"
            "#b0b0b0"
            "#ff0035"
            "#509e00"
            "#ffc900"
            "#00a7ff"
            "#cb01ff"
            "#00e0ff"
            "#ffffff"
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
          ghostty --class=com.mitchellh.ghostty-secondary --font-style="ExtraCondensed" --font-style-bold="Bold ExtraCondensed" --font-style-italic="ExtraCondensed Oblique" -e bash
        '';
        genericName = "Ghostty Secondary";
        icon = "com.mitchellh.ghostty";
        name = "Ghostty Secondary";
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
          ghostty --class=com.mitchellh.ghostty-devel-secondary --font-style="ExtraCondensed" --font-style-bold="Bold ExtraCondensed" --font-style-italic="ExtraCondensed Oblique" --command="ssh -t devel" --initial-command="ssh -t devel"
        '';
        genericName = "Ghostty Secondary (devel)";
        icon = "com.mitchellh.ghostty";
        name = "Ghostty Secondary (devel)";
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
