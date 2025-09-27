{
  config,
  lib,
  pkgs,
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
        window-decoration = "client";
        window-height = 42;
        window-width = 120;
        window-padding-balance = true;
        window-padding-color = "extend";
        window-padding-x = 8;
        window-padding-y = 8;
        window-theme = "system";
        theme = "light:PatagiaLight,dark:PatagiaDark";

        background-blur = true;
        background-opacity = 0.9;

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
          background = "#0d1117";
          foreground = "#e6edf3";
          cursor-color = "#e7e7b7";
          selection-background = "#84979f";
          selection-foreground = "#000000";
          palette = [
            "0=#484f58"
            "1=#ff7b72"
            "2=#3fb950"
            "3=#d29922"
            "4=#58a6ff"
            "5=#bc8cff"
            "6=#39c5cf"
            "7=#b1bac4"
            "8=#6e7681"
            "9=#ffa198"
            "10=#56d364"
            "11=#e3b341"
            "12=#79c0ff"
            "13=#d2a8ff"
            "14=#56d4dd"
            "15=#ffffff"
          ];
        };
        PatagiaLight = {
          background = "#fefeff";
          foreground = "#1f2328";
          cursor-color = "#cf222e";
          selection-background = "#ffe6a4";
          selection-foreground = "#483600";
          palette = [
            "0=#24292f"
            "1=#cf222e"
            "2=#116329"
            "3=#4d2d00"
            "4=#0969da"
            "5=#8250df"
            "6=#1b7c83"
            "7=#6e7781"
            "8=#57606a"
            "9=#a40e26"
            "10=#1a7f37"
            "11=#633c01"
            "12=#218bff"
            "13=#a475f9"
            "14=#3192aa"
            "15=#8c959f"
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
          ${lib.getExe pkgs.ghostty} --class=com.mitchellh.ghostty-secondary --background-opacity=0.8 --font-style="UltraCondensed" --font-style-bold="Bold UltraCondensed" --font-style-italic="UltraCondensed Oblique" -e bash
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
          ${lib.getExe pkgs.ghostty} --class=com.mitchellh.ghostty --class=com.mitchellh.ghostty-devel --command="${lib.getExe pkgs.openssh} -t devel" --initial-command="${lib.getExe pkgs.openssh} -t devel"
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
          ${lib.getExe pkgs.ghostty} --class=com.mitchellh.ghostty-devel-secondary --background-opacity=0.8 --font-style="ExtraCondensed" --font-style-bold="Bold ExtraCondensed" --font-style-italic="ExtraCondensed Oblique" --command="${lib.getExe pkgs.openssh} -t devel" --initial-command="${lib.getExe pkgs.openssh} -t devel"
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
