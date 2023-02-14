local M = {
	"RRethy/vim-illuminate",
	event = "BufReadPost",
	config = function()
		require("illuminate").configure({ delay = 200 })
	end,
}

return M
