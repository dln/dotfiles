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
    nirius
    pwvucontrol
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
          left = -10;
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
        always-center-single-column = true;
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
        "A" = { };
        "B" = { };
        "C" = { };
        "D" = { };
        "E" = { };
        "F" = { };
        "G" = { };
        "H" = { };
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
        "F1".action = focus-workspace "A";
        "F2".action = focus-workspace "B";
        "F3".action = focus-workspace "C";
        "F4".action = focus-workspace "D";
        "F5".action = focus-workspace "E";
        "F6".action = focus-workspace "F";
        "F7".action = focus-workspace "G";
        "F8".action = focus-workspace "H";
        "Shift+F1".action = spawn "niri" "msg" "action" "move-window-to-workspace" "A";
        "Shift+F2".action = spawn "niri" "msg" "action" "move-window-to-workspace" "B";
        "Shift+F3".action = spawn "niri" "msg" "action" "move-window-to-workspace" "C";
        "Shift+F4".action = spawn "niri" "msg" "action" "move-window-to-workspace" "D";
        "Shift+F5".action = spawn "niri" "msg" "action" "move-window-to-workspace" "E";
        "Shift+F6".action = spawn "niri" "msg" "action" "move-window-to-workspace" "F";
        "Shift+F7".action = spawn "niri" "msg" "action" "move-window-to-workspace" "G";
        "Shift+F8".action = spawn "niri" "msg" "action" "move-window-to-workspace" "H";
        "Mod+1".action = spawn "nirius" "focus-marked" "1";
        "Mod+2".action = spawn "nirius" "focus-marked" "2";
        "Mod+3".action = spawn "nirius" "focus-marked" "3";
        "Mod+4".action = spawn "nirius" "focus-marked" "4";
        "Mod+5".action = spawn "nirius" "focus-marked" "5";
        "Mod+6".action = spawn "nirius" "focus-marked" "6";
        "Mod+7".action = spawn "nirius" "focus-marked" "7";
        "Mod+8".action = spawn "nirius" "focus-marked" "8";
        "Mod+Shift+1".action = spawn "nirius" "toggle-mark" "1";
        "Mod+Shift+2".action = spawn "nirius" "toggle-mark" "2";
        "Mod+Shift+3".action = spawn "nirius" "toggle-mark" "3";
        "Mod+Shift+4".action = spawn "nirius" "toggle-mark" "4";
        "Mod+Shift+5".action = spawn "nirius" "toggle-mark" "5";
        "Mod+Shift+6".action = spawn "nirius" "toggle-mark" "6";
        "Mod+Shift+7".action = spawn "nirius" "toggle-mark" "7";
        "Mod+Shift+8".action = spawn "nirius" "toggle-mark" "8";
        "Mod+S".action = spawn "nirius" "toggle-follow-mode";
        "Mod+I".action = set-dynamic-cast-window;
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
              r = 8.0;
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

  systemd.user.services.niriusd = {
    Unit = {
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
      Requisite = "graphical-session.target";
    };
    Service = {
      ExecStart = ''${getExe' pkgs.nirius "niriusd"}'';
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
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
