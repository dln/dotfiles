local M = {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}

function M.config()
	require("noice").setup({
		presets = {
			inc_rename = true,
		},
	})
end

return M
