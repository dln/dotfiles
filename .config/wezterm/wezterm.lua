local wezterm = require("wezterm")
local io = require("io")
local os = require("os")
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
	for _ = 1, 10 do
		local_win:spawn_tab({})
	end

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
	for _ = 1, 10 do
		dev_win:spawn_tab({})
	end
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

wezterm.on("user-var-changed", function(window, pane, name, value)
	wezterm.log_info("user-var-changed", name, value)

	if name == "nvim_activate" then
		for _, t in ipairs(window:mux_window():tabs_with_info()) do
			for _, p in ipairs(t.tab:panes()) do
				if p:get_title() == "nvim" then
					window:perform_action(act.ActivateTab(t.index), p)
					if t.index > 0 then
						window:perform_action(act.MoveTab(0), p)
					end
				end
			end
		end
		-- window:perform_action(act.ActivateTab(0), pane)
	end
end)

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
	-- initial_cols = 128,
	-- initial_rows = 45,
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
	alternate_buffer_wheel_scroll_speed = 2,
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
		{ key = "1", mods = "ALT", action = act({ ActivateTab = 0 }) },
		{ key = "2", mods = "ALT", action = act({ ActivateTab = 1 }) },
		{ key = "3", mods = "ALT", action = act({ ActivateTab = 2 }) },
		{ key = "4", mods = "ALT", action = act({ ActivateTab = 3 }) },
		{ key = "5", mods = "ALT", action = act({ ActivateTab = 4 }) },
		{ key = "6", mods = "ALT", action = act({ ActivateTab = 5 }) },
		{ key = "7", mods = "ALT", action = act({ ActivateTab = 6 }) },
		{ key = "8", mods = "ALT", action = act({ ActivateTab = 7 }) },
		{ key = "9", mods = "ALT", action = act({ ActivateTab = 8 }) },
		{ key = "0", mods = "ALT", action = act({ ActivateTab = 9 }) },
		{ key = "RightArrow", mods = "CTRL", action = act.ActivateTabRelative(1) },
		{ key = "LeftArrow", mods = "CTRL", action = act.ActivateTabRelative(-1) },
		{ key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
		{ key = "Backspace", mods = "ALT", action = act.SwitchWorkspaceRelative(1) },
	},
	unix_domains = {
		{
			name = "dln-dev",
			local_echo_threshold_ms = 100,
			proxy_command = is_server == false and { "ssh", "dln-dev", "wezterm", "cli", "proxy" } or nil,
		},
	},
}
