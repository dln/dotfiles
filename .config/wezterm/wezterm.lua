local wezterm = require 'wezterm';

local editPanes = {};
local editMarker = ":nvim";

-- Window titles are a perfectly fine IPC mechanism 😁

wezterm.on("update-right-status", function(window, pane)
  local title = pane:get_title();
  local pid = pane:pane_id();
  if editPanes[pid] ~= title and title:sub(-#editMarker) == editMarker then
    editPanes[pid] = title;
    window:perform_action(wezterm.action{ActivateTab=0}, pane);
  end
end);

function font_with_fallback(name, params)
  local names = {name, "Noto Color Emoji", "Iosevka Nerd Font Mono"}
  return wezterm.font_with_fallback(names, params)
end

local themeShelmanDark = {
  colors = {
    foreground    = "#ded9ce",
    background    = "#171a23",
    cursor_bg     = "#FB8C00",
    cursor_border = "#FB8C00",
    split         = "#444444",
    ansi    = { "#000000", "#ff605a", "#b1e869", "#ead89c", "#5da9f6", "#e86aff", "#82fff6", "#ded9ce" },
    brights = { "#313131", "#f58b7f", "#dcf88f", "#eee5b2", "#a5c7ff", "#ddaaff", "#b6fff9", "#fefffe" },
    tab_bar = {
      background = "#000000",
      active_tab         = { bg_color = "#171a23", fg_color = "#c0b070", intensity = "Normal", },
      inactive_tab       = { bg_color = "#000000", fg_color = "#c0c0c0", intensity = "Half", },
      inactive_tab_hover = { bg_color = "#333333", fg_color = "#909090", italic = true, }
    }
  },

  tab_bar_style = {
    active_tab_left          = wezterm.format({ {Background={Color="#171a23"}}, {Foreground={Color="#000000"}}, {Text=" "} }),
    active_tab_right         = wezterm.format({ {Background={Color="#171a23"}}, {Foreground={Color="#000000"}}, {Text=" "} }),
    inactive_tab_left        = wezterm.format({ {Background={Color="#000000"}}, {Foreground={Color="#171a23"}}, {Text=" "} }),
    inactive_tab_right       = wezterm.format({ {Background={Color="#000000"}}, {Foreground={Color="#171a23"}}, {Text="▕"} }),
    inactive_tab_hover_left  = wezterm.format({ {Background={Color="#333333"}}, {Foreground={Color="#ffffff"}}, {Text=" "} }),
    inactive_tab_hover_right = wezterm.format({ {Background={Color="#333333"}}, {Foreground={Color="#ffffff"}}, {Text=" "} }),
  },
};

local themeShelmanLight = {
  colors = {
    foreground    = "#000000",
    background    = "#fcfcfc",
    cursor_bg     = "#ff3300",
    cursor_fg     = "#ffffff",
    cursor_border = "#cc0000",
    selection_bg  = "#FFEA00",
    split         = "#444444",
    selection_bg  = "#FFCA28",
    ansi    = { "#212121", "#b7141e", "#457b23", "#f5971d", "#134eb2", "#550087", "#0e707c", "#eeeeee" },
    brights = { "#424242", "#e83a3f", "#7aba39", "#fee92e", "#53a4f3", "#a94dbb", "#26bad1", "#d8d8d8" },

    tab_bar = {
      background = "#556677",
      active_tab         = { bg_color = "#f7f7f7", fg_color = "#000000", intensity = "Normal", },
      inactive_tab       = { bg_color = "#778899", fg_color = "#000000", intensity = "Half", },
      inactive_tab_hover = { bg_color = "#333333", fg_color = "#909090", italic = true, }
    }
  },

  tab_bar_style = {
    active_tab_left          = wezterm.format({ {Background={Color="#f7f7f7"}}, {Foreground={Color="#000000"}}, {Text=" "} }),
    active_tab_right         = wezterm.format({ {Background={Color="#f7f7f7"}}, {Foreground={Color="#000000"}}, {Text=" "} }),
    inactive_tab_left        = wezterm.format({ {Background={Color="#778899"}}, {Foreground={Color="#f7f7f7"}}, {Text=" "} }),
    inactive_tab_right       = wezterm.format({ {Background={Color="#778899"}}, {Foreground={Color="#333333"}}, {Text="▕"} }),
    inactive_tab_hover_left  = wezterm.format({ {Background={Color="#333333"}}, {Foreground={Color="#ffffff"}}, {Text=" "} }),
    inactive_tab_hover_right = wezterm.format({ {Background={Color="#333333"}}, {Foreground={Color="#ffffff"}}, {Text=" "} }),
  },
};


local theme = themeShelmanLight;

return {
  colors = theme.colors,
  tab_bar_style = theme.tab_bar_style,
  -- automatically_reload_config = false,
  font = font_with_fallback("Iosevka Term SS09", {weight="Regular"}),
  -- font = wezterm.font("Iosevka Term SS09", {weight="Regular"}),
  font_rules = {
    {
      italic = false,
      intensity = "Half",
      font = font_with_fallback("Iosevka Term SS09", {weight="Thin"})
    },
    {
      italic = true,
      intensity = "Normal",
      -- font = font_with_fallback("Iosevka Aile", {weight="Regular", italic=true})
      font = font_with_fallback("Iosevka Term Curly Slab", {weight="Regular", italic=true})
    },
    {
      italic = true,
      intensity = "Bold",
      font = font_with_fallback("Iosevka Term Curly Slab", {weight="Light", italic=true})
    },
    {
      intensity = "Bold",
      font = font_with_fallback("Iosevka Term SS09", {weight="DemiBold"})
    },
  },
  -- freetype_load_target = "HorizontalLcd",
  freetype_load_target = "Light",
  -- freetype_interpreter_version = 40,
  -- freetype_load_flags = "FORCE_AUTOHINT",
  warn_about_missing_glyphs = false,

  bold_brightens_ansi_colors = false,

  font_size = 12.5,
  line_height = 1.0,

  initial_cols = 110,
  initial_rows = 49,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

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

  launch_menu = {
    {
      label = "dln-dev",
      args = {"ssh", "dln-dev"},
    },
  },

  disable_default_key_bindings = true,

  leader = { key="o", mods="CTRL|SHIFT", timeout_milliseconds=1000 },
  keys = {

    {key="c", mods="ALT|SHIFT", action="Copy"},
    {key="v", mods="ALT|SHIFT", action="Paste"},
    {key="n", mods="LEADER", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    {key="c", mods="LEADER", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    {key="k", mods="LEADER", action=wezterm.action{CloseCurrentTab={confirm=true}}},
    {key="l", mods="LEADER", action="ShowLauncher"},

    {key="0", mods="CTRL", action="ResetFontSize"},
    {key="-", mods="CTRL", action="DecreaseFontSize"},
    {key="=", mods="CTRL", action="IncreaseFontSize"},
    {key="Enter", mods="ALT", action="ToggleFullScreen"},

    --[[
    {key="LeftArrow", mods="CTRL", action=wezterm.action{ActivateTabRelative=-1}},
    {key="RightArrow", mods="CTRL", action=wezterm.action{ActivateTabRelative=1}},
    {key="RightArrow", mods="CTRL|SHIFT", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    ]]

    --[[ {key="1", mods="ALT", action=wezterm.action{ActivateTab=0}},
    {key="2", mods="ALT", action=wezterm.action{ActivateTab=1}},
    {key="3", mods="ALT", action=wezterm.action{ActivateTab=2}},
    {key="4", mods="ALT", action=wezterm.action{ActivateTab=3}},
    {key="5", mods="ALT", action=wezterm.action{ActivateTab=4}},
    {key="6", mods="ALT", action=wezterm.action{ActivateTab=5}},
    {key="7", mods="ALT", action=wezterm.action{ActivateTab=6}},
    {key="8", mods="ALT", action=wezterm.action{ActivateTab=7}},
    {key="9", mods="ALT", action=wezterm.action{ActivateTab=8}},
    {key="0", mods="ALT", action=wezterm.action{ActivateTab=9}}, ]]
  },


  -- ssh_domains = {
  --   {
  --     name = "dln-dev",
  --     remote_address = "dln-dev",
  --     username = "dln",
  --   }
  -- },

}
