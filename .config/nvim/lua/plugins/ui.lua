local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	local colorbuddy = require("colorbuddy")
	local Color = colorbuddy.Color
	local colors = colorbuddy.colors
	local Group = colorbuddy.Group
	local groups = colorbuddy.groups
	local styles = colorbuddy.styles
	Color.new("IndentBlanklineIndent", "#1e2835", styles.nocombine)
	Group.new("IndentBlanklineIndent1", colors.IndentBlanklineIndent:light(0.1))
	Group.new("IndentBlanklineIndent2", colors.IndentBlanklineIndent:light(0.15))
	Group.new("IndentBlanklineIndent3", colors.IndentBlanklineIndent:light(0.2))
	Group.new("IndentBlanklineIndent4", colors.IndentBlanklineIndent:light(0.25))
	Group.new("IndentBlanklineIndent5", colors.IndentBlanklineIndent:light(0.3))
	Group.new("IndentBlanklineIndent6", colors.IndentBlanklineIndent:light(0.35))

	Color.new("IndentBlanklineContextChar", "#f0a972", styles.nocombine)
	Group.new("IndentBlanklineContextChar", colors.IndentBlanklineContextChar)
end)

return {
	{
		"akinsho/bufferline.nvim",
		enabled = false,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		dependencies = {
			{ "tjdevries/colorbuddy.nvim" },
		},
		main = "ibl",
		opts = {
			indent = {
				char = "┊",
				tab_char = "┊",
				highlight = {
					"IndentBlanklineIndent1",
					"IndentBlanklineIndent2",
					"IndentBlanklineIndent3",
					"IndentBlanklineIndent4",
					"IndentBlanklineIndent5",
					"IndentBlanklineIndent6",
				},
			},
			scope = {
				enabled = true,
				show_start = false,
				char = "│",
				highlight = {
					"IndentBlanklineIndent1",
					"IndentBlanklineIndent2",
					"IndentBlanklineIndent3",
					"IndentBlanklineIndent4",
					"IndentBlanklineIndent5",
					"IndentBlanklineIndent6",
				},
			},
		},
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 1500,
			background_colour = "#1e2835",
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"jesseleite/nvim-noirbuddy",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			-- Option 1:
			local noirbuddy_lualine = require("noirbuddy.plugins.lualine")

			local theme = noirbuddy_lualine.theme
			-- optional, you can define those yourself if you need
			local sections = noirbuddy_lualine.sections
			local inactive_sections = noirbuddy_lualine.inactive_sections

			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = theme,
					filetype = { colored = false },
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {},
					always_divide_middle = true,
				},
				sections = sections,
				inactive_sections = inactive_sections,
			})
		end,
	},
}
