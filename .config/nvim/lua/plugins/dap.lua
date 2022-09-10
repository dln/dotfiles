require("dap")
local silent = { silent = true }

vim.fn.sign_define("DapStopped", { text = "⇒", texthl = "", linehl = "debugPC", numhl = "" })
vim.fn.sign_define("DapBreakpoint", { text = "🧘", texthl = "", linehl = "debugPC", numhl = "" })

vim.keymap.set("n", "DD", ":lua require 'dap'.toggle_breakpoint()<CR>", silent)
vim.keymap.set("n", "Dc", ":lua require 'dap'.continue()<CR>", silent)
vim.keymap.set("n", "Di", ":lua require 'dap'.step_into()<CR>", silent)
vim.keymap.set("n", "Do", ":lua require 'dap'.step_over()<CR>", silent)
vim.keymap.set("n", "DO", ":lua require 'dap'.step_out()<CR>", silent)
vim.keymap.set("n", "Dr", ":lua require 'dap'.repl.toggle({height = 5})<CR>", silent)
vim.keymap.set("n", "Dh", ":lua require 'dap.ui.widgets'.hover()<CR>", silent)
