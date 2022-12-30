return {
	"hashivim/vim-terraform",
	"jose-elias-alvarez/typescript.nvim",
	"tjdevries/colorbuddy.vim",
	"wbthomason/packer.nvim",
	"jose-elias-alvarez/nvim-lsp-ts-utils",
	"jjo/vim-cue",
	"ckipp01/stylua-nvim",

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
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip/loaders/from_vscode").lazy_load()
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

	{
		url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
			vim.diagnostic.config({
				virtual_text = false,
			})
		end,
	},
}
