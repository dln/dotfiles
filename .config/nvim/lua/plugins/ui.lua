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

local logo = [[
███████ ██   ██ ███████ ██      ███    ███  █████  ███    ██      ██████  ██████   ██████  ██    ██ ██████ 
██      ██   ██ ██      ██      ████  ████ ██   ██ ████   ██     ██       ██   ██ ██    ██ ██    ██ ██   ██
███████ ███████ █████   ██      ██ ████ ██ ███████ ██ ██  ██     ██   ███ ██████  ██    ██ ██    ██ ██████ 
     ██ ██   ██ ██      ██      ██  ██  ██ ██   ██ ██  ██ ██     ██    ██ ██   ██ ██    ██ ██    ██ ██     
███████ ██   ██ ███████ ███████ ██      ██ ██   ██ ██   ████      ██████  ██   ██  ██████   ██████  ██     
]]

return {
	{
		"nvimdev/dashboard-nvim",
		opts = {
			theme = "hyper",
			config = {
				header = vim.split(string.rep("\n", 8) .. logo, "\n"),
				week_header = { enable = false },
				packages = { enable = false },
				project = { enable = false },
				footer = {},
				shortcut = {},
			},
		},
	},

	{
		"echasnovski/mini.indentscope",
		opts = {
			draw = {
				delay = 50, -- ms
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
				enabled = false,
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
		"mvllow/modes.nvim",
		opts = {
			colors = {
				copy = "#f5c359",
				delete = "#c75c6a",
				insert = "#ffcc00",
				visual = "#c343fc",
			},
			set_cursor = true,
			set_cursorline = true,
			set_number = true,
		},
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>sna", "<cmd>NoiceTelescope<cr>", desc = "Show all messages in Telescope" },
		},
		opts = function()
			local enable_conceal = true -- Hide command text if true
			return {
				presets = { bottom_search = true }, -- The kind of popup used for /
				cmdline = {
					view = "cmdline", -- The kind of popup used for :
					format = {
						cmdline = { conceal = enable_conceal },
						search_down = { conceal = enable_conceal },
						search_up = { conceal = enable_conceal },
						filter = { conceal = enable_conceal },
						lua = { conceal = enable_conceal },
						help = { conceal = enable_conceal },
						input = { conceal = enable_conceal },
					},
				},

				messages = { enabled = true },
				lsp = {
					hover = { enabled = false },
					signature = { enabled = false },
					progress = { enabled = true, view = "cmdline" },
					message = { enabled = false },
					smart_move = { enabled = false },
				},
			}
		end,
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			stages = "fade_in_slide_out",
			timeout = 1000,
			background_colour = "#1e2835",
			render = "wrapped-compact",
			top_down = false,
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		enabled = false,
	},
}
