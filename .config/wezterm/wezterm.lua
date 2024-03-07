local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local dev_host = "dln-dev"
local spawn_dev_nvim = { "ssh", dev_host, "nvim", "--listen", os.getenv("XDG_RUNTIME_DIR") .. "/nvim-persistent.sock" }

-- local function font_with_fallback(name, params)
-- 	local names = { name, "Noto Color Emoji" }
-- 	return wezterm.font_with_fallback(names, params)
-- end
--
wezterm.add_to_config_reload_watch_list(os.getenv("HOME") .. "/.config/shelman-theme/current/wezterm")

return {
	color_scheme = "Shelman Theme",
	color_scheme_dirs = {
		os.getenv("HOME") .. "/.config/shelman-theme/current/wezterm",
	},
	font = wezterm.font({ family = "IosevkaShelman Nerd Font" }),
	font_rules = {
		{
			italic = false,
			intensity = "Half",
			reverse = false,
			font = wezterm.font("IosevkaShelman Nerd Font", { weight = "ExtraLight" }),
		},
		{
			italic = true,
			intensity = "Normal",
			reverse = false,
			font = wezterm.font("IosevkaShelman Nerd Font", { weight = "ExtraLight", italic = true }),
		},
	},
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",
	warn_about_missing_glyphs = false,
	bold_brightens_ansi_colors = false,
	-- allow_square_glyphs_to_overflow_width = "Always",
	font_size = 16,
	command_palette_font_size = 13.5,
	initial_cols = 132,
	initial_rows = 45,
	use_resize_increments = true,
	adjust_window_size_when_changing_font_size = false,
	window_decorations = "RESIZE",
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	unicode_version = 14,
	default_cursor_style = "SteadyBlock",
	cursor_thickness = "6px",
	cursor_blink_rate = 0,
	hide_mouse_cursor_when_typing = false,
	underline_position = -12,
	underline_thickness = 2,
	enable_wayland = true,
	enable_tab_bar = false,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	show_tab_index_in_tab_bar = true,
	enable_scroll_bar = false,
	scrollback_lines = 5000,
	alternate_buffer_wheel_scroll_speed = 1,
	check_for_updates = false,
	status_update_interval = 100,
	audible_bell = "Disabled",
	term = "wezterm",
	disable_default_key_bindings = true,
	keys = {
		{ key = "c", mods = "ALT|SHIFT", action = act.CopyTo("ClipboardAndPrimarySelection") },
		{ key = "v", mods = "ALT|SHIFT", action = act.PasteFrom("Clipboard") },
		{ key = "0", mods = "CTRL", action = "ResetFontSize" },
		{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },
		{ key = "=", mods = "CTRL", action = "IncreaseFontSize" },
		{ key = "Enter", mods = "ALT", action = "ToggleFullScreen" },
		{ key = "r", mods = "ALT", action = act.ReloadConfiguration },
		{ key = "L", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
		{ key = "l", mods = "ALT", action = wezterm.action.ActivateCommandPalette },
		{ key = "Backspace", mods = "ALT", action = act.SwitchWorkspaceRelative(1) },
		{ key = "UpArrow", mods = "SHIFT", action = act.ScrollByLine(-1) },
		{ key = "DownArrow", mods = "SHIFT", action = act.ScrollByLine(1) },
		{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-0.5) },
		{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(0.5) },
	},
	mouse_bindings = {
		{
			event = { Down = { streak = 1, button = { WheelUp = 1 } } },
			mods = "SHIFT",
			action = act.ScrollByLine(-1),
		},
		{
			event = { Down = { streak = 1, button = { WheelDown = 1 } } },
			mods = "SHIFT",
			action = act.ScrollByLine(1),
		},
		{
			event = { Down = { streak = 1, button = { WheelUp = 1 } } },
			action = act.ScrollByPage(-0.25),
		},
		{
			event = { Down = { streak = 1, button = { WheelDown = 1 } } },
			action = act.ScrollByPage(0.25),
		},
	},
}
