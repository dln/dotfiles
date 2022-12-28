local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"andersevenrud/cmp-tmux",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-emoji",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"onsails/lspkind-nvim",
		"saadparwaiz1/cmp_luasnip",
	},
	event = "InsertEnter",
}

function M.config()
	local cmp = require("cmp")

	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	vim.o.completeopt = "menuone,noselect"

	cmp.setup({
		completion = {
			completeopt = "menu,menuone,noinsert",
		},

		formatting = {
			format = require("lspkind").cmp_format(),
		},

		window = {
			completion = cmp.config.window.bordered({
				winhighlight = "Normal:PMenu,FloatBorder:PMenuBorder,CursorLine:PMenuSel,Search:None",
			}),
			documentation = cmp.config.window.bordered({
				winhighlight = "Normal:PMenu,FloatBorder:PMenu,CursorLine:PMenuSel,Search:None",
			}),
		},

		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},

		mapping = {
			["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<C-d>"] = cmp.mapping.scroll_docs(-2),
			["<C-u>"] = cmp.mapping.scroll_docs(2),
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			-- ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = false }), { "i", "c" }),
			-- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true })),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {}),
		},

		-- experimental = {
		-- 	ghost_text = {
		-- 		hl_group = "LspCodeLens",
		-- 	},
		-- },

		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "buffer" },
			{ name = "luasnip" },
			{ name = "copilot" },
			{
				name = "tmux",
				priority = 2,
				option = {
					all_panes = true,
					trigger_characters = {},
				},
			},
			{ name = "emoji" },
		}),
	})
end

return M
