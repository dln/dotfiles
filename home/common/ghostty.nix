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

        adjust-cell-height = 6;
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

  };
}
