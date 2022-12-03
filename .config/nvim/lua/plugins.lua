return require("packer").startup(function()
	use("hashivim/vim-terraform")
	use("pierreglaser/folding-nvim")
	use("tjdevries/colorbuddy.vim")
	use("wbthomason/packer.nvim")
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use("rafamadriz/friendly-snippets")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use({ "ray-x/guihua.lua", run = "cd lua/fzy && make" })
	use("jjo/vim-cue")
	use("ckipp01/stylua-nvim")

	use({
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup({
				commented = true,
			})
		end,
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins/null-ls")
		end,
	})

	use({
		"folke/yanky.nvim",
		config = function()
			require("plugins/yanky")
		end,
	})

	use({
		"b3nj5m1n/kommentary",
		config = function()
			require("kommentary.config").use_extended_mappings()
			vim.api.nvim_set_keymap("n", "", "<Plug>kommentary_line_default", {}) -- C-/
			vim.api.nvim_set_keymap("v", "", "<Plug>kommentary_visual_default", {}) -- C-/

			require("kommentary.config").configure_language("default", {
				prefer_single_line_comments = true,
			})
		end,
	})

	use({
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip/loaders/from_vscode").lazy_load()
		end,
	})

	-- cmp
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"andersevenrud/cmp-tmux",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("plugins/nvim-cmp")
		end,
	})

	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("gitsigns").setup({
				numhl = true,
				signs = {
					add = { hl = "GitSignsAdd", text = "▌", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
					change = {
						hl = "GitSignsChange",
						text = "▌",
						numhl = "GitSignsChangeNr",
						linehl = "GitSignsChangeLn",
					},
					delete = {
						hl = "GitSignsDelete",
						text = "▖",
						numhl = "GitSignsDeleteNr",
						linehl = "GitSignsDeleteLn",
					},
					topdelete = {
						hl = "GitSignsDelete",
						text = "▘",
						numhl = "GitSignsDeleteNr",
						linehl = "GitSignsDeleteLn",
					},
					changedelete = {
						hl = "GitSignsChange",
						text = "~",
						numhl = "GitSignsChangeNr",
						linehl = "GitSignsChangeLn",
					},
				},
			})
		end,
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
		branch = "master",
		config = function()
			-- vim.wo.colorcolumn = "100"
			vim.g.indent_blankline_char = "│"
			vim.g.indent_blankline_space_char = "⬝"
			vim.g.indent_blankline_space_char_highlight_list = { "IndentSpace" }
			-- vim.g.indent_blankline_char_list = {'|', '¦', '┆', '┊'}
			vim.g.indent_blankline_buftype_exclude = { "help", "terminal" }
			vim.g.indent_blankline_filetype_exclude = { "text", "markdown" }
			-- vim.g.indent_blankline_show_end_of_line = true
			vim.g.indent_blankline_show_first_indent_level = true
			vim.g.indent_blankline_show_trailing_blankline_indent = true
			vim.g.indent_blankline_char_highlight_list =
				{ "Indent1", "Indent2", "Indent3", "Indent4", "Indent5", "Indent6" }
		end,
	})

	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins/lsp-config")
		end,
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
			"nvim-telescope/telescope-github.nvim",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			require("plugins/telescope")
		end,
	})

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
		run = ":TSUpdate",
		config = function()
			require("plugins/treesitter")
		end,
	})

	use({
		"ray-x/go.nvim",
		config = function()
			require("go").setup({
				comment_placeholder = "",
				icons = { breakpoint = "🧘", currentpos = "🏃" },
				dap_debug_gui = false,
			})
			vim.cmd("autocmd FileType go nmap <Leader>c :lua require('go.comment').gen()<cr>")
			vim.cmd("autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()")
			vim.cmd("autocmd BufWritePre (InsertLeave?) <buffer> lua vim.lsp.buf.formatting_sync(nil,500)")
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter-context",
		requires = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("plugins/treesitter-context")
		end,
	})

	use({
		"onsails/lspkind-nvim",
		config = function()
			require("lspkind").init({})
		end,
	})

	use({
		"ojroques/nvim-osc52",
		config = function()
			require("plugins/osc52")
		end,
	})

	-- marks
	use({
		"chentoast/marks.nvim",
		config = function()
			require("plugins/marks")
		end,
	})

	-- dap
	use({
		"mfussenegger/nvim-dap",
		config = function()
			require("plugins/dap")
		end,
	})

	-- go
	use({
		"leoluz/nvim-dap-go",
		config = function()
			require("plugins/nvim-dap-go")
		end,
	})

	-- lualine
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("plugins/lualine")
		end,
	})

	-- lsp_lines
	use({
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
			vim.diagnostic.config({
				virtual_text = false,
			})
		end,
	})

	-- zenbones
	use({
		"mcchrish/zenbones.nvim",
		requires = {
			"rktjmp/lush.nvim",
		},
		config = function()
			require("plugins/zenbones")
		end,
	})

	-- copilot
	use({
		"zbirenbaum/copilot.lua",
		event = "VimEnter",
		config = function()
			vim.defer_fn(function()
				require("plugins/copilot")
			end, 100)
		end,
	})

	use({
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	})
end)
