local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local function font_with_fallback(name, params)
	local names = { name, "Noto Color Emoji" }
	return wezterm.font_with_fallback(names, params)
end

wezterm.on("gui-startup", function(cmd)
	local _, _, local_win = mux.spawn_window({
		workspace = "default",
	})

	mux.spawn_window({
		workspace = "dln-dev",
		domain = { DomainName = "dln-dev" },
	})

	mux.set_active_workspace("default")
end)

wezterm.on("mux-startup", function()
	local _, _, dev_win = mux.spawn_window({
		workspace = "dln-dev",
	})
end)

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Shelman Dark"
	else
		return "Shelman Light"
	end
end

local function _get_scheme()
	-- if wezterm.gui then
	-- return  return scheme_for_appearance(wezterm.gui.get_appearance())
	-- end
	return "Shelman Dark"
end

local is_server = wezterm.hostname() == "dln-dev"

local function activate_nvim(window, pane)
	wezterm.log_info("activate_nvim")
	for _, t in ipairs(window:mux_window():tabs_with_info()) do
		for _, p in ipairs(t.tab:panes()) do
			if p:get_title() == "nvim" then
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
end

wezterm.on("user-var-changed", function(window, pane, name, value)
	wezterm.log_info("user-var-changed", name, value)

	if name == "nvim_activate" then
		activate_nvim(window, pane)
	end
end)

local function activate_tab(title, index)
	return function(window, pane)
		wezterm.log_info(title)
		for _, t in ipairs(window:mux_window():tabs_with_info()) do
			if t.tab:get_title() == title then
				window:perform_action(
					act.Multiple({
						act.ActivateTab(t.index),
						act.MoveTab(index),
					}),
					pane
				)
				return
			end
		end
		local tab, _, _ = window:mux_window():spawn_tab({})
		tab:set_title(title)
		window:perform_action(act.MoveTab(index), pane)
	end
end

wezterm.on("tab-1", activate_nvim)
wezterm.on("tab-2", activate_tab("t2", 1))
wezterm.on("tab-3", activate_tab("t3", 2))
wezterm.on("tab-4", activate_tab("t4", 3))
wezterm.on("tab-5", activate_tab("t5", 4))
wezterm.on("tab-6", activate_tab("t6", 5))
wezterm.on("tab-7", activate_tab("t7", 6))
wezterm.on("tab-8", activate_tab("t8", 7))
wezterm.on("tab-9", activate_tab("t9", 8))
wezterm.on("tab-10", activate_tab("t10", 9))

return {
	color_scheme = _get_scheme(),
	color_scheme_dirs = { "/home/dln/.config/wezterm" },
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
	freetype_load_target = "Light",
	freetype_render_target = "HorizontalLcd",
	--freetype_load_flags = "NO_HINTING",
	--custom_block_glyphs = false,

	warn_about_missing_glyphs = false,
	bold_brightens_ansi_colors = false,
	allow_square_glyphs_to_overflow_width = "Always",
	font_size = 13.5,
	line_height = 1.0,
	cell_width = 0.95,
	initial_cols = 132,
	initial_rows = 45,
	use_resize_increments = true,
	window_background_opacity = 1.0,
	window_padding = {
		left = "0.75cell",
		right = "0.5cell",
		top = "0.25cell",
		bottom = "0cell",
	},
	colors = {
		tab_bar = {
			active_tab = {
				fg_color = "#e0e0e0",
				bg_color = "#374f66",
			},
		},
	},
	window_decorations = "RESIZE",
	window_frame = {
		border_left_width = "2px",
		border_right_width = "2px",
		border_bottom_height = "2px",
		border_top_height = "2px",
		border_left_color = "#333333",
		border_right_color = "#333333",
		border_bottom_color = "#333333",
		border_top_color = "#333333",
		inactive_titlebar_bg = "#21262e",
		active_titlebar_bg = "#252b34",
	},
	default_cursor_style = "SteadyBlock",
	cursor_thickness = "3px",
	cursor_blink_rate = 300,
	enable_wayland = true,
	enable_tab_bar = false,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = true,
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
		{ key = "c", mods = "ALT|SHIFT", action = act({ CopyTo = "ClipboardAndPrimarySelection" }) },
		{ key = "v", mods = "ALT|SHIFT", action = "Paste" },
		{ key = "0", mods = "CTRL", action = "ResetFontSize" },
		{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },
		{ key = "=", mods = "CTRL", action = "IncreaseFontSize" },
		{ key = "Enter", mods = "ALT", action = "ToggleFullScreen" },
		{ key = "r", mods = "ALT", action = act.ReloadConfiguration },
		-- mux
		{ key = "E", mods = "CTRL|SHIFT", action = act.DetachDomain({ DomainName = "dln-dev" }) },
		{ key = "1", mods = "ALT", action = act.EmitEvent("tab-1") },
		{ key = "2", mods = "ALT", action = act.EmitEvent("tab-2") },
		{ key = "3", mods = "ALT", action = act.EmitEvent("tab-3") },
		{ key = "4", mods = "ALT", action = act.EmitEvent("tab-4") },
		{ key = "5", mods = "ALT", action = act.EmitEvent("tab-5") },
		{ key = "6", mods = "ALT", action = act.EmitEvent("tab-6") },
		{ key = "7", mods = "ALT", action = act.EmitEvent("tab-7") },
		{ key = "8", mods = "ALT", action = act.EmitEvent("tab-8") },
		{ key = "9", mods = "ALT", action = act.EmitEvent("tab-9") },
		{ key = "0", mods = "ALT", action = act.EmitEvent("tab-10") },
		{ key = "RightArrow", mods = "CTRL", action = act.ActivateTabRelative(1) },
		{ key = "LeftArrow", mods = "CTRL", action = act.ActivateTabRelative(-1) },
		{ key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
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
	unix_domains = {
		{
			name = "dln-dev",
			local_echo_threshold_ms = 100,
			proxy_command = is_server == false and { "ssh", "dln-dev", "wezterm", "cli", "proxy" } or nil,
		},
	},
}
