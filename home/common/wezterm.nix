{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.patagia.desktop.enable {
    programs.wezterm = {
      enable = true;
      colorSchemes = {
        patagiaLight = {
          ansi = [
            "#222222"
            "#D14949"
            "#48874F"
            "#AFA75A"
            "#599797"
            "#8F6089"
            "#5C9FA8"
            "#8C8C8C"
          ];
          brights = [
            "#444444"
            "#FF6D6D"
            "#89FF95"
            "#FFF484"
            "#97DDFF"
            "#FDAAF2"
            "#85F5DA"
            "#E9E9E9"
          ];
          background = "#fefeff";
          foreground = "#222222";
          cursor_bg = "#aa0000";
          cursor_border = "#aa0000";
          cursor_fg = "#1B1B1B";
          selection_bg = "#ffe6a4";
          selection_fg = "#483600";
        };
      };

      extraConfig = ''
        return {
          font = wezterm.font("Berkeley Mono", { weight = "Regular", stretch = "Normal" }),
          font_size = 16,
          -- freetype_load_target = "HorizontalLcd",
          freetype_load_target = "Light",
          -- font_size = 11,
          -- font_size = 11,
          -- freetype_load_target = "Normal",
          freetype_load_flags = "NO_AUTOHINT",
          color_scheme = "patagiaLight",
          check_for_updates = false,
          custom_block_glyphs = false,
          warn_about_missing_glyphs = false,
          bold_brightens_ansi_colors = false,
          unicode_version = 14,
          allow_square_glyphs_to_overflow_width = "Always",
          xcursor_theme = "Adwaita",
          hide_mouse_cursor_when_typing = false,
          tab_bar_at_bottom = true,
          use_fancy_tab_bar = false,
          show_tab_index_in_tab_bar = true,
          underline_position = -4,
          underline_thickness = 2,
          --line_height = 0.95,
        }
      '';

    };
  };
}
