{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
{
  imports = [
    inputs.niri.homeModules.niri
  ];

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  home.packages = with pkgs; [
    brightnessctl
    wl-gammarelay-rs
    wlprop
    xwayland-satellite-unstable
  ];

  home.pointerCursor = {
    gtk.enable = true;
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32;
  };

  programs.fuzzel.enable = true;
  programs.swaylock.enable = true;

  # services.mako.enable = true;
  services.swayidle.enable = true;
  services.swaync = {
    enable = true;
  };

  services.polkit-gnome.enable = true;

  programs.niri.settings = {
    environment = {
      DISPLAY = ":0";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland"; # fixes electron wayland
      NIXOS_OZONE_WL = "1"; # fixes electron wayland
    };

    prefer-no-csd = true;

    cursor = {
      size = config.home.pointerCursor.size;
      theme = config.home.pointerCursor.name;
      hide-when-typing = true;
      hide-after-inactive-ms = 3000;
    };

    input = {
      keyboard.xkb = {
        layout = "se";
        options = "caps:ctrl_modifier";
        variant = "us";
      };
      mouse.accel-speed = 1.0;
      touchpad = {
        tap = true;
        dwt = true;
        natural-scroll = true;
        click-method = "clickfinger";
      };
      tablet.map-to-output = "eDP-1";
      touch.map-to-output = "eDP-1";
    };
    binds = with config.lib.niri.actions; {
      "Mod+T".action = spawn "ghostty";
      "Mod+O".action = show-hotkey-overlay;
      "Mod+D".action = spawn "fuzzel";
      "Mod+Q".action = close-window;

      "Mod+Space".action = toggle-column-tabbed-display;
      "Mod+F".action = toggle-window-floating;
      "Mod+R".action = switch-preset-column-width;
      "Mod+M".action = maximize-column;
      "Mod+Return".action = fullscreen-window;
      "Mod+C".action = center-column;
      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Plus".action = set-column-width "+10%";
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Plus".action = set-window-height "+10%";

      "Mod+L".action = focus-column-right;
      "Mod+Right".action = focus-column-right;
      "Mod+H".action = focus-column-left;
      "Mod+Left".action = focus-column-left;
      "Mod+K".action = focus-window-up;
      "Mod+Up".action = focus-window-up;
      "Mod+J".action = focus-window-down;
      "Mod+Down".action = focus-window-down;

      "Mod+Tab".action = focus-window-down-or-column-right;
      "Mod+Shift+Tab".action = focus-window-up-or-column-left;

      "Print".action = screenshot;
      "Control+Print".action.screenshot-screen = {
        write-to-disk = false;
      };
      "Mod+Print".action.screenshot-window = {
        write-to-disk = false;
      };

      ## Audio
      "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-";
      "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+";
      "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
      "Shift+XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "1.0";

      ## Screen brightness + temperature
      "XF86MonBrightnessUp".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "5%+";
      "XF86MonBrightnessDown".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "5%-";
      "Shift+XF86MonBrightnessUp".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "100%";
      "Control+XF86MonBrightnessUp".action =
        spawn "busctl" "--user" "--" "call" "rs.wl-gammarelay" "/" "rs.wl.gammarelay" "UpdateTemperature"
          "n"
          "500";
      "Control+XF86MonBrightnessDown".action =
        spawn "busctl" "--user" "--" "call" "rs.wl-gammarelay" "/" "rs.wl.gammarelay" "UpdateTemperature"
          "n"
          "-500";
      "Control+Shift+XF86MonBrightnessUp".action =
        spawn "busctl" "--user" "--" "set-property" "rs.wl-gammarelay" "/" "rs.wl.gammarelay" "Temperature"
          "q"
          "6500";
      "Control+Shift+XF86MonBrightnessDown".action =
        spawn "busctl" "--user" "--" "set-property" "rs.wl-gammarelay" "/" "rs.wl.gammarelay" "Temperature"
          "q"
          "2500";

      ## Misc
      "Mod+Shift+Ctrl+T".action = toggle-debug-tint;
      "Mod+Shift+Escape".action = toggle-keyboard-shortcuts-inhibit;
      "Mod+Shift+E".action = quit;

    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [
      {
        layer = "top";
        position = "bottom";
        height = 28;
        spacing = 3;
        modules-left = [
          "niri/workspaces"
        ];
        modules-center = [
          "tray"
        ];
        modules-right = [
          "network"
          "wireplumber"
          "custom/wl-gammarelay-temperature"
          "battery"
          "power-profiles-daemon"
          "clock"
        ];

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "<span>{icon}</span> {capacity}%";
          format-charging = "<span></span> {capacity}%";
          format-icons = [
            " "
            " "
            " "
            " "
            " "
          ];
        };

        "clock" = {
          "interval" = 30;
          "tooltip" = true;
          "format" = "{:%H.%M}";
          "tooltip-format" = "{:%c}";
        };

        "custom/wl-gammarelay-temperature" = {
          format = "{} ";
          exec = "wl-gammarelay-rs watch {t}";
          on-scroll-up = "busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n -50";
          on-scroll-down = "busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n +50";
        };

        network = {
          interval = 2;
          format-wifi = " {essid}";
          format-ethernet = "󰈀 {ifname}";
          format-linked = "󰈁 {ifname}";
          format-disconnected = "  ";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}\n {bandwidthDownBits}\n {bandwidthUpBits}";
        };

        wireplumber = {
          on-click = "${pkgs.pwvucontrol}/bin/pwvucontrol";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01-";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01+";
        };

      }
    ];
  };

  systemd.user.services.wl-gammarelay-rs = {
    Unit = {
      Description = "A simple program that provides DBus interface to control display temperature and brightness under wayland without flickering.";
      Documentation = "https://github.com/MaxVerevkin/wl-gammarelay-rs";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.wl-gammarelay-rs}/bin/wl-gammarelay-rs run";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
