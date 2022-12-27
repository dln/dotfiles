return {
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				highlight = {
					enable = true,
					use_languagetree = true,
				},

				indent = {
					enable = false,
				},

				playground = {
					enable = true,
					disable = {},
					updatetime = 25,
					persist_queries = false,
				},

				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "ss",
						node_incremental = "sq",
						scope_incremental = "sd",
						node_decremental = "sa",
					},
				},

				textobjects = {
					move = {
						enable = true,
						goto_next_start = {
							["]]"] = "@function.outer",
							["]m"] = "@class.outer",
						},
						goto_next_end = {
							["]["] = "@function.outer",
							["]M"] = "@class.outer",
						},
						goto_previous_start = {
							["[["] = "@function.outer",
							["[m"] = "@class.outer",
						},
						goto_previous_end = {
							["[]"] = "@function.outer",
							["[M"] = "@class.outer",
						},
					},
				},
				--- nvim-ts-autotag ---
				autotag = {
					enable = true,
					filetypes = { "html", "javascriptreact", "xml" },
				},
			})
		end,
	},
}
