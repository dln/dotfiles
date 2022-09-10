local dapgo = require("dap-go")
local silent = { silent = true }

dapgo.setup()
vim.keymap.set("n", "<leader>y", ":lua require('dap-go').debug_test()<CR>", silent)
