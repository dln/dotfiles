{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
{
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
        "custom/swaync"
        "clock"
      ];

      "niri/workspaces" = {
        current-only = true;
      };

      "wlr/taskbar" = {
        format = "{icon}";
        icon-size = 16;
        on-click = "minimize-raise";
        on-click-middle = "close";
      };

      network = {
        interval = 20;
        format-icons = [
          "󰤯"
          "󰤟"
          "󰤢"
          "󰤥"
          "󰤨"
        ];
        format-ethernet = " {bandwidthDownOctets}";
        format-wifi = "{icon} {essid}";
        format-disconnected = "󰤮 ";
        tooltip-format = "{ifname}: {ipaddr}/{cidr}\n {bandwidthDownBits}\n {bandwidthUpBits}";
        on-click = "${getExe pkgs.iwmenu} -i xdg -l walker";
      };

      wireplumber = {
        on-click = getExe pkgs.pwvucontrol;
        on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01-";
        on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01+";
      };

      "custom/wl-gammarelay-temperature" = {
        format = " {}  ";
        exec = "${getExe pkgs.wl-gammarelay-rs} watch {t}";
        on-scroll-up = "busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n -50";
        on-scroll-down = "busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n +50";
      };

      battery = {
        interval = 20;
        states = {
          warning = 30;
          critical = 15;
        };
        format = "<span>{icon}</span> {capacity}%";
        format-charging = " {capacity}%";
        format-full = " {capacity}% - Full";
        format-icons = [
          " "
          " "
          " "
          " "
          " "
        ];
      };

      "power-profiles-daemon" = {
        format = "{icon}";
        format-icons = {
          default = "";
          performance = "";
          balanced = "";
          power-saver = "";
        };
      };

      "custom/swaync" = {
        tooltip = false;
        format = "<big> {icon}</big>";
        format-icons = {
          none = "";
          notification = "<span foreground='red'><sup></sup></span>";
          dnd-notification = "<span foreground='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification = "<span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "";
        };
        return-type = "json";
        escape = true;
        exec-if = "which ${getExe' pkgs.swaynotificationcenter "swaync-client"}";
        exec = "${getExe' pkgs.swaynotificationcenter "swaync-client"} --subscribe-waybar";
        on-click = "${getExe' pkgs.swaynotificationcenter "swaync-client"} --toggle-panel --skip-wait";
        on-click-middle = "${getExe' pkgs.swaynotificationcenter "swaync-client"} --toggle-dnd --skip-wait";
      };

      clock = {
        format = "{:%a %b %d - %R}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          format = {
            weeks = "<span color='#999999'><b>W{:%W}</b></span>";
            today = "<span background='#6688aa'><b><u>{}</u></b></span>";
          };
        };
      };

    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: Inter, Helvetica, Arial, sans-serif;
        font-size: 15px;
        min-height: 0;
        margin: 2px;
        font-weight: normal;
      }

      button {
        padding: 0;
        color: #fff;
      }

      window#waybar {
        background: rgba(26, 26, 26, 0.7);
        color: #fff;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }
    '';
  };
}
