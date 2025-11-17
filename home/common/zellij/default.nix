{
  lib,
  pkgs,
  ...
}:
{

  programs.zellij = {
    enable = true;
    settings = {
      default_layout = "devel";
      pane_frames = false;
      show_startup_tips = false;
      theme = "iceberg-light";

      ui.pane_frames = {
        hide_session_name = true;
        rounded_corners = true;
      };

      plugins = {
        zjstatus.path = "${pkgs.zjstatus}/bin/zjstatus.wasm";
      };
    };
    extraConfig = builtins.readFile ./zellij.config.kdl;

    layouts = {

      devel = {
        layout = {
          default_tab_template = {
            children = [ ];
            pane = {
              size = 1;
              borderless = true;
              plugin = {
                location = "file:${pkgs.zjstatus}/bin/zjstatus.wasm";
                border_enabled = false;
                hide_frame_for_single_pane = true;
                format_left = "#[reverse]{mode} {command_hostname}";
                format_center = "#[reverse]{session}:{tabs}";
                format_right = "#[reverse]{datetime}";
                format_space = "#[reverse]";

                mode_normal = "  ";
                mode_locked = "  ";
                mode_resize = " 󰩨 ";
                mode_pane = "  ";
                mode_tab = "  ";
                mode_scroll = " 󱕒 ";
                mode_session = "  ";
                mode_move = " 󰆾 ";

                tab_normal = "";
                tab_active = "#[reverse,bold]{index}";

                command_hostname_command = "hostname -s";
                command_hostname_format = "#[reverse]{stdout}";
                command_hostname_rendermode = "static";
                command_hostname_interval = "0";

                datetime = "#[reverse,italic] {format}";
                datetime_format = "%R";
                datetime_timezone = "Europe/Stockholm";
              };
            };
          };
          tab_template = {
            _props.name = "helix";
            pane.command = "hx";
          };
          _children = [
            {
              tab = {
                _props.name = "1";
                pane.command = "fish";
                pane.args = [
                  "-c"
                  "direnv exec . hx"
                ];
              };
            }
            { tab._props.name = "2"; }
            { tab._props.name = "3"; }
            { tab._props.name = "4"; }
            { tab._props.name = "5"; }
          ];
        };
      };

      zsm = {
        layout = {
          pane = {
            borderless = true;
            plugin = {
              location = "file:~/.config/zellij/plugins/zsm.wasm";
              floating = true;
              move_to_focused_tab = true;
              default_layout = "devel";
            };
          };
        };
      };

    };

  };

  home.file.".config/zellij/plugins/zsm.wasm".source = pkgs.fetchurl {
    url = "https://github.com/liam-mackie/zsm/releases/download/v0.4.1/zsm.wasm";
    sha256 = "sha256-+VCf9MEHQVmr2q8lu95jAOsvCQU0iJa3ljqbnIC9ywg=";
  };

  home.file.".config/zellij/plugins/forgot.wasm".source = pkgs.fetchurl {
    url = "https://github.com/karimould/zellij-forgot/releases/download/0.4.2/zellij_forgot.wasm";
    sha256 = "sha256-MRlBRVGdvcEoaFtFb5cDdDePoZ/J2nQvvkoyG6zkSds=";
  };
}
