local dapgo = require('dap-go')
local map = require('dln.utils').map
local silent = { silent=true }

dapgo.setup()
map("n", "<leader>y", ":lua require('dap-go').debug_test()<CR>", silent)
