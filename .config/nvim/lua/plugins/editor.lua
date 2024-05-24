return {
	{
		"folke/flash.nvim",
		enabled = false,
	},
	{ "aohoyd/broot.nvim", opts = {} },
	{
		"telescope.nvim",
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					layout_strategy = "horizontal",
					layout_config = {
						anchor = "top",
						horizontal = {
							prompt_position = "top",
							mirror = false,
							preview_width = 0.4,
							-- preview_height = 0.5,
						},
						width = 0.9,
						height = 0.9,
						preview_cutoff = 10,
					},
					mappings = {
						i = {
							["<esc>"] = actions.close, -- <Esc> close popup
							["<C-u>"] = false, -- <C-u> clear prompt
						},
					},
					sorting_strategy = "ascending",
					winblend = 0,
					wrap_results = true,
					previewer = false,
					preview = {
						hide_on_startup = true,
					},
				},
			})
		end,
	},
}
