return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				["html"] = { { "prettierd", "prettier" } },
				["sass"] = { { "prettierd", "prettier" } },
				["proto"] = { { "buf" } },
				["terraform"] = { { "terraform_fmt" } },
			},
		},
	},
}
