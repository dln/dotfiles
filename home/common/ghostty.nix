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

        window-padding-balance = true;
        window-padding-color = "extend";
        window-padding-x = 8;
        window-padding-y = 8;
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
        ];
      };
    };

    xdg.desktopEntries = {
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
    };

  };
}
