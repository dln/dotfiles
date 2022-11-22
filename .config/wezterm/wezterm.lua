local wezterm = require 'wezterm';

function font_with_fallback(name, params)
  local names = { name, "Noto Color Emoji", "Iosevka Nerd Font Mono" }
  return wezterm.font_with_fallback(names, params)
end

local theme = {
  colors = {
    foreground    = "#000000",
    background    = "#fcfcfc",
    cursor_bg     = "#ff3300",
    cursor_fg     = "#ffffff",
    cursor_border = "#cc0000",
    split         = "#444444",
    selection_bg  = "#FFCA28",
    ansi          = { "#212121", "#b7141e", "#457b23", "#f5971d", "#134eb2", "#550087", "#0e707c", "#eeeeee" },
    brights       = { "#424242", "#e83a3f", "#7aba39", "#fee92e", "#53a4f3", "#a94dbb", "#26bad1", "#d8d8d8" },
  }
};

return {
  colors = theme.colors,
  window_frame = {
    border_left_width = '4px',
    border_right_width = '4px',
    border_bottom_height = '4px',
    border_top_height = '4px',
    border_left_color = '#000000',
    border_right_color = '#000000',
    border_bottom_color = '#000000',
    border_top_color = '#000000',
  },
  font = font_with_fallback("Iosevka Term SS09", { weight = "Regular" }),
  font_rules = {
    {
      italic = false,
      intensity = "Half",
      font = font_with_fallback("Iosevka Term SS09", { weight = "Thin" })
    },
    {
      italic = true,
      intensity = "Normal",
      font = font_with_fallback("Iosevka Term Curly Slab", { weight = "Light", italic = true })
    },
    {
      italic = true,
      intensity = "Bold",
      font = font_with_fallback("Iosevka SS15", { weight = "ExtraLight", italic = true })
    },
    {
      intensity = "Bold",
      font = font_with_fallback("Iosevka Term SS09", { weight = "DemiBold" })
    },
  },
  freetype_load_target = "Light",
  warn_about_missing_glyphs = false,
  bold_brightens_ansi_colors = false,

  font_size = 12.5,
  line_height = 1.1,

  initial_cols = 128,
  initial_rows = 45,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  default_cursor_style = 'SteadyBlock',
  cursor_thickness = "3px",
  cursor_blink_rate = 0,

  enable_wayland = true,
  enable_tab_bar = false,
  tab_bar_at_bottom = true,
  show_tab_index_in_tab_bar = true,
  enable_scroll_bar = false,
  window_decorations = "RESIZE",
  scrollback_lines = 5000,
  alternate_buffer_wheel_scroll_speed = 2,
  check_for_updates = false,
  status_update_interval = 100,
  audible_bell = "Disabled",
  term = "wezterm",

  disable_default_key_bindings = true,
  keys = {
    { key = "c", mods = "ALT|SHIFT", action = wezterm.action { CopyTo = "ClipboardAndPrimarySelection" } },
    { key = "v", mods = "ALT|SHIFT", action = "Paste" },
    { key = "0", mods = "CTRL", action = "ResetFontSize" },
    { key = "-", mods = "CTRL", action = "DecreaseFontSize" },
    { key = "=", mods = "CTRL", action = "IncreaseFontSize" },
    { key = "Enter", mods = "ALT", action = "ToggleFullScreen" },
  },
}
