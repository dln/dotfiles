require("dap")
local map = require('dln.utils').map
local silent = { silent = true }

vim.fn.sign_define("DapStopped", { text = "⇒", texthl = "", linehl = "debugPC", numhl = "" })
vim.fn.sign_define("DapBreakpoint", { text = "🧘", texthl = "", linehl = "debugPC", numhl = "" })

map("n", "DD", ":lua require 'dap'.toggle_breakpoint()<CR>", silent)
map("n", "Dc", ":lua require 'dap'.continue()<CR>", silent)
map("n", "Di", ":lua require 'dap'.step_into()<CR>", silent)
map("n", "Do", ":lua require 'dap'.step_over()<CR>", silent)
map("n", "DO", ":lua require 'dap'.step_out()<CR>", silent)
map("n", "Dr", ":lua require 'dap'.repl.toggle({height = 5})<CR>", silent)
map("n", "Dh", ":lua require 'dap.ui.widgets'.hover()<CR>", silent)
