return {
	name = "shelman-theme",
	dir = "~/.config/shelman-theme/current/neovim",
	dev = true,
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme shelman]])
	end,
}
