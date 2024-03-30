return {
	--[=====[
	{ "echasnovski/mini.colors", version = false },

	{
		"shelmangroup/sumi-e",
		dir = "/home/dln/src/git.shelman.io/shelmangroup/sumi-e.nvim",
		lazy = false,
		dependencies = {
			{ "tjdevries/colorbuddy.nvim" },
		},
	},

	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "sumi-e",
		},
	},

  --]=====]

	{
		"jesseleite/nvim-noirbuddy",
		as = "noirbuddy",
		lazy = false,
		dependencies = {
			{ "tjdevries/colorbuddy.nvim" },
		},
	},

	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = function()
				require("noirbuddy").setup({
					preset = "slate",
					styles = {
						italic = true,
						bold = true,
						underline = true,
						undercurl = true,
					},
					colors = {
						background = "#11171d",
						primary = "#FFECD3",
						secondary = "#B0BEC5",
						--
						diagnostic_info = "#00d992",
						diagnostic_hint = "#00d992",
					},
				})
				--
				local colorbuddy = require("colorbuddy")
				local Color = colorbuddy.Color
				local colors = colorbuddy.colors
				local Group = colorbuddy.Group
				local groups = colorbuddy.groups
				local styles = colorbuddy.styles

				Color.new("ColorColumn", "#171e26")
				Group.new("ColorColumn", nil, colors.ColorColumn)

				Color.new("normal", "#e3e0cd")
				Group.new("Normal", colors.normal, nil)

				Color.new("WinSeparator", "#223344")
				Group.new("WinSeparator", colors.WinSeparator, nil)

				Color.new("string", "#D7CCC8")
				Color.new("symbol", "#ECEFF1")

				Color.new("comment", "#E57373", nil, styles.italic)
				Color.new("hlargs", "#FFF8E1")

				Color.new("illuminate_bg", "#112210")
				Color.new("illuminate_fg", "#00d992")

				Color.new("search_bg", "#223311")
				Color.new("search_fg", "#CCFF33")

				Color.new("MiniIndentscopeSymbol", "#00d992")
				Group.new("MiniIndentscopeSymbol", colors.MiniIndentscopeSymbol)

				Color.new("CursorFg", "#000000", styles.nocombine)
				Color.new("CursorBg", "#23fdb6", styles.nocombine)
				Group.new("Cursor", colors.CursorFg, colors.CursorBg)
				Color.new("CursorLine", "#141b23")
				Group.new("CursorLine", nil, colors.CursorLine)

				-- Color.new("TroubleBg", "#171e26")
				Color.new("TroubleFg", "#e1d4c1")
				Color.new("TroubleBg", "#10161d")
				-- Color.new("TroubleBg", "#1d140f")
				Group.new("TroubleNormal", colors.TroubleFg, colors.TroubleBg)

				Color.new("NavicTextFg", "#5fbf9f")
				Color.new("NavicTextBg", "#333333")
				Color.new("NavicIcon", "#5fbf9f")

				Group.new("NavicText", colors.NavicTextFg, colors.NavicTextBg)
				Group.new("NavicIcon", colors.NavicIcon, colors.NavicTextBg)
				Group.link("NavicIconsFile", groups.NavicIcon)
				Group.link("NavicIconsModule", groups.NavicIcon)
				Group.link("NavicIconsNamespace", groups.NavicIcon)
				Group.link("NavicIconsPackage", groups.NavicIcon)
				Group.link("NavicIconsClass", groups.NavicIcon)
				Group.link("NavicIconsMethod", groups.NavicIcon)
				Group.link("NavicIconsProperty", groups.NavicIcon)
				Group.link("NavicIconsField", groups.NavicIcon)
				Group.link("NavicIconsConstructor", groups.NavicIcon)
				Group.link("NavicIconsEnum", groups.NavicIcon)
				Group.link("NavicIconsInterface", groups.NavicIcon)
				Group.link("NavicIconsFunction", groups.NavicIcon)
				Group.link("NavicIconsVariable", groups.NavicIcon)
				Group.link("NavicIconsConstant", groups.NavicIcon)
				Group.link("NavicIconsString", groups.NavicIcon)
				Group.link("NavicIconsNumber", groups.NavicIcon)
				Group.link("NavicIconsBoolean", groups.NavicIcon)
				Group.link("NavicIconsArray", groups.NavicIcon)
				Group.link("NavicIconsObject", groups.NavicIcon)
				Group.link("NavicIconsKey", groups.NavicIcon)
				Group.link("NavicIconsNull", groups.NavicIcon)
				Group.link("NavicIconsEnumMember", groups.NavicIcon)
				Group.link("NavicIconsStruct", groups.NavicIcon)
				Group.link("NavicIconsEvent", groups.NavicIcon)
				Group.link("NavicIconsOperator", groups.NavicIcon)
				Group.link("NavicIconsTypeParameter", groups.NavicIcon)

				Color.new("NormalFloatFg", "#b8d1ef", styles.nocombine)
				Color.new("NormalFloatBg", "#335a88", styles.nocombine)
				Group.new("NormalFloat", colors.NormalFloatFg, colors.NormalFloatBg)

				Color.new("PmenuSelFg", "#f3d390", styles.nocombine)
				Color.new("PmenuSelBg", "#335a88", styles.nocombine)
				Group.new("PmenuSel", colors.PmenuSelFg, colors.PmenuSelBg)

				Color.new("PmenuSelBg", "#335a88", styles.nocombine)
				Group.new("PmenuSel", colors.PmenuSelFg, colors.PmenuSelBg)

				Color.new("TreesitterContext", "#242e38", styles.nocombine)
				Group.new("TreesitterContext", nil, colors.TreesitterContext)

				-- Color.new("NonText", "#955252", styles.nocombine)
				Color.new("NonText", "#955252", styles.nocombine)

				Color.new("comment2", "#51a0cf")
				Group.new("Comment", colors.NonText, nil, styles.italic + styles.bold)
				Group.new("LspInlayHint", colors.comment2, nil, styles.italic)

				Group.new("NonText", colors.NonText, nil, styles.italic)
				Group.new("NonText", colors.NonText, nil, styles.italic)

				Color.new("spelling", "#ffce60")
				Group.new("SpellBad", colors.spelling, nil, styles.undercurl)

				-- Color.new("LuaLineFg", "#aebed0")
				Color.new("InclineFg", "#aebed0")
				Color.new("InclineBg", "#242e38")
				Group.new("InclineNormal", colors.InclineFg, colors.InclineBg)
				Group.new("InclineNormalNC", colors.InclineFg, colors.InclineBg)

				Color.new("LspInfoTitle", "#955252")
				Group.new("LspInfoTitle", colors.LspInfoTitle, nil, styles.italic)
				-- Group.new("DiagnosticHint", colors.LspInfoTitle, nil, styles.italic)
				--
				-- Color.new("TroubleFg", "#ffce60", styles.nocombine)
				-- Color.new("TroubleFg", "#ffce60", styles.nocombine)
				-- Color.new("TroubleBg", "#260200", styles.nocombine)
				-- Group.new("TroubleNormal", colors.TroubleFg, colors.TroubleBg)
				-- Group.link("TroubleText", groups.TroubleNormal)
				-- Group.link("TroubleSource", groups.TroubleNormal)
				--
				Color.new("Error", "#ffce60", styles.nocombine)
				Group.new("ErrorMsg", colors.Error)

				Color.new("FlashLabelFg", "#220011")
				Color.new("FlashLabelBg", "#EA1199")
				Group.new("FlashLabel", colors.FlashLabelFg, colors.FlashLabelBg)

				Group.new("TelescopeTitle", colors.primary)
				Group.new("TelescopeBorder", colors.secondary)
				Group.new("@comment", colors.comment, nil, styles.italic + styles.bold)
				Group.new("@string", colors.string, nil, styles.italic)

				Group.new("@keyword", colors.noir_2)
				Group.new("@keyword.function", colors.noir_2)
				Group.new("@keyword.return", colors.noir_1)

				Group.new("@operator", colors.noir_1)
				Group.new("@keyword.operator", colors.noir_1)
				-- Group.new("Hlargs", colors.noir_3, nil, styles.italic)
				Group.new("@type.builtin", colors.noir_2)

				Group.new("@variable", colors.symbol, nil)
				Group.new("Hlargs", colors.hlargs, nil)

				Group.new("@function", colors.noir_1, nil, styles.bold)
				Group.new("@method", colors.noir_1, nil, styles.bold)

				Group.new("@punctuation", colors.noir_4)
				Group.new("@punctuation.bracket", colors.noir_4)
				Group.new("@punctuation.delimiter", colors.noir_4)

				Group.new("IlluminatedWordText", colors.illuminate_fg, colors.illuminate_bg)

				Group.new("Search", colors.search_fg, colors.search_bg, styles.italic + styles.undercurl)
				Group.new("IncSearch", colors.search_fg, colors.search_bg)
			end,
		},
	},
}
