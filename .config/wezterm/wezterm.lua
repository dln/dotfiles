local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local config = {}

-- ------------------------------------------------------------------------------------
-- Workspace behavior

-- local nvim_args = { "nvim", "--listen", "$XDG_RUNTIME_DIR" .. "/nvim-persistent.sock" }
local nvim_args = { "nvim", "--listen", os.getenv("XDG_RUNTIME_DIR") .. "/nvim-persistent.sock" }

config.exec_domains = {
	wezterm.exec_domain("dev", function(cmd)
		local wrapped = { "/usr/bin/ssh", "-t", "dev" }
		for _, arg in ipairs(cmd.args or { os.getenv("SHELL") }) do
			table.insert(wrapped, arg)
		end
		cmd.args = wrapped
		return cmd
	end),
}

local function activate_nvim(window, pane)
	wezterm.log_info("nvim")
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

	local nvim_tab, nvim_pane, _ = window:mux_window():spawn_tab({ args = nvim_args })
	window:perform_action(act.MoveTab(0), nvim_pane)
	nvim_tab:set_title("nvim")
end

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
		local tab, _, _ = window:mux_window():spawn_tab({
			cwd = "~",
		})
		tab:set_title(title)
		window:perform_action(act.MoveTab(index), pane)
	end
end

wezterm.on("activate-nvim", activate_nvim)
wezterm.on("tab-2", activate_tab("t2", 1))
wezterm.on("tab-3", activate_tab("t3", 2))
wezterm.on("tab-4", activate_tab("t4", 3))
wezterm.on("tab-5", activate_tab("t5", 4))
wezterm.on("tab-6", activate_tab("t6", 5))
wezterm.on("tab-7", activate_tab("t7", 6))
wezterm.on("tab-8", activate_tab("t8", 7))
wezterm.on("tab-9", activate_tab("t9", 8))
wezterm.on("tab-10", activate_tab("t10", 9))

wezterm.on("user-var-changed", function(window, pane, name, _)
	if name == "nvim_activate" then
		activate_nvim(window, pane)
	end
end)

-- ------------------------------------------------------------------------------------
-- Appearance

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Shelman Dark"
	else
		return "Shelman Light"
	end
end

local function font_for_appearance(appearance)
	if appearance:find("Dark") then
		return wezterm.font({
			family = "IosevkaShelman Nerd Font",
			weight = "Light",
		})
	else
		return wezterm.font({
			family = "IosevkaShelman Nerd Font",
			--weight = "Regular",
		})
	end
end
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- ------------------------------------------------------------------------------------
-- Fonts
config.font = font_for_appearance(wezterm.gui.get_appearance())
config.font_rules = {
	{
		italic = true,
		intensity = "Bold",
		reverse = false,
		font = wezterm.font("IosevkaShelman Nerd Font", { weight = "ExtraLight", italic = true }),
		-- font = wezterm.font("Iosevka Term Curly Slab", { weight = "Thin", italic = true }),
	},

	{
		italic = true,
		intensity = "Normal",
		reverse = false,
		font = wezterm.font("IosevkaShelman Nerd Font", { weight = "Light", italic = true }),
	},
}
-- config.dpi = 192
config.font_size = 15
config.line_height = 1.0
config.warn_about_missing_glyphs = false
config.bold_brightens_ansi_colors = false
config.unicode_version = 14

-- Config
config.enable_wayland = true
config.term = "wezterm"
config.check_for_updates = false

-- UI
config.command_palette_font_size = 13.5
config.initial_cols = 132
config.initial_rows = 45
config.status_update_interval = 100
config.audible_bell = "Disabled"
config.use_resize_increments = true
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "RESIZE"
config.window_frame = {
	border_left_width = "4px",
	border_right_width = "4px",
	border_bottom_height = "4px",
	border_top_height = "4px",
	border_left_color = "#000000",
	border_right_color = "#000000",
	border_bottom_color = "#000000",
	border_top_color = "#000000",
}
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Hyperlinks
config.hyperlink_rules = wezterm.default_hyperlink_rules()

table.insert(config.hyperlink_rules, {
	regex = [[`rustc --explain E(\d+)`]],
	format = "https://doc.rust-lang.org/error_codes/E$1.html",
})

-- Tabs
config.enable_tab_bar = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = true

-- Cursor
config.default_cursor_style = "SteadyBlock"
config.cursor_thickness = "6px"
config.cursor_blink_rate = 700
config.hide_mouse_cursor_when_typing = false
config.underline_position = -9
config.underline_thickness = 1

-- Scrolling
config.enable_scroll_bar = false
config.scrollback_lines = 5000
config.alternate_buffer_wheel_scroll_speed = 1

-- Keys
config.disable_default_key_bindings = true
config.keys = {
	{ key = "c", mods = "ALT|SHIFT", action = act.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "v", mods = "ALT|SHIFT", action = act.PasteFrom("Clipboard") },
	{ key = "0", mods = "CTRL", action = "ResetFontSize" },
	{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },
	{ key = "=", mods = "CTRL", action = "IncreaseFontSize" },
	{ key = "UpArrow", mods = "SHIFT", action = act.ScrollByLine(-1) },
	{ key = "DownArrow", mods = "SHIFT", action = act.ScrollByLine(1) },
	{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-0.5) },
	{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(0.5) },
	{ key = "r", mods = "ALT", action = act.ReloadConfiguration },
	{ key = "o", mods = "ALT", action = act.ActivateCommandPalette },
	{ key = "Backspace", mods = "ALT", action = act.SwitchWorkspaceRelative(1) },
	{ key = "1", mods = "ALT", action = act.EmitEvent("activate-nvim") },
	{ key = "2", mods = "ALT", action = act.EmitEvent("tab-2") },
	{ key = "3", mods = "ALT", action = act.EmitEvent("tab-3") },
	{ key = "4", mods = "ALT", action = act.EmitEvent("tab-4") },
	{ key = "5", mods = "ALT", action = act.EmitEvent("tab-5") },
	{ key = "6", mods = "ALT", action = act.EmitEvent("tab-6") },
	{ key = "7", mods = "ALT", action = act.EmitEvent("tab-7") },
	{ key = "8", mods = "ALT", action = act.EmitEvent("tab-8") },
	{ key = "9", mods = "ALT", action = act.EmitEvent("tab-9") },
	{ key = "0", mods = "ALT", action = act.EmitEvent("tab-10") },
}

-- Mouse
config.mouse_bindings = {
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
}

return config
