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
        font-size = 14;
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
        cursor-style = "block";
        unfocused-split-opacity = 1.0;

        shell-integration = "fish";
        initial-command = "nvim-remote";

        window-decoration = true;
        gtk-single-instance = true;
        gtk-tabs-location = "hidden";
        gtk-titlebar = false;
        window-padding-x = 12;
        window-padding-y = 0;
        window-padding-balance = true;
        window-padding-color = "extend";
        window-theme = "system";
        theme = "light:PatagiaLight,dark:PatagiaDark";

        keybind = [
          "alt+shift+c=copy_to_clipboard"
          "alt+shift+v=paste_from_clipboard"
          "ctrl+tab=goto_split:previous"
          "super+enter=toggle_fullscreen"
        ];
      };
    };

    xdg.configFile."ghostty/themes/PatagiaDark".text =
      let
        background = if config.patagia.oled.enable then "#000000" else "#14151a";
      in
      ''
      background = "${background}"
      foreground = #b7bec7
      cursor-color = #e7e7b7
      selection-background = #84979f
      selection-foreground = #000000
      palette = 0=#000000
      palette = 1=#ff0035
      palette = 2=#85ff00
      palette = 3=#ffc900
      palette = 4=#00a7ff
      palette = 5=#cb01ff
      palette = 6=#00e0ff
      palette = 7=#b7bec7
      palette = 8=#444444
      palette = 9=#ff8c88
      palette = 10=#baff94
      palette = 11=#ffe090
      palette = 12=#88ccff
      palette = 13=#e38dff
      palette = 14=#97eeff
      palette = 15=#ffffff
    '';

    xdg.configFile."ghostty/themes/PatagiaLight".text = ''
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
      palette = 8=#b0b0b0
      palette = 9=#ff0035
      palette = 10=#509e00
      palette = 11=#ffc900
      palette = 12=#00a7ff
      palette = 13=#cb01ff
      palette = 14=#00e0ff
      palette = 15=#ffffff
    '';

    xdg.desktopEntries = {
      ghostty-secondary = {
        categories = [
          "System"
          "TerminalEmulator"
        ];
        exec = ''
          ghostty --class=com.mitchellh.ghostty-secondary --font-style="ExtraCondensed" --font-style-bold="Bold ExtraCondensed" --font-style-italic="ExtraCondensed Oblique"
        '';
        genericName = "Ghostty Secondary";
        icon = "com.mitchellh.ghostty";
        name = "Ghostty (nemo)";
        settings = {
          StartupWMClass = "com.mitchellh.ghostty-secondary";
          TryExec = "ghostty";
        };
        terminal = false;
        type = "Application";
      };

      ghostty-nemo = {
        categories = [
          "System"
          "TerminalEmulator"
        ];
        exec = ''
          ghostty --class=com.mitchellh.ghostty-nemo --command="ssh -t nemo" --initial-command="ssh -t nemo nvim-remote"
        '';
        genericName = "Ghostty (nemo)";
        icon = "com.mitchellh.ghostty";
        name = "Ghostty (nemo)";
        settings = {
          StartupWMClass = "com.mitchellh.ghostty-nemo";
          TryExec = "ghostty";
        };
        terminal = false;
        type = "Application";
      };

      ghostty-nemo-secondary = {
        categories = [
          "System"
          "TerminalEmulator"
        ];
        exec = ''
          ghostty --class=com.mitchellh.ghostty-nemo-secondary --font-style="ExtraCondensed" --font-style-bold="Bold ExtraCondensed" --font-style-italic="ExtraCondensed Oblique" --command="ssh -t nemo" --initial-command="ssh -t nemo nvim-remote"
        '';
        genericName = "Ghostty Secondary (nemo)";
        icon = "com.mitchellh.ghostty";
        name = "Ghostty (nemo)";
        settings = {
          StartupWMClass = "com.mitchellh.ghostty-nemo-secondary";
          TryExec = "ghostty";
        };
        terminal = false;
        type = "Application";
      };
    };

  };
}
