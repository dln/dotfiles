return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = {
				virtual_text = false,
			},
			inlay_hints = { enabled = false },
			-- codelens = {
			-- 	enabled = true,
			-- },
			servers = {
				nil_ls = {},
				nixd = {},
				starpls = {},
				yamlls = {
					settings = {
						yaml = {
							schemas = {
								-- kubernetes = "*.yaml",
								["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
								["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
								["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
								["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
								["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
								["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
								["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.29.1/all.json"] = "/*.yaml",
							},
						},
					},
				},
			},
		},
	},
}
