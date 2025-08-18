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

  programs.swaylock = {
    enable = true;
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "/run/current-system/systemd/bin/loginctl lock-session";
      }
      {
        timeout = 180;
        command = "${config.programs.niri.package}/bin/niri msg action power-off-monitors";
      }
    ];
    events = [
      {
        event = "lock";
        command = "${pkgs.swaylock}/bin/swaylock";
      }
      {
        event = "before-sleep";
        command = "/run/current-system/systemd/bin/loginctl lock-session";
      }
    ];
  };

  services.swaync = {
    enable = true;
  };

  services.polkit-gnome.enable = true;

  programs.niri.settings =
    let
      inherit (inputs.niri.lib.kdl)
        node
        plain
        leaf
        flag
        ;

      ws = config.programs.niri.settings.workspaces;
    in
    {
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

      outputs."DP-1" = {
        scale = 1;
      };

      layout = {
        gaps = 7;
        background-color = "transparent";
        # center-focused-column = "always";

        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];

        # preset-window-heights { }
        default-column-width.proportion = 0.5;

        border = {
          enable = true;
          width = 1;
          inactive.color = "rgba(0,0,0,0.15)";
          active.color = "#000000";
        };

        focus-ring = {
          enable = true;
          width = 1;
          active.color = "#000000";
        };

        shadow = {
          enable = true;
          softness = 30;
          spread = -4;
          offset = {
            x = 3;
            y = 3;
          };
        };
      };

      animations = {
        slowdown = 0.8;
        workspace-switch.enable = false;
      };

      input = {
        keyboard.xkb = {
          layout = "se";
          options = "caps:ctrl_modifier";
          variant = "us";
        };
        mouse.accel-speed = 1.0;
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "0%";
        };

        touchpad = {
          tap = true;
          dwt = true;
          natural-scroll = true;
          click-method = "clickfinger";
        };
        tablet.map-to-output = "eDP-1";
        touch.map-to-output = "eDP-1";
      };

      workspaces = {
        devel = { };
        www = { };
        local = { };
        chat = { };
        docs = { };
        media = { };
        extra = { };
        share = { };
      };

      binds = with config.lib.niri.actions; {
        "Mod+T".action = spawn "ghostty";
        "Mod+D".action = spawn "fuzzel";
        "Mod+N".action = spawn "swaync-client" "-op";
        "Mod+Q".action = close-window;

        "Mod+Alt+L".action.spawn = [
          "loginctl"
          "lock-session"
        ];

        "Mod+O" = {
          action = toggle-overview;
          repeat = false;
        };
        "Mod+Shift+O".action = show-hotkey-overlay;

        # Layout
        "Mod+Space".action = toggle-column-tabbed-display;
        "Mod+F".action = toggle-window-floating;
        "Mod+M".action = maximize-column;
        "Mod+Return".action = fullscreen-window;
        "Mod+Shift+Return".action = toggle-windowed-fullscreen;
        "Mod+C".action = center-column;

        "Mod+0".action = switch-preset-column-width;
        "Mod+Shift+0".action = reset-window-height;
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        "Mod+L".action = focus-column-right;
        "Mod+Right".action = focus-column-right;
        "Mod+H".action = focus-column-left;
        "Mod+Left".action = focus-column-left;
        "Mod+K".action = focus-window-up;
        "Mod+Up".action = focus-window-up;
        "Mod+J".action = focus-window-down;
        "Mod+Down".action = focus-window-down;
        "Mod+Shift+H".action = consume-or-expel-window-left;
        "Mod+Shift+L".action = consume-or-expel-window-right;
        "Mod+Control+H".action = swap-window-left;
        "Mod+Control+L".action = swap-window-right;

        "Mod+Tab".action = focus-window-down-or-column-right;
        "Mod+Shift+Tab".action = focus-window-up-or-column-left;

        # Workspaces
        "Mod+Z".action = focus-workspace-down;
        "Mod+X".action = focus-workspace-up;
        "Mod+Shift+Z".action = move-workspace-down;
        "Mod+Shift+X".action = move-workspace-up;
        "Mod+Control+Z".action = move-workspace-to-monitor-previous;
        "Mod+Control+X".action = move-workspace-to-monitor-next;
        "F1".action = focus-workspace "devel";
        "F2".action = focus-workspace "www";
        "F3".action = focus-workspace "local";
        "F4".action = focus-workspace "docs";
        "F5".action = focus-workspace "chat";
        "F6".action = focus-workspace "media";
        "F7".action = focus-workspace "extra";
        "F8".action = focus-workspace "share";
        "Shift+F1".action.move-window-to-workspace = "devel";
        "Shift+F2".action.move-window-to-workspace = "www";
        "Shift+F3".action.move-window-to-workspace = "local";
        "Shift+F4".action.move-window-to-workspace = "docs";
        "Shift+F5".action.move-window-to-workspace = "chat";
        "Shift+F6".action.move-window-to-workspace = "media";
        "Shift+F7".action.move-window-to-workspace = "extra";
        "Shift+F8".action.move-window-to-workspace = "share";
        "Mod+1".action = focus-workspace "devel";
        "Mod+2".action = focus-workspace "www";
        "Mod+3".action = focus-workspace "local";
        "Mod+4".action = focus-workspace "docs";
        "Mod+5".action = focus-workspace "chat";
        "Mod+6".action = focus-workspace "media";
        "Mod+7".action = focus-workspace "extra";
        "Mod+8".action = focus-workspace "share";
        "Mod+Shift+1".action.move-window-to-workspace = "devel";
        "Mod+Shift+2".action.move-window-to-workspace = "www";
        "Mod+Shift+3".action.move-window-to-workspace = "local";
        "Mod+Shift+4".action.move-window-to-workspace = "docs";
        "Mod+Shift+5".action.move-window-to-workspace = "chat";
        "Mod+Shift+6".action.move-window-to-workspace = "media";
        "Mod+Shift+7".action.move-window-to-workspace = "extra";
        "Mod+Shift+8".action.move-window-to-workspace = "share";

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
        "Mod+Shift+E".action = quit;
      };

      window-rules = [
        {
          matches = [
            { app-id = "^xdg-desktop-portal-gtk$"; }
            { title = "^Open"; }
          ];
          open-floating = true;
        }
        {
          geometry-corner-radius =
            let
              r = 6.0;
            in
            {
              top-left = r;
              top-right = r;
              bottom-left = r;
              bottom-right = r;
            };
          clip-to-geometry = true;
        }
      ];
    };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.mainBar = {
      layer = "top";
      position = "bottom";
      height = 28;
      spacing = 3;
      modules-left = [
        "niri/workspaces"
        "wlr/taskbar"
      ];
      modules-center = [
        "niri/window"
      ];
      modules-right = [
        "network"
        "wireplumber"
        "custom/wl-gammarelay-temperature"
        "battery"
        "power-profiles-daemon"
        "tray"
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

      clock = {
        format = "{:%m-%d %H:%M}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          format = {
            weeks = "<span color='#999999'><b>W{:%W}</b></span>";
            today = "<span background='#00ffbb'><b><u>{}</u></b></span>";
          };
        };
      };

      "niri/workspaces" = {
        current-only = true;
      };

      "wlr/taskbar" = {
        format = "{icon}";
        icon-size = 16;
        on-click = "minimize-raise";
        on-click-middle = "close";
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
    };
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

  systemd.user.services.swaybg = {
    Unit = {
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
      Requisite = "graphical-session.target";
    };
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -c 9abcde";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "Gnome polkit authentication agent";
      PartOf = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };

    Install = {
      WantedBy = [
        "graphical-session.target"
        "niri.service"
      ];
    };
  };
}
