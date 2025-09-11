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
      height = 30;
      spacing = 1;
      margin = "0";

      modules-left = [
        "niri/workspaces"
        "niri/window"
      ];

      modules-center = [
        "clock"
      ];

      modules-right = [
        "wireplumber#sink"
        "backlight"
        "custom/wl-gammarelay-temperature"
        "network"
        "power-profiles-daemon"
        "battery"
        "custom/swaync"
        "tray"
        "custom/logout"
      ];

      "niri/workspaces" = {
        format = "{icon}";
        format-icons = {
          active = "";
          default = "";
        };
        on-click-middle = "${getExe config.programs.niri.package} msg action open-overview";
        on-click-right = "${getExe config.programs.niri.package} msg action open-overview";
      };

      "niri/window" = {
        format = "<span color='#FFD700'>  {title}</span>";
        rewrite = {
          "(.*) - Mozilla Firefox" = "🌎 $1";
          # "(.*) - zsh" = "> [$1]";
        };
      };

      "custom/hardware-wrap" = {
        format = "";
        tooltip-format = "Resource Usage";
      };

      "custom/logout" = {
        format = "  ";
        tooltip-format = "Log out";
        on-click = "${getExe pkgs.wlogout}";
      };

      clock = {
        format = " {:%H:%M 󰃮 %a %b %d}";
        format-alt = " {:%H:%M}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "month";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          on-click-right = "mode";
          format = {
            months = "<span color='#d3c6aa'><b>{}</b></span>";
            days = "<span color='#e67e80'>{}</span>";
            weeks = "<span color='#a7c080'><b>W{}</b></span>";
            weekdays = "<span color='#7fbbb3'><b>{}</b></span>";
            today = "<span color='#dbbc7f'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-click-forward = "tz_up";
          on-click-backward = "tz_down";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };

      cpu = {
        format = "󰘚 {usage}%";
        tooltip = true;
        interval = 1;
        on-click = "${getExe pkgs.ghostty} -e btm";
      };
      memory = {
        format = "󰍛 {}%";
        interval = 1;
        on-click = "${getExe pkgs.ghostty} -e btm";
      };
      temperature = {
        critical-threshold = 80;
        format = "{icon} {temperatureC}°C";
        format-icons = [
          "󱃃"
          "󰔏"
          "󱃂"
        ];
        on-click = "${getExe pkgs.ghostty} -e btm";
      };
      battery = {
        states = {
          good = 95;
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󰚥 {capacity}%";
        format-alt = "{icon} {time}";
        format-icons = [
          "󰂎"
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
      };

      network = {
        format-icons = [
          "󰤯"
          "󰤟"
          "󰤢"
          "󰤥"
          "󰤨"
        ];
        format-disconnected = "󰤮 Disconnected";
        format-ethernet = "󰈀 {ifname}";
        format-linked = "󰈀 {ifname} (No IP)";
        format-wifi = "{icon} {essid} ({signalStrength}%)";
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        tooltip-format = "{ifname}: {ipaddr}/{cidr}\n {bandwidthDownBits}\n {bandwidthUpBits}";
        on-click = "${getExe pkgs.iwmenu} -i xdg -l walker";
        on-click-right = "${getExe pkgs.iwmenu} -i xdg -l walker";
      };

      "wireplumber#sink" = {
        format = "{icon} {volume}%";
        format-muted = "";
        format-icons = [
          ""
          ""
          ""
        ];
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        on-click-right = getExe pkgs.pwvucontrol;
        on-click-middle = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 100%";
        on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-";
        on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+";
      };

      "custom/wl-gammarelay-temperature" = {
        format = " {}  ";
        exec = "${getExe pkgs.wl-gammarelay-rs} watch {t}";
        on-click = "busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 4500";
        on-click-middle = "busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 6000";
        on-click-right = "busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 2500";
        on-scroll-up = "busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n -50";
        on-scroll-down = "busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n +50";
      };

      backlight = {
        format = "{icon} {percent}%";
        format-icons = [
          "󰃞"
          "󰃟"
          "󰃠"
        ];
        on-click = "${getExe pkgs.brightnessctl} set 100%";
        on-click-middle = "${getExe pkgs.brightnessctl} set 100%";
        on-click-right = "${getExe pkgs.brightnessctl} set 50%";
        on-scroll-up = "${getExe pkgs.brightnessctl} set 1%-";
        on-scroll-down = "${getExe pkgs.brightnessctl} set 1%+";
      };
      disk = {
        interval = 30;
        format = "󰋊 {percentage_used}%";
        path = "/";
      };
      tray = {
        icon-size = 16;
        spacing = 5;
      };
      power-profiles-daemon = {
        format = "{icon}";
        tooltip-format = "Power profile: {profile}\nDriver: {driver}";
        tooltip = true;
        format-icons = {
          default = "";
          performance = "";
          balanced = "";
          power-saver = "";
        };
      };

      "custom/swaync" = {
        tooltip = false;
        format = "{icon} ";
        format-icons = {
          none = "";
          notification = "<span foreground='#ff8952'><sup></sup></span>";
          dnd-notification = "<span foreground='#ff8952'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification = "<span foreground='#ff8952'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification = "<span foreground='#ff8952'><sup></sup></span>";
          dnd-inhibited-none = "";
        };
        return-type = "json";
        escape = true;
        exec-if = "which ${getExe' pkgs.swaynotificationcenter "swaync-client"}";
        exec = "${getExe' pkgs.swaynotificationcenter "swaync-client"} --subscribe-waybar";
        on-click = "${getExe' pkgs.swaynotificationcenter "swaync-client"} --toggle-panel --skip-wait";
        on-click-middle = "${getExe' pkgs.swaynotificationcenter "swaync-client"} --toggle-dnd --skip-wait";
      };

    };

    style = ''
      @define-color background rgba(0,0,0,0.8);
      @define-color background-light rgba(255,255,255,0.1);
      @define-color foreground #e0e0e0;
      @define-color foreground-dark #707070;
      @define-color black #5a5a5a;
      @define-color red #ff9a9e;
      @define-color green #b5e8a9;
      @define-color yellow #ffe6a7;
      @define-color blue #63a4ff;
      @define-color magenta #dda0dd;
      @define-color cyan #a3e8e8;
      @define-color white #ffffff;
      @define-color orange #ff8952;

      /* Module-specific colors */
      @define-color workspaces-color @background-light;
      @define-color workspaces-focused-bg @green;
      @define-color workspaces-focused-fg @cyan;
      @define-color workspaces-urgent-bg @red;
      @define-color workspaces-urgent-fg @black;

      /* Text and border colors for modules */
      @define-color mode-color @orange;
      @define-color group-hardware-color @blue;
      @define-color logout-color @red;
      @define-color clock-color @blue;
      @define-color battery-color @cyan;
      @define-color battery-charging-color @green;
      @define-color battery-warning-color @yellow;
      @define-color battery-critical-color @red;
      @define-color network-color @blue;
      @define-color network-disconnected-color @red;
      @define-color notifications-color @blue;
      @define-color pulseaudio-color @orange;
      @define-color pulseaudio-muted-color @red;
      @define-color wireplumber-color @green;
      @define-color wireplumber-muted-color @red;
      @define-color backlight-color @yellow;
      @define-color gamma-color @orange;
      @define-color quote-color @green;
      @define-color idle-inhibitor-color @foreground;
      @define-color idle-inhibitor-active-color @red;
      @define-color power-profiles-daemon-color @cyan;
      @define-color power-profiles-daemon-performance-color @red;
      @define-color power-profiles-daemon-balanced-color @yellow;
      @define-color power-profiles-daemon-power-saver-color @green;

      * {
          /* Base styling for all modules */
          border: none;
          border-radius: 0;
          font-family: "Inter";
          font-size: 14px;
          min-height: 0;
      }

      window#waybar {
          background-color: @background;
          color: @foreground;
      }

      /* Common module styling with border-bottom */
      #mode,
      #custom-hardware-wrap,
      #custom-logout,
      #custom-swaync,
      #custom-wl-gammarelay-temperature,
      #clock,
      #cpu,
      #memory,
      #temperature,
      #battery,
      #network,
      #pulseaudio,
      #wireplumber,
      #backlight,
      #disk,
      #power-profiles-daemon,
      #idle_inhibitor,
      #tray {
          padding: 0 5px;
          margin: 0 2px 2px 2px;
          border-bottom: 0px solid transparent;
          background-color: transparent;
      }

      #backlight:hover,
      #clock:hover,
      #cpu:hover,
      #custom-hardware-wrap:hover,
      #custom-logout:hover,
      #custom-swaync:hover,
      #custom-wl-gammarelay-temperature:hover,
      #disk:hover,
      #memory:hover,
      #temperature:hover,
      #battery:hover,
      #network:hover,
      #power-profiles-daemon:hover,
      #wireplumber:hover {
          background-color: @background-light;
          border-bottom-width: 2px;
          margin-bottom: 0;
      }

      /* Workspaces styling */
      #workspaces button {
          padding: 0 10px;
          background-color: transparent;
          color: @workspaces-color;
          margin: 0;
      }

      #workspaces button:hover {
          background: @background-light;
          box-shadow: inherit;
      }

      #workspaces button.focused {
          box-shadow: inset 0 -2px @workspaces-focused-fg;
          color: @workspaces-focused-fg;
          font-weight: 900;
      }

      #workspaces button.urgent {
          background-color: @workspaces-urgent-bg;
          color: @workspaces-urgent-fg;
      }

      /* Module-specific styling */
      #mode {
          color: @mode-color;
          border-bottom-color: @mode-color;
      }

      #custom-hardware-wrap {
          color: @group-hardware-color;
          border-bottom-color: @group-hardware-color;
      }

      #custom-logout {
          color: @logout-color;
          border-bottom-color: @logout-color;
      }

      #custom-swaync {
          color: @notifications-color;
          border-bottom-color: @notifications-color;
      }

      #clock {
          color: @clock-color;
          border-bottom-color: @clock-color;
      }

      #cpu {
          color: @cpu-color;
          border-bottom-color: @cpu-color;
      }

      #memory {
          color: @memory-color;
          border-bottom-color: @memory-color;
      }

      #temperature {
          color: @temperature-color;
          border-bottom-color: @temperature-color;
      }

      #temperature.critical {
          color: @temperature-critical-color;
          border-bottom-color: @temperature-critical-color;
      }

      #power-profiles-daemon {
          color: @power-profiles-daemon-color;
          border-bottom-color: @power-profiles-daemon-color;
      }

      #power-profiles-daemon.performance {
          color: @power-profiles-daemon-performance-color;
          border-bottom-color: @power-profiles-daemon-performance-color;
      }

      #power-profiles-daemon.balanced {
          color: @power-profiles-daemon-balanced-color;
          border-bottom-color: @power-profiles-daemon-balanced-color;
      }

      #power-profiles-daemon.power-saver {
          color: @power-profiles-daemon-power-saver-color;
          border-bottom-color: @power-profiles-daemon-power-saver-color;
      }

      #battery {
          color: @battery-color;
          border-bottom-color: @battery-color;
      }

      #battery.charging,
      #battery.plugged {
          color: @battery-charging-color;
          border-bottom-color: @battery-charging-color;
      }

      #battery.warning:not(.charging) {
          color: @battery-warning-color;
          border-bottom-color: @battery-warning-color;
      }

      #battery.critical:not(.charging) {
          color: @battery-critical-color;
          border-bottom-color: @battery-critical-color;
      }

      #network {
          color: @network-color;
          border-bottom-color: @network-color;
      }

      #network.disconnected {
          color: @network-disconnected-color;
          border-bottom-color: @network-disconnected-color;
      }

      #pulseaudio {
          color: @pulseaudio-color;
          border-bottom-color: @pulseaudio-color;
      }

      #pulseaudio.muted {
          color: @pulseaudio-muted-color;
          border-bottom-color: @pulseaudio-muted-color;
      }

      #wireplumber {
          color: @wireplumber-color;
          border-bottom-color: @wireplumber-color;
      }

      #wireplumber.muted {
          color: @wireplumber-muted-color;
          border-bottom-color: @wireplumber-muted-color;
      }

      #backlight {
          color: @backlight-color;
          border-bottom-color: @backlight-color;
      }

      #custom-wl-gammarelay-temperature {
          color: @gamma-color;
          border-bottom-color: @gamma-color;
      }

      #disk {
          color: @disk-color;
          border-bottom-color: @disk-color;
      }

      #idle_inhibitor {
          color: @idle-inhibitor-color;
          border-bottom-color: transparent;
      }

      #idle_inhibitor.activated {
          color: @idle-inhibitor-active-color;
          border-bottom-color: @idle-inhibitor-active-color;
      }

      #tray {
          background-color: transparent;
          padding: 0 10px;
          margin: 0 2px;
      }

      #tray>.passive {
          -gtk-icon-effect: dim;
      }

      #tray>.needs-attention {
          -gtk-icon-effect: highlight;
          color: @red;
          border-bottom-color: @red;
      }


    '';
  };
}
