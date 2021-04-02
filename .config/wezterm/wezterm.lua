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
  local names = {name, "Noto Color Emoji"}
  return wezterm.font_with_fallback(names, params)
end

return {
  -- automatically_reload_config = false,

  font = font_with_fallback("Iosevka Term SS09 Light"),
  font_rules = {
    {
      italic = false,
      intensity = "Half",
      font = font_with_fallback("Iosevka Term SS09 Thin")
    },
    {
      italic = true,
      intensity = "Normal",
      font = font_with_fallback("Iosevka Term SS09 Light", {italic=true})
    },
    {
      italic = true,
      intensity = "Bold",
      font = font_with_fallback("Iosevka Term Curly Slab XLt", {italic=true})
    },
    {
      intensity = "Bold",
      font = font_with_fallback("Iosevka Term SS09 Semibold")
    },
  },
  freetype_load_target = "HorizontalLcd",

  font_size = 12.0,
  line_height = 1.0,

  initial_cols = 120,
  initial_rows = 40,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  enable_tab_bar = true,
  show_tab_index_in_tab_bar = false,
  enable_scroll_bar = false,
  window_decorations = "NONE",
  scrollback_lines = 5000,
  alternate_buffer_wheel_scroll_speed = 2,
  check_for_updates = false,
  status_update_interval = 100,

  leader = { key="o", mods="CTRL", timeout_milliseconds=1000 },

  keys = {

    {key="c", mods="ALT|SHIFT", action="Copy"},
    {key="v", mods="ALT|SHIFT", action="Paste"},
    {key="n", mods="LEADER", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    {key="c", mods="LEADER", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    {key="k", mods="LEADER", action=wezterm.action{CloseCurrentTab={confirm=true}}},

    {key="LeftArrow", mods="CTRL", action=wezterm.action{ActivateTabRelative=-1}},
    {key="RightArrow", mods="CTRL", action=wezterm.action{ActivateTabRelative=1}},

    {key="1", mods="ALT", action=wezterm.action{ActivateTab=0}},
    {key="2", mods="ALT", action=wezterm.action{ActivateTab=1}},
    {key="3", mods="ALT", action=wezterm.action{ActivateTab=2}},
    {key="4", mods="ALT", action=wezterm.action{ActivateTab=3}},
    {key="5", mods="ALT", action=wezterm.action{ActivateTab=4}},
    {key="6", mods="ALT", action=wezterm.action{ActivateTab=5}},
    {key="7", mods="ALT", action=wezterm.action{ActivateTab=6}},
    {key="8", mods="ALT", action=wezterm.action{ActivateTab=7}},
    {key="9", mods="ALT", action=wezterm.action{ActivateTab=8}},
    {key="0", mods="ALT", action=wezterm.action{ActivateTab=9}},
  },

  colors = {
      foreground = "#ded9ce",
      background = "#171717",

      cursor_bg = "#FB8C00",
      -- cursor_fg = "black",
      cursor_border = "#FB8C00",

      split = "#444444",

      ansi = {
        "#000000",
        "#ff605a",
        "#b1e869",
        "#ead89c",
        "#5da9f6",
        "#e86aff",
        "#82fff6",
        "#ded9ce"
      },

      brights = {
        "#313131",
        "#f58b7f",
        "#dcf88f",
        "#eee5b2",
        "#a5c7ff",
        "#ddaaff",
        "#b6fff9",
        "#fefffe"
      }
  },

  ssh_domains = {
    {
      name = "dln-dev",
      remote_address = "dln-dev",
      username = "dln",
    }
  },

}