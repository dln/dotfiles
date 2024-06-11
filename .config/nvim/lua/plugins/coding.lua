return {

	{
		"echasnovski/mini.pairs",
		enabled = false,
	},

	{
		"nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
		opts = function(_, opts)
			local cmp = require("cmp")
			table.insert(opts.sources, { name = "emoji" })

			opts.view = { docs = { auto_open = false }, entries = { follow_cursor = true } }
			opts.completion = {
				autocomplete = false,
			}

			local winhighlight =
				"Normal:NoiceCmdlinePopupTitle,FloatBorder:NoiceCmdlinePopupBorder,CursorLine:PMenuSel,Search:Search"

			opts.window = {
				completion = cmp.config.window.bordered({ winhighlight = winhighlight, border = "rounded" }),
				documentation = cmp.config.window.bordered({ winhighlight = winhighlight, border = "rounded" }),
				preview = cmp.config.window.bordered({ winhighlight = winhighlight, border = "rounded" }),
			}

			-- lua sorting = { comparators = { cmp.config.compare.sort_text, -- this needs to be 1st cmp.config.compare.offset, cmp.config.compare.exact, cmp.config.compare.score, cmp.config.compare.kind, cmp.config.compare.length, cmp.config.compare.order, } }

			opts.sorting = {
				priority_weight = 2,
				comparators = {
					cmp.config.compare.exact,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.offset,
					-- cmp.config.compare.scopes,
					cmp.config.compare.score,
					cmp.config.compare.kind,
					-- cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			}

			return opts
		end,
	},

	{
		"Exafunction/codeium.nvim",
		opts = {
			enable_chat = false,
		},
	},

	{
		"monkoose/neocodeium",
		event = "VeryLazy",
		config = function()
			local neocodeium = require("neocodeium")
			neocodeium.setup()
			vim.keymap.set("i", "<C-j>", neocodeium.accept)
			vim.keymap.set("i", "<A-f>", neocodeium.accept)
			vim.keymap.set("i", "<C-h>", neocodeium.cycle_or_complete)
		end,
	},
}
