return {

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
			-- colorscheme = "noirbuddy",
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
						primary = "#FFECB3",
						secondary = "#B0BEC5",
						-- background = "#1d2229",
						background = "#0d1219",
					},
				})

				local Color, colors, Group, groups, styles = require("colorbuddy").setup()
				Color.new("string", "#D7CCC8")
				Color.new("symbol", "#ECEFF1")
				--
				Color.new("comment", "#E57373", nil, styles.italic)
				Color.new("hlargs", "#FFF8E1")

				Color.new("illuminate_bg", "#112210")
				Color.new("illuminate_fg", "#66FFEE")

				-- Color.new("search_bg", "#554411")
				-- Color.new("search_fg", "#FFF0C0")
				--
				Color.new("search_bg", "#223311")
				Color.new("search_fg", "#CCFF33")

				Color.new("IndentBlanklineIndent5", "#E06C75", styles.nocombine)
				Color.new("IndentBlanklineIndent6", "#E5C07B", styles.nocombine)
				Color.new("IndentBlanklineIndent3", "#98C379", styles.nocombine)
				Color.new("IndentBlanklineIndent4", "#56B6C2", styles.nocombine)
				Color.new("IndentBlanklineIndent1", "#61AFEF", styles.nocombine)
				Color.new("IndentBlanklineIndent2", "#C678DD", styles.nocombine)
				Group.new("IndentBlanklineIndent1", colors.IndentBlanklineIndent1:dark(0.2))
				Group.new("IndentBlanklineIndent2", colors.IndentBlanklineIndent2:dark(0.2))
				Group.new("IndentBlanklineIndent3", colors.IndentBlanklineIndent3:dark(0.2))
				Group.new("IndentBlanklineIndent4", colors.IndentBlanklineIndent4:dark(0.2))
				Group.new("IndentBlanklineIndent5", colors.IndentBlanklineIndent5:dark(0.2))
				Group.new("IndentBlanklineIndent6", colors.IndentBlanklineIndent6:dark(0.2))

				Color.new("IndentBlanklineContextChar", "#00AABB", styles.nocombine)
				Group.new("IndentBlanklineContextChar", colors.IndentBlanklineContextChar)

				Color.new("MiniIndentscopeSymbol", "#57FAF0")
				Group.new("MiniIndentscopeSymbol", colors.MiniIndentscopeSymbol)

				Group.new("TelescopeTitle", colors.primary)
				Group.new("TelescopeBorder", colors.secondary)
				Group.new("@comment", colors.comment, nil, styles.italic)
				Group.new("@string", colors.string, nil, styles.italic)

				Group.new("@keyword", colors.noir_2)
				Group.new("@keyword.function", colors.noir_2)
				Group.new("@keyword.return", colors.noir_1)

				Group.new("@operator", colors.noir_1)
				Group.new("@keyword.operator", colors.noir_1)
				-- Group.new("Hlargs", colors.noir_3, nil, styles.italic)
				Group.new("@type.builtin", colors.noir_2)

				Group.new("@variable", colors.symbol, nil, styles.italic)
				Group.new("Hlargs", colors.hlargs, nil, styles.italic)

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
