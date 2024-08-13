-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- C-/ should be comment instead of lazyterm
vim.keymap.del("n", "<c-/>")
vim.keymap.set({ "n" }, "<c-/>", "gcc", { remap = true })
vim.keymap.set({ "v" }, "<c-/>", "gc", { remap = true })
vim.keymap.set({ "n" }, "<Leader><c-/>", "gcgc", { remap = true })
vim.keymap.del({ "n" }, "<c-_>")
vim.keymap.set({ "n" }, "<c-_>", "gcc", { remap = true })
vim.keymap.set({ "v" }, "<c-_>", "gc", { remap = true })
vim.keymap.set({ "n" }, "<Leader><c-_>", "gcgc", { remap = true })

vim.keymap.set("n", "<Tab>", "<Space>,", {})
vim.keymap.set("n", "zz", "zt", {})

vim.keymap.set("n", "[d", ":lua vim.diagnostic.goto_prev { float = false }<Enter>", {})
vim.keymap.set("n", "]d", ":lua vim.diagnostic.goto_next { float = false }<Enter>", {})
