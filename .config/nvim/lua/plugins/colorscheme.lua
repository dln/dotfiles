return {
	{
		"kvrohit/rasmus.nvim",
		dependencies = {
			{ "tjdevries/colorbuddy.nvim" },
		},
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.rasmus_variant = "monochrome"
			vim.g.rasmus_bold_functions = true
			vim.g.rasmus_bold_comments = false
			vim.g.rasmus_italic_comments = true
			vim.g.rasmus_transparent = true

			-- vim.cmd("colorscheme rasmus")
		end,
	},

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
						-- background = "#0d1219",
						background = "#11171d",
						-- background = "#1e2835",
						primary = "#FFECD3",
						secondary = "#B0BEC5",
						--
						diagnostic_info = "#00d992",
						diagnostic_hint = "#00d992",
					},
				})
				--
				local Color, colors, Group, groups, styles = require("colorbuddy").setup()
				Color.new("string", "#D7CCC8")
				Color.new("symbol", "#ECEFF1")
				--
				Color.new("comment", "#E57373", nil, styles.italic)
				Color.new("hlargs", "#FFF8E1")
				--
				Color.new("illuminate_bg", "#112210")
				Color.new("illuminate_fg", "#00d992")
				--
				-- Color.new("search_bg", "#554411")
				-- Color.new("search_fg", "#FFF0C0")
				--
				Color.new("search_bg", "#223311")
				Color.new("search_fg", "#CCFF33")
				--
				Color.new("MiniIndentscopeSymbol", "#00d992")
				Group.new("MiniIndentscopeSymbol", colors.MiniIndentscopeSymbol)
				--
				Color.new("CursorFg", "#000000", styles.nocombine)
				Color.new("CursorBg", "#00d992", styles.nocombine)
				Group.new("Cursor", colors.CursorFg, colors.CursorBg)
				Color.new("CursorLine", "#141b23")
				Group.new("CursorLine", nil, colors.CursorLine)
				--
				Color.new("NavicTextFg", "#5fbf9f")
				Color.new("NavicTextBg", "#333333")
				Color.new("NavicIcon", "#5fbf9f")
				--
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
				--
				Color.new("NormalFloatFg", "#b8d1ef", styles.nocombine)
				Color.new("NormalFloatBg", "#335a88", styles.nocombine)
				Group.new("NormalFloat", colors.NormalFloatFg, colors.NormalFloatBg)
				--
				Color.new("PmenuSelFg", "#f3d390", styles.nocombine)
				Color.new("PmenuSelBg", "#335a88", styles.nocombine)
				Group.new("PmenuSel", colors.PmenuSelFg, colors.PmenuSelBg)
				--
				-- Color.new("TroubleFg", "#ffce60", styles.nocombine)
				-- Color.new("TroubleBg", "#260200", styles.nocombine)
				-- Group.new("TroubleNormal", colors.TroubleFg, colors.TroubleBg)
				-- Group.link("TroubleText", groups.TroubleNormal)
				-- Group.link("TroubleSource", groups.TroubleNormal)
				--
				Color.new("Error", "#ffce60", styles.nocombine)
				Group.new("ErrorMsg", colors.Error)
				--
				Color.new("FlashLabelFg", "#220011")
				Color.new("FlashLabelBg", "#EA1199")
				Group.new("FlashLabel", colors.FlashLabelFg, colors.FlashLabelBg)
				--
				Group.new("TelescopeTitle", colors.primary)
				Group.new("TelescopeBorder", colors.secondary)
				Group.new("@comment", colors.comment, nil, styles.italic)
				Group.new("@string", colors.string, nil, styles.italic)
				--
				Group.new("@keyword", colors.noir_2)
				Group.new("@keyword.function", colors.noir_2)
				Group.new("@keyword.return", colors.noir_1)
				--
				Group.new("@operator", colors.noir_1)
				Group.new("@keyword.operator", colors.noir_1)
				-- Group.new("Hlargs", colors.noir_3, nil, styles.italic)
				Group.new("@type.builtin", colors.noir_2)
				--
				Group.new("@variable", colors.symbol, nil, styles.italic)
				Group.new("Hlargs", colors.hlargs, nil, styles.italic)
				--
				Group.new("@function", colors.noir_1, nil, styles.bold)
				Group.new("@method", colors.noir_1, nil, styles.bold)
				--
				Group.new("@punctuation", colors.noir_4)
				Group.new("@punctuation.bracket", colors.noir_4)
				Group.new("@punctuation.delimiter", colors.noir_4)
				--
				Group.new("IlluminatedWordText", colors.illuminate_fg, colors.illuminate_bg)
				--
				Group.new("Search", colors.search_fg, colors.search_bg, styles.italic + styles.undercurl)
				Group.new("IncSearch", colors.search_fg, colors.search_bg)
			end,
		},
	},
}
