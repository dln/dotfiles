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
      clearDefaultKeybinds = true;
      settings = {
        font-size = 10;
        font-family = "Go Mono";
        font-synthetic-style = false;

        # adjust-cell-height = 6;
        adjust-cell-height = 3;
        adjust-font-baseline = 1;
        adjust-cursor-thickness = 4;
        adjust-underline-position = 3;
        adjust-underline-thickness = -1;

        mouse-hide-while-typing = true;
        unfocused-split-opacity = 0.9;
        unfocused-split-fill = "#056157";

        shell-integration = "fish";

        window-height = 42;
        window-width = 110;
        # window-padding-balance = true;
        window-padding-color = "extend";
        window-padding-x = 8;
        window-padding-y = 0;
        window-subtitle = "working-directory";
        window-theme = "system";
        theme = "light:GitHub Light High Contrast,dark:GitHub Dark High Contrast";

        keybind = [
          "alt+shift+c=copy_to_clipboard"
          "alt+shift+v=paste_from_clipboard"
          "ctrl+shift+c=copy_to_clipboard"
          "ctrl+shift+v=paste_from_clipboard"
          "ctrl+-=decrease_font_size:1"
          "ctrl++=increase_font_size:1"
          "ctrl+equal=increase_font_size:1"
          "ctrl+0=reset_font_size"
          "global:ctrl+grave_accent=toggle_quick_terminal"
        ];
      };
    };

    xdg.configFile."ghostty/dark-config".text = ''
      adjust-cell-height = 2
      adjust-cursor-thickness = 4
      adjust-font-baseline = 1
      adjust-underline-position = 3
      adjust-underline-thickness = -1
      font-family = Berkeley Mono SemiCondensed
      font-size = 12
      font-synthetic-style = false
      keybind = clear
      keybind = alt+shift+c=copy_to_clipboard
      keybind = alt+shift+v=paste_from_clipboard
      keybind = ctrl+shift+c=copy_to_clipboard
      keybind = ctrl+shift+v=paste_from_clipboard
      keybind = ctrl+-=decrease_font_size:1
      keybind = ctrl++=increase_font_size:1
      keybind = ctrl+equal=increase_font_size:1
      keybind = ctrl+0=reset_font_size
      mouse-hide-while-typing = true
      shell-integration = fish
      theme = GitHub Dark High Contrast
      window-padding-color = extend
      window-padding-x = 8
      window-padding-y = 0
      window-subtitle = working-directory
      window-theme = system
    '';

    xdg.desktopEntries.ghostty-dark = {
      name = "Ghostty (Dark)";
      genericName = "Terminal Emulator";
      exec = "ghostty --config-default-files=false --config-file=${config.xdg.configHome}/ghostty/dark-config";
      icon = "com.mitchellh.ghostty";
      terminal = false;
      categories = [
        "System"
        "TerminalEmulator"
      ];
    };

  };
}
