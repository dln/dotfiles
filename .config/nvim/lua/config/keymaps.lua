-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- C-/ should be comment instead of lazyterm
vim.api.nvim_del_keymap("n", "<c-/>")
vim.api.nvim_set_keymap("n", "<c-/>", "gcc", {})
vim.api.nvim_set_keymap("v", "<c-/>", "gc", {})
vim.api.nvim_set_keymap("n", "<Leader><c-/>", "gcgc", {})
vim.api.nvim_set_keymap("n", "<Tab>", "<Space>,", {})
vim.api.nvim_set_keymap("n", "zz", "zt", {})

vim.api.nvim_set_keymap("n", "[d", ":lua vim.diagnostic.goto_prev { float = false }<Enter>", {})
vim.api.nvim_set_keymap("n", "]d", ":lua vim.diagnostic.goto_next { float = false }<Enter>", {})
