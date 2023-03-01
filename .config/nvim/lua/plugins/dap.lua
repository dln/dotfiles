return {
	"mfussenegger/nvim-dap",
	dependencies = {
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
		},
	},
	keys = {
		{ "DD", ":lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
		{ "Dc", ":lua require'dap'.continue()<cr>", desc = "Continue" },
		{ "Di", ":lua require'dap'.step_into()<cr>", desc = "Step Into" },
		{ "Do", ":lua require'dap'.step_over()<cr>", desc = "Step Over" },
		{ "DO", ":lua require'dap'.step_out()<cr>", desc = "Step Out" },
		{ "Dh", ":lua require'dap.ui.widgets'.hover()<cr>", desc = "Hover" },
		{ "Dr", ":lua require'dap'.repl.toggle({height = 5})<cr>", desc = "Toogle Repl" },
	},
	config = function()
		require("dap")
		require("dap.ext.vscode").load_launchjs()

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapLogPoint",
			{ text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
		)
		vim.fn.sign_define(
			"DapStopped",
			{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
		)
	end,
}
