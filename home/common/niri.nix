{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
let
  niri = getExe config.programs.niri.package;
  focusOrSpawn = pkgs.writeShellApplication {
    name = "niri-focus-or-spawn";
    text = ''
      window_id=$(${niri} msg --json windows | ${getExe pkgs.jq} "first(.[] | select(.app_id == \"$1\")) | .id")
      if [ -n "$window_id" ]; then
        exec ${niri} msg action focus-window --id "$window_id"
      else
        shift
        exec ${niri} msg action spawn -- "$@"
      fi
    '';
  };
in
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

  services.walker = {
    enable = true;
    systemd.enable = true;
    settings = {
      disable_click_to_close = false;

      builtins = {

        calc = {
          require_number = true;
          weight = 5;
          name = "calc";
          icon = "accessories-calculator";
          placeholder = "Calculator";
          min_chars = 4;
        };

        emojis = {
          placeholder = "";
          prefix = "e";
          switcher_only = false;
        };

        switcher = {
          weight = 5;
          name = "switcher";
          placeholder = "Switcher";
          prefix = "/";
        };

        symbols = {
          after_copy = "";
          weight = 5;
          name = "symbols";
          placeholder = "Symbols";
          switcher_only = true;
          history = true;
          typeahead = true;
        };

        windows = {
          weight = 5;
          icon = "view-restore";
          name = "windows";
          placeholder = "Windows";
          show_icon_when_single = true;
        };

      };

    };
  };

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
        command = "${niri} msg action power-off-monitors";
      }
    ];
    events = [
      {
        event = "lock";
        command = getExe pkgs.swaylock;
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

      hotkey-overlay.skip-at-startup = true;
      prefer-no-csd = true;

      cursor = {
        size = config.home.pointerCursor.size;
        theme = config.home.pointerCursor.name;
        hide-when-typing = true;
        hide-after-inactive-ms = 3000;
      };

      outputs."DP-2" = {
        enable = false;
        variable-refresh-rate = true;
      };

      outputs."eDP-1" = {
        scale = 2;
      };

      layout = {
        gaps = 8;
        struts = {
          left = 0;
          right = -10;
          top = -10;
          bottom = -10;
        };

        tab-indicator = {
          position = "left";
          place-within-column = false;
          length.total-proportion = 0.5;
          width = 4;
          gap = 2;
          gaps-between-tabs = 2;
          corner-radius = 2;
          inactive.color = "#00000044";
          active.color = "#000000";
        };

        background-color = "transparent";
        center-focused-column = "never";

        preset-column-widths = [
          { proportion = 0.375; }
          { proportion = 0.625; }
          { proportion = 0.25; }
        ];

        preset-window-heights = [
          { proportion = 0.5; }
          { proportion = 1.0; }
        ];

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
        slowdown = 0.2;
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
        scratch = { };
      };

      binds = with config.lib.niri.actions; {
        "Mod+T".action = spawn "ghostty";
        "Mod+D".action = spawn "walker";
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
        "Mod+W".action = spawn "pkill" "-SIGUSR1" "waybar"; # Toggle waybar

        # Layout
        "Mod+Space".action = toggle-column-tabbed-display;
        "Mod+F".action = toggle-window-floating;
        "Mod+M".action = maximize-column;
        "Mod+Return".action = fullscreen-window;
        "Mod+Shift+Return".action = toggle-windowed-fullscreen;
        "Mod+C".action = center-column;

        "Mod+0".action = switch-preset-column-width;
        "Mod+Shift+0".action = switch-preset-window-height;
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        "Mod+L".action = focus-column-right;
        "Mod+Right".action = focus-column-right;
        "Mod+H".action = focus-column-left;
        "Mod+Left".action = focus-column-left;
        "Mod+K".action = focus-window-up-or-bottom;
        "Mod+Up".action = focus-window-up-or-bottom;
        "Mod+J".action = focus-window-down-or-top;
        "Mod+Down".action = focus-window-down-or-top;
        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+L".action = move-column-right;
        "Mod+Control+H".action = consume-or-expel-window-left;
        "Mod+Control+L".action = consume-or-expel-window-right;

        "Mod+Tab".action = focus-window-down-or-top;
        "Mod+Control+Tab".action = move-window-up;
        "Mod+Shift+Tab".action = focus-window-up-or-bottom;

        "Mod+Z".action = focus-workspace-up;
        "Mod+X".action = focus-workspace-down;
        "Mod+Shift+Z".action = move-column-to-workspace-up;
        "Mod+Shift+X".action = move-column-to-workspace-down;
        "Mod+Control+Z".action = move-workspace-to-monitor-previous;
        "Mod+Control+X".action = move-workspace-to-monitor-next;
        "F1".action = spawn "${getExe focusOrSpawn}" "neovide" "neovide";
        "F2".action = spawn "${getExe focusOrSpawn}" "firefox" "firefox";
        "F3".action =
          spawn "${getExe focusOrSpawn}" "com.mitchellh.ghostty-1" "ghostty"
            "--class=com.mitchellh.ghostty-1";
        "F4".action = spawn "${getExe focusOrSpawn}" "signal" "signal-desktop";
        "F5".action = focus-workspace 1;
        "F6".action = focus-workspace 2;
        "F7".action = focus-workspace 3;
        "F8".action = focus-workspace 4;
        "Shift+F5".action = spawn "niri" "msg" "action" "move-window-to-workspace" "1";
        "Shift+F6".action = spawn "niri" "msg" "action" "move-window-to-workspace" "2";
        "Shift+F7".action = spawn "niri" "msg" "action" "move-window-to-workspace" "3";
        "Shift+F8".action = spawn "niri" "msg" "action" "move-window-to-workspace" "4";
        "Mod+1".action = focus-column 1;
        "Mod+2".action = focus-column 2;
        "Mod+3".action = focus-column 3;
        "Mod+4".action = focus-column 4;
        "Mod+5".action = focus-column 5;
        "Mod+6".action = focus-column 6;
        "Mod+7".action = focus-column 7;
        "Mod+8".action = focus-column 8;
        "Mod+Shift+1".action = move-column-to-index 1;
        "Mod+Shift+2".action = move-column-to-index 2;
        "Mod+Shift+3".action = move-column-to-index 3;
        "Mod+Shift+4".action = move-column-to-index 4;
        "Mod+Shift+5".action = move-column-to-index 5;
        "Mod+Shift+6".action = move-column-to-index 6;
        "Mod+Shift+7".action = move-column-to-index 7;
        "Mod+Shift+8".action = move-column-to-index 8;
        "Alt+1".action = spawn "${getExe focusOrSpawn}" "neovide" "neovide";
        "Alt+2".action =
          spawn "${getExe focusOrSpawn}" "com.mitchellh.ghostty-1" "ghostty"
            "--class=com.mitchellh.ghostty-1";
        "Alt+3".action =
          spawn "${getExe focusOrSpawn}" "com.mitchellh.ghostty-2" "ghostty"
            "--class=com.mitchellh.ghostty-2";
        "Alt+4".action =
          spawn "${getExe focusOrSpawn}" "com.mitchellh.ghostty-3" "ghostty"
            "--class=com.mitchellh.ghostty-3";
        "Alt+5".action =
          spawn "${getExe focusOrSpawn}" "com.mitchellh.ghostty-4" "ghostty"
            "--class=com.mitchellh.ghostty-4";
        "Alt+6".action =
          spawn "${getExe focusOrSpawn}" "com.mitchellh.ghostty-5" "ghostty"
            "--class=com.mitchellh.ghostty-5";

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
        "XF86MonBrightnessUp".action = spawn "${getExe pkgs.brightnessctl}" "set" "5%+";
        "XF86MonBrightnessDown".action = spawn "${getExe pkgs.brightnessctl}" "set" "5%-";
        "Shift+XF86MonBrightnessUp".action = spawn "${getExe pkgs.brightnessctl}" "set" "100%";
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
        {
          matches = [
            {
              app-id = "^firefox";
              title = "^Picture-in-Picture$";
            }
          ];
          open-floating = true;
        }
        {
          matches = [
            { app-id = "^com.mitchellh.ghostty"; }
            { app-id = "^neovide"; }
          ];
          default-column-width.proportion = 0.625;
          default-column-display = "tabbed";
        }
        {
          matches = [ { app-id = "^signal$"; } ];
          block-out-from = "screencast";
          default-column-width.proportion = 0.25;
          default-window-height.proportion = 0.5;
        }
        {
          matches = [
            { app-id = "^xdg-desktop-portal-gtk$"; }
            { title = "^Open"; }
          ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "^xwaylandvideobridge$"; } ];
          open-floating = true;
          focus-ring.enable = false;
          opacity = 0.0;
          default-floating-position = {
            x = 0;
            y = 0;
            relative-to = "bottom-right";
          };
          min-width = 1;
          max-width = 1;
          min-height = 1;
          max-height = 1;
        }
      ];

      layer-rules = [
        {
          matches = [ { namespace = "^notification$"; } ];
          block-out-from = "screencast";
        }
        {
          matches = [ { namespace = "^wallpaper$"; } ];
          place-within-backdrop = false;
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
      ExecStart = "${getExe pkgs.wl-gammarelay-rs} run";
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
      ExecStart = "${getExe pkgs.swaybg} -c 9abcde -i /home/dln/Pictures/Background/background.png";
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
