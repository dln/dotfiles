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
			long_message_to_split = true,
			lsp_doc_border = true,
		},
	})
end

return M
