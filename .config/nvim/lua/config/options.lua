-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.clipboard = "unnamed" --"unnamedplus"

vim.g.do_filetype_lua = 1
vim.g.root_spec = { { ".git", "lua" }, "lsp", "cwd" }

vim.o.autochdir = true
vim.o.fillchars = "stl: ,stlnc: ,eob:🮙"
vim.o.scrolloff = 7
vim.o.splitkeep = "screen"
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 150

-- additional filetypes
vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

-- AutoCommand OSC7 workaround for tmux
-- see https://github.com/neovim/neovim/issues/21771
vim.api.nvim_create_autocmd("dirchanged", {
	pattern = "*",
	command = 'call chansend(v:stderr, printf("\\033]7;%s\\033", v:event.cwd))',
})

-- (No) Statusline

vim.opt.laststatus = 0
vim.api.nvim_set_hl(0, "Statusline", { link = "Normal" })
vim.api.nvim_set_hl(0, "StatuslineNC", { link = "Normal" })
local line = string.rep("▁", vim.api.nvim_win_get_width(0))
vim.opt.statusline = "%#WinSeparator#" .. line .. "%*"
