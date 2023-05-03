return {

	"tjdevries/colorbuddy.vim",
	"wbthomason/packer.nvim",
	"jose-elias-alvarez/nvim-lsp-ts-utils",
	"jjo/vim-cue",
	"ckipp01/stylua-nvim",

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
