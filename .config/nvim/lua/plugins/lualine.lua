local lualine = require("lualine")
lualine.setup({
	options = {
		globalstatus = true,
		theme = "onelight",
		component_separators = "╱",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_c = {
			{
				"filename",
				path = 1,
				file_status = true,
			},
		},
	},
})
