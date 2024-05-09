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
		"echasnovski/mini.indentscope",
		opts = {
			draw = {
				delay = 25, -- ms
			},
		},
	},
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
			timeout = 2000,
			background_colour = "#1e2835",
			render = "wrapped-compact",
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		enabled = false,
	},
}
