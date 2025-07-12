{
  config,
  lib,
  pkgs,
  ...
}:
with lib.hm.gvariant;
{
  config = lib.mkIf config.patagia.desktop.enable {
    home.packages = with pkgs; [
      gnome-contacts
      gnome-shell-extensions
      gnome-tweaks
      gnome-pomodoro
      gnomeExtensions.blur-my-shell
      gnomeExtensions.desktop-clock
      gnomeExtensions.emoji-copy
      gnomeExtensions.highlight-focus
      gnomeExtensions.just-perfection
      gnomeExtensions.night-light-slider
    ];

    dconf.settings = {
      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>q" ];
        toggle-on-all-workspaces = [ "<Super>s" ];
        toggle-maximized = [ "<Super>m" ];
        maximize-vertically = [ "<Super>Up" ];
        minimize = [ "<Super>comma" ];
        move-to-center = [ "<Super>c" ];
        switch-applications = [ "<Super>Tab" ];
        switch-group = [ "<Super>Above_Tab" ];
        switch-windows = [ "<Alt>Tab" ];
        move-to-workspace-1 = [ "<Shift>F1" ];
        move-to-workspace-2 = [ "<Shift>F2" ];
        move-to-workspace-3 = [ "<Shift>F3" ];
        move-to-workspace-4 = [ "<Shift>F4" ];
        move-to-workspace-5 = [ "<Shift>F5" ];
        move-to-workspace-6 = [ "<Shift>F6" ];
        move-to-workspace-7 = [ "<Shift>F7" ];
        move-to-workspace-8 = [ "<Shift>F8" ];
        move-to-workspace-9 = [ "<Shift>F9" ];
        switch-to-workspace-1 = [ "F1" ];
        switch-to-workspace-2 = [ "F2" ];
        switch-to-workspace-3 = [ "F3" ];
        switch-to-workspace-4 = [ "F4" ];
        switch-to-workspace-5 = [ "F5" ];
        switch-to-workspace-6 = [ "F6" ];
        switch-to-workspace-7 = [ "F7" ];
        switch-to-workspace-8 = [ "F8" ];
        switch-to-workspace-9 = [ "F9" ];
      };

      "org/gnome/desktop/input-sources" = {
        mru-sources = [
          (mkTuple [
            "xkb"
            "us"
          ])
        ];
        sources = [
          (mkTuple [
            "xkb"
            "se+us"
          ])
        ];
        xkb-options = [ "caps:ctrl_modifier" ];
      };

      "org/gnome/desktop/interface" = {
        enable-animations = false;
        enable-hot-corners = false;
        show-battery-percentage = true;
        font-name = "Inter Variable 11";
        document-font-name = "Inter Variable 11";
        monospace-font-name = "Berkeley Mono 11";
        toolkit-accessibility = false;
      };

      "org/gnome/desktop/search-providers" = {
        disabled = [
          "org.gnome.Contacts.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.Calendar.desktop"
          "org.gnome.clocks.desktop"
          "org.gnome.Epiphany.desktop"
        ];
        sort-order = [
          "org.gnome.Contacts.desktop"
          "org.gnome.Documents.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.Settings.desktop"
          "org.gnome.Calculator.desktop"
          "org.gnome.Calendar.desktop"
          "org.gnome.clocks.desktop"
          "org.gnome.seahorse.Application.desktop"
          "org.gnome.Weather.desktop"
          "org.gnome.Characters.desktop"
        ];
      };

      "org/gnome/desktop/wm/preferences" = {
        focus-mode = "sloppy";
        num-workspaces = 10;
        resize-with-right-button = true;
      };

      "org/gnome/GWeather4" = {
        temperature-unit = "centigrade";
      };

      "org/gnome/Weather" = {
        locations = [
          (mkVariant (mkTuple [
            (mkUint32 2)
            (mkVariant (mkTuple [
              "Stockholm-Arlanda Airport"
              "ESSA"
              false
              [
                (mkTuple [
                  1.0410888988146176
                  0.31328660073298215
                ])
              ]
              [
                (mkTuple [
                  1.0410888988146176
                  0.31328660073298215
                ])
              ]
            ]))
          ]))
        ];
      };

      "org/gnome/desktop/calendar" = {
        show-weekdate = true;
      };

      "org/gnome/mutter" = {
        center-new-windows = false;
        edge-tiling = true;
      };

      "org/gnome/settings-daemon/plugins/color" = {
        night-light-schedule-automatic = false;
        night-light-schedule-from = 0.0;
        night-light-schedule-to = 0.0;
        night-light-temperature = mkUint32 3575;
      };

      "org/gnome/shell" = {
        enabled-extensions = [
          "blur-my-shell@aunetx"
          "emoji-copy@felipeftn"
          "highlight-focus@pimsnel.com"
          "just-perfection-desktop@just-perfection"
        ];
      };

      "org/gnome/shell/extensions/blur-my-shell/applications" = {
        blur = true;
        brightness = 1.0;
        dynamic-opacity = false;
        enable-all = false;
        opacity = 210;
        sigma = 25;
        whitelist = [
          "com.mitchellh.ghostty"
          "com.mitchellh.ghostty-devel"
        ];
      };

      "org/gnome/shell/extensions/emoji-copy" = {
        emoji-keybind = [ "<Super>e" ];
      };

      "org/gnome/shell/extensions/highlight-focus" = {
        border-color = "#3d3846";
        border-radius = 12;
        border-width = 2;
        disable-hiding = true;
        keybinding-highlight-now = [ "<Super>h" ];
      };

      "org/gnome/shell/extensions/just-perfection" = {
        animation = 0;
        notification-banner-position = 2;
        osd-position = 6;
        panel = false;
        panel-in-overview = true;
        startup-status = 0;
        switcher-popup-delay = false;
        top-panel-position = 0;
      };

      "org/gnome/tweaks" = {
        show-extensions-notice = false;
      };

    };
  };
}
