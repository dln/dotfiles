return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				["proto"] = { { "buf" } },
				["terraform"] = { { "terraform_fmt" } },
			},
		},
	},
}
