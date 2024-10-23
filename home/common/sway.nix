{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.patagia.desktop.enable {

    home.sessionVariables.NIXOS_OZONE_WL = "1"; # For electron apps

    programs.wofi = {
      enable = true;
      settings = {
        location = "top-center";
        allow_markup = true;
        width = 800;
      };

      style = ''
        * {
          font-family: TX-02;
        }

        window {
          background-color: #141b23;
        }
      '';
    };

    home.packages = with pkgs; [
      clipman
      fuzzel
      gcr
      light
      wofi
      swayidle
      swaylock
      waybar
      wireplumber
      wob
    ];

    services.gnome-keyring.enable = true;

    home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
      x11 = {
        enable = true;
        defaultCursor = "Adwaita";
      };
    };

    xdg.portal = {
      enable = true;
      # config.common.default = "*";
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;
      config = {
        common = {
          default = [ "wlr" ];
        };
        sway = {
          default = [ "wlr" ];
        };
      };
    };

    wayland.windowManager.sway =
      let
        gtk-launch = "${pkgs.gtk4.dev}/bin/gtk4-launch";
        light = "${pkgs.light}/bin/light";
        wofi = "${pkgs.wofi}/bin/wofi";
        wpctl = "${pkgs.wireplumber}/bin/wpctl";
      in
      {
        enable = true;
        systemd.enable = true;
        wrapperFeatures.gtk = true;

        # SwayFX for fancy fancification
        package = pkgs.swayfx;
        checkConfig = false; # workaround for https://discourse.nixos.org/t/sway-fails-with-cannot-create-gles2-renderer-after-update/45703
        extraConfig = ''
          corner_radius 6
          shadows enable
        '';
        # default_dim_inactive 0.9

        config = {
          modifier = "Mod4";
          terminal = "ghostty";
          menu = "${wofi} --show drun";

          fonts.names = [ "TX-02" ];

          gaps = {
            smartGaps = true;
            smartBorders = "on";
            inner = 0;
            outer = 0;
          };

          input = {
            "type:keyboard" = {
              xkb_layout = "us,se";
              xkb_options = "ctrl:nocaps,grp:switch,compose:rctrl";
            };
            "type:touchpad" = {
              dwt = "true";
              natural_scroll = "true";
              tap = "true";
            };
          };

          window = {
            border = 3;
            titlebar = false;
          };

          modes = {

            "(p)oweroff, (s)uspend, (h)ibernate, (r)eboot, (l)ogout" = {
              p = "exec swaymsg 'mode default' && systemctl poweroff";
              s = "exec swaymsg 'mode default' && systemctl suspend-then-hibernate";
              h = "exec swaymsg 'mode default' && systemctl hibernate";
              r = "exec swaymsg 'mode default' && systemctl reboot";
              l = "exec swaymsg 'mode default' && systemctl --user stop sway-session.target && systemctl --user stop graphical-session.target && swaymsg exit";
              Return = "mode default";
              Escape = "mode default";
            };
          };

          keybindings =
            let
              inherit (config.wayland.windowManager.sway.config) modifier menu;
            in
            lib.mkAfter {
              "${modifier}+Escape" = ''mode "(p)oweroff, (s)uspend, (h)ibernate, (r)eboot, (l)ogout"'';
              "${modifier}+return" = "exec ${menu}";
              "${modifier}+f" = "floating toggle";
              "${modifier}+t" = "exec ghostty";
              "${modifier}+s" = "sticky toggle";
              "${modifier}+q" = ''kill'';
              "${modifier}+Control+q" = "exit";
              "${modifier}+r" = "reload";
              "XF86MonBrightnessDown" = "exec '${light} -U 15'";
              "XF86MonBrightnessUp" = "exec '${light} -A 15'";
              "XF86AudioRaiseVolume" = "exec '${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0'";
              "XF86AudioLowerVolume" = "exec '${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0'";
              "XF86AudioMute" = "exec '${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle'";
              "Print" = "exec 'screenshot.sh clipboard'";

              "F1" = "workspace number 1";
              "F2" = "workspace number 2";
              "F3" = "workspace number 3";
              "F4" = "workspace number 4";
              "F5" = "workspace number 5";
              "F6" = "workspace number 6";
              "F7" = "workspace number 7";
              "F8" = "workspace number 8";
              "F9" = "workspace number 9";
              "F10" = "workspace number 10";

              # Move focused container to workspace
              "Shift+F1" = "move container to workspace number 1";
              "Shift+F2" = "move container to workspace number 2";
              "Shift+F3" = "move container to workspace number 3";
              "Shift+F4" = "move container to workspace number 4";
              "Shift+F5" = "move container to workspace number 5";
              "Shift+F6" = "move container to workspace number 6";
              "Shift+F7" = "move container to workspace number 7";
              "Shift+F8" = "move container to workspace number 8";
              "Shift+F9" = "move container to workspace number 9";
              "Shift+F10" = "move container to workspace number 10";

            };
        };
      };
  };
}
