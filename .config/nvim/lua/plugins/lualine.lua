local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = { "kyazdani42/nvim-web-devicons" },
	event = "VeryLazy",
}

local function clock()
	return os.date("%H:%M")
end

function M.config()
	local lualine = require("lualine")

	lualine.setup({
		options = {
			globalstatus = true,
			theme = "onedark",
			component_separators = { left = "╲", right = "╱" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_c = {
				{
					"filename",
					path = 1,
					file_status = true,
				},
				{
					function()
						local navic = require("nvim-navic")
						local ret = navic.get_location()
						return ret:len() > 2000 and "navic error" or ret
					end,
					cond = function()
						if package.loaded["nvim-navic"] then
							local navic = require("nvim-navic")
							return navic.is_available()
						end
					end,
					color = { fg = "#ff8f00" },
				},
			},
			lualine_x = { "filetype" },
			lualine_y = { "location" },
			lualine_z = { clock },
		},
	})
end

return M
