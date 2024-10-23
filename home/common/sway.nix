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
          font-family: monospace;
        }

        window {
          background-color: #7c818c;
        }
      '';
    };

    home.packages = with pkgs; [
      fuzzel
      light
    ];

    wayland.windowManager.sway =
      let
        gtk-launch = "${pkgs.gtk4.dev}/bin/gtk4-launch";
        light = "${pkgs.light}/bin/light";
        playerctl = "${pkgs.playerctl}/bin/playerctl --all-players";
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

          fonts.names = [ "Berkeley Mono Variable" ];

          gaps = {
            smartGaps = true;
            smartBorders = "on";
            inner = 0;
            outer = 0;
          };

          window = {
            border = 3;
            titlebar = false;
          };

          keybindings =
            let
              inherit (config.wayland.windowManager.sway.config) modifier menu;
            in
            lib.mkAfter {
              "${modifier}+return" = "exec ${menu}";
              "${modifier}+f" = "floating toggle";
              "${modifier}+t" = "exec ghostty";
              "${modifier}+s" = "sticky toggle";
              "${modifier}+q" = "exit";
              "${modifier}+r" = "reload";
              "XF86MonBrightnessDown" = "exec '${light} -U 15'";
              "XF86MonBrightnessUp" = "exec '${light} -A 15'";
              "XF86AudioRaiseVolume" = "exec '${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0'";
              "XF86AudioLowerVolume" = "exec '${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0'";
              "XF86AudioMute" = "exec '${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle'";
              "XF86AudioPlay" = "exec '${playerctl} play-pause'";
              "XF86AudioNext" = "exec '${playerctl} next'";
              "XF86AudioPrev" = "exec '${playerctl} previous'";
              "Print" = "exec 'screenshot.sh clipboard'";
            };
        };
      };
  };
}
