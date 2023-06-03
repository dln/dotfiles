return {

	"tjdevries/colorbuddy.vim",
	"wbthomason/packer.nvim",
	"jose-elias-alvarez/nvim-lsp-ts-utils",
	"jjo/vim-cue",
	"ckipp01/stylua-nvim",

	{
		"jesseleite/nvim-noirbuddy",
		dependencies = { "tjdevries/colorbuddy.nvim" },
		config = function()
			require("noirbuddy").setup({
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

			Color.new("comment", "#E57373")
			Color.new("hlargs", "#FFF8E1")

			Color.new("illuminate_bg", "#112210")
			Color.new("illuminate_fg", "#66FFEE")

			-- Color.new("search_bg", "#554411")
			-- Color.new("search_fg", "#FFF0C0")
			--
			Color.new("search_bg", "#223311")
			Color.new("search_fg", "#CCFF33")

			Group.new("TelescopeTitle", colors.primary)
			Group.new("TelescopeBorder", colors.secondary)
			Group.new("@comment", colors.comment, nil, styles.bold + styles.italic)
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

	{
		"lukas-reineke/headlines.nvim",
		--     config = {
		--       ft = { "go" },
		--       go = {
		--         query = vim.treesitter.parse_query(
		--           "go",
		--           [[
		--             (function_declaration @headline)
		--           ]]
		--         ),
		--         -- treesitter_language = "go",
		--       },
		--     },
	},

	{
		"m-demare/hlargs.nvim",
		event = "VeryLazy",
		enabled = true,
		config = {
			excluded_argnames = {
				usages = {
					lua = { "self", "use" },
				},
			},
		},
	},

	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		config = {
			auto_open = false,
			use_diagnostic_signs = true,
		},
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle<cr>" },
			{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>" },
			{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>" },
			{ "<leader>xl", "<cmd>TroubleToggle loclist<cr>" },
			{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },
			{ "gR", "<cmd>TroubleToggle lsp_references<cr>" },
		},
	},

	{
		"danymat/neogen",
		keys = {
			{
				"<leader>cc",
				function()
					require("neogen").generate({})
				end,
				desc = "Neogen Comment",
			},
		},
		opts = { snippet_engine = "luasnip" },
	},

	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
		keys = {
			{ "<Leader>rn", ":IncRename " },
		},
	},

	{
		"SmiteshP/nvim-navic",
		config = function()
			vim.g.navic_silence = true
			require("nvim-navic").setup({ separator = " ", highlight = true, depth_limit = 5 })
		end,
	},

	{
		"numToStr/Comment.nvim",
		keys = {
			{ "<C-_>", "<Plug>(comment_toggle_linewise_current)" },
			{ "<C-_>", "<Plug>(comment_toggle_linewise_visual)", mode = "v" },
		},
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	{
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
	},

	{
		"onsails/lspkind-nvim",
		config = function()
			require("lspkind").init({})
		end,
	},

	-- {
	-- 	url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	-- 	config = function()
	-- 		require("lsp_lines").setup()
	-- 		vim.diagnostic.config({
	-- 			virtual_text = false,
	-- 		})
	-- 	end,
	-- },
}
