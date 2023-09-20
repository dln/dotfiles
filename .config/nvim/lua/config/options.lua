-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.relativenumber = false
opt.clipboard = ""

vim.o.fillchars = "stl: ,stlnc: ,eob:🮙"
vim.o.autochdir = true
vim.o.updatetime = 100
vim.g.do_filetype_lua = 1
