local M = {
	"mfussenegger/nvim-dap",

	dependencies = {
		{ "rcarriga/nvim-dap-ui" },
		{
			"theHamsta/nvim-dap-virtual-text",
			config = function()
				require("nvim-dap-virtual-text").setup({
					commented = true,
				})
			end,
		},
		{
			"leoluz/nvim-dap-go",
			config = function()
				require("dap-go").setup()
			end,
			keys = {
				{ "<leader>y", ":lua require('dap-go').debug_test()<CR>" },
			},
		},
	},
}

function M.init()
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
end

return M
