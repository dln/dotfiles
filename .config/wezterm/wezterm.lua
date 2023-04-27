local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local dev_host = "dln-dev"
local spawn_dev_nvim = { "ssh", dev_host, "nvim", "--listen", os.getenv("XDG_RUNTIME_DIR") .. "/nvim-persistent.sock" }

local function font_with_fallback(name, params)
	local names = { name, "Noto Color Emoji" }
	return wezterm.font_with_fallback(names, params)
end

wezterm.on("gui-startup", function(cmd)
	local args = {}
	if cmd then
		args = cmd.args
	end

	local tab, pane, window = mux.spawn_window({
		workspace = "local",
		args = { "nvim", "--listen", os.getenv("XDG_RUNTIME_DIR") .. "/nvim-persistent.sock" },
	})
	tab:set_title("nvim")

	for _ = 1, 9 do
		window:spawn_tab({})
	end
	window:gui_window():perform_action(act.ActivateTab(1), pane)

	local tab, pane, window = mux.spawn_window({
		workspace = dev_host,
		args = spawn_dev_nvim,
	})
	tab:set_title("nvim")

	for _ = 1, 9 do
		window:spawn_tab({ args = { "ssh", dev_host } })
	end

	mux.set_active_workspace("local")
end)

local function activate_nvim(window, pane)
	for _, t in ipairs(window:mux_window():tabs_with_info()) do
		for _, p in ipairs(t.tab:panes()) do
			if p:get_title() == "nvim" or t.tab:get_title() == "nvim" then
				window:perform_action(
					act.Multiple({
						act.ActivateTab(t.index),
						act.MoveTab(0),
					}),
					pane
				)
				return
			end
		end
	end

	local nvim = { "nvim", "--listen", os.getenv("XDG_RUNTIME_DIR") .. "/nvim-persistent.sock" }
	if window:mux_window():get_workspace() == dev_host then
		nvim = spawn_dev_nvim
	end

	local tab, pane, _ = window:mux_window():spawn_tab({ args = nvim })
	window:perform_action(act.MoveTab(0), pane)
	tab:set_title("nvim")
end

wezterm.on("user-var-changed", function(window, pane, name, value)
	if name == "nvim_activate" then
		activate_nvim(window, pane)
	end
end)

wezterm.on("activate-nvim", activate_nvim)

wezterm.add_to_config_reload_watch_list(os.getenv("HOME") .. "/.config/shelman-theme/current/wezterm")

return {
	color_scheme = "Shelman Theme",
	color_scheme_dirs = {
		os.getenv("HOME") .. "/.config/shelman-theme/current/wezterm",
	},
	font = font_with_fallback("Iosevka Shelman SS09", { weight = "Regular" }),
	font_rules = {
		{
			italic = false,
			intensity = "Half",
			font = font_with_fallback("Iosevka Shelman SS09", { weight = "Thin" }),
		},
		{
			italic = true,
			intensity = "Normal",
			font = font_with_fallback("Iosevka Shelman Curly Slab", { weight = "Light", italic = true }),
		},
		{
			italic = true,
			intensity = "Bold",
			font = font_with_fallback("Iosevka Shelman SS15", { weight = "ExtraLight", italic = true }),
		},
		{
			intensity = "Bold",
			font = font_with_fallback("Iosevka Shelman SS09", { weight = "DemiBold" }),
		},
	},
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",
	warn_about_missing_glyphs = false,
	bold_brightens_ansi_colors = false,
	allow_square_glyphs_to_overflow_width = "Always",
	font_size = 13.5,
	command_palette_font_size = 13.5,
	line_height = 1.0,
	cell_width = 0.95,
	initial_cols = 132,
	initial_rows = 45,
	use_resize_increments = true,
	window_background_opacity = 1.0,
	colors = {
		tab_bar = {
			active_tab = {
				fg_color = "#e0e0e0",
				bg_color = "#374f66",
			},
		},
	},
	default_cursor_style = "SteadyBlock",
	cursor_thickness = "3px",
	cursor_blink_rate = 0,
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
		-- mux
		{ key = "1", mods = "ALT", action = act.EmitEvent("activate-nvim") },
		{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
		{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
		{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
		{ key = "5", mods = "ALT", action = act.ActivateTab(4) },
		{ key = "6", mods = "ALT", action = act.ActivateTab(5) },
		{ key = "7", mods = "ALT", action = act.ActivateTab(6) },
		{ key = "8", mods = "ALT", action = act.ActivateTab(7) },
		{ key = "9", mods = "ALT", action = act.ActivateTab(8) },
		{ key = "0", mods = "ALT", action = act.ActivateTab(9) },
		{ key = "RightArrow", mods = "CTRL", action = act.ActivateTabRelative(1) },
		{ key = "LeftArrow", mods = "CTRL", action = act.ActivateTabRelative(-1) },
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
