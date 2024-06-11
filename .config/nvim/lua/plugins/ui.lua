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
		"dgagn/diagflow.nvim",
		-- event = 'LspAttach', This is what I use personnally and it works great
		opts = {
			scope = "line",
			gap_size = 0,
			max_width = 50,
			max_height = 20,
			show_borders = true,
			toggle_event = { "InsertEnter", "InsertLeave" },
		},
	},

	{
		"akinsho/bufferline.nvim",
		enabled = false,
	},

	{
		"echasnovski/mini.indentscope",
		enabled = false,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		enabled = false,
	},

	{ "nvimdev/indentmini.nvim", opts = { char = "⸽" } },

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
			render = "wrapped-compact",
			top_down = false,
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		enabled = false,
	},

	{
		"ahmedkhalf/project.nvim",
		opts = {
			manual_mode = false,
		},
	},
}
