local M = {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
}

function M.config()
	local lspconfig = require("lspconfig")

	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
	vim.keymap.set("i", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>")
	vim.keymap.set("n", "1gd", "<Cmd>lua vim.lsp.buf.type_definition()<CR>")
	vim.keymap.set("n", "gf", "<Cmd>lua vim.lsp.buf.format()<CR>")
	vim.keymap.set("n", "[d", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
	vim.keymap.set("n", "]d", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
	vim.keymap.set("n", "gwa", "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
	vim.keymap.set("n", "gwr", "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
	vim.keymap.set("n", "gwl", "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")

	vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format({sync = true})]])

	local border = {
		{ "🭽", "FloatBorder" },
		{ "▔", "FloatBorder" },
		{ "🭾", "FloatBorder" },
		{ "▕", "FloatBorder" },
		{ "🭿", "FloatBorder" },
		{ "▁", "FloatBorder" },
		{ "🭼", "FloatBorder" },
		{ "▏", "FloatBorder" },
	}

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		update_in_insert = false,
		virtual_text = false,
	})

	local signs = { Error = "🔥", Warn = "⚠️ ", Hint = "💡", Info = "💡" }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	local function on_attach(client, bufnr)
		require("nvim-navic").attach(client, bufnr)
	end

	-- simple setups --
	local servers = {
		"bashls",
		"bufls",
		"dockerls",
		"gopls",
		"jsonls",
		-- "sql",
		"pyright",
		"lua_ls",
		"terraformls",
		"yamlls",
	}

	for _, lsp in ipairs(servers) do
		lspconfig[lsp].setup({ on_attach = on_attach })
	end

	local efm_prettier = {
		formatCommand = "prettier --stdin-filepath ${INPUT}",
		formatStdin = true,
	}

	lspconfig.gopls.setup({
		on_attach = on_attach,
		settings = {
			gopls = {
				directoryFilters = {
					"-bazel-bin",
					"-bazel-out",
					"-bazel-testlogs",
					"-proto",
				},
			},
		},
	})

	lspconfig.lua_ls.setup({
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			vim.cmd([[autocmd BufWritePre <buffer> lua require'stylua-nvim'.format_file()]])
		end,
		settings = {
			Lua = {
				completion = { kewordSnippet = "Disable" },
				diagnostics = {
					enable = true,
					globals = { "renoise", "use", "vim" },
				},
				runtime = {
					version = "LuaJIT",
					path = { "?.lua", "?/init.lua", "?/?.lua" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					maxPreload = 2000,
					preloadFileSize = 1000,
					checkThirdParty = false,
				},
			},
		},
	})

	lspconfig.terraformls.setup({})

	local yaml_is_k8s = function(bufnr)
		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 50, false) -- Stop after the first 50 lines
		for _, l in pairs(lines) do
			if string.find(l, "apiVersion") ~= nil then
				return true
			end
		end
		return false
	end

	lspconfig.cssls.setup({
		cmd = { "vscode-css-languageserver", "--stdio" },
		capabilities = capabilities,
	})

	lspconfig.cssmodules_ls.setup({})

	lspconfig.html.setup({
		cmd = { "vscode-html-languageserver", "--stdio" },
		filetypes = { "html" },
		init_options = {
			configurationSection = { "html", "css", "javascript" },
			embeddedLanguages = {
				css = true,
				javascript = true,
			},
		},
		settings = {},
	})

	lspconfig.yamlls.setup({
		settings = {
			yaml = {
				format = { enable = true, singleQuote = true },
				schemaStore = { enable = true, url = "https://json.schemastore.org" },
				schemas = {
					-- ["https://json.schemastore.org/github-workflow"] = "*.github/workflows/*",
					["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
					-- ["https://json.schemastore.org/ansible-role-2.9.json"] = "*/tasks/*.y*ml",
					kubernetes = {
						"clusterrolebinding.yaml",
						"clusterrole-contour.yaml",
						"clusterrole.yaml",
						"configmap.yaml",
						"cronjob.yaml",
						"daemonset.yaml",
						"deployment-*.yaml",
						"deployment.yaml",
						"*-deployment.yaml",
						"hpa.yaml",
						"ingress.yaml",
						"job.yaml",
						"namespace.yaml",
						"pvc.yaml",
						"rbac.yaml",
						"rolebinding.yaml",
						"role.yaml",
						"sa.yaml",
						"secret.yaml",
						"serviceaccounts.yaml",
						"service-account.yaml",
						"serviceaccount.yaml",
						"service-*.yaml",
						"service.yaml",
						"*-service.yaml",
						"statefulset.yaml",
					},
				},

				validate = true,
			},
		},
	})

	require("lspconfig").tsserver.setup({
		root_dir = vim.loop.cwd,
	})

	-- npm install -g typescript typescript-language-server
	-- require("lspconfig").tsserver.setup({
	-- 	on_attach = function(client, bufnr)
	-- 		client.resolved_capabilities.document_formatting = false
	-- 		on_attach(client)

	-- 		local ts_utils = require("nvim-lsp-ts-utils")

	-- 		ts_utils.setup({
	-- 			debug = false,
	-- 			disable_commands = false,
	-- 			enable_import_on_completion = false,
	-- 			import_all_timeout = 5000, -- ms

	-- 			-- eslint
	-- 			eslint_enable_code_actions = true,
	-- 			eslint_enable_disable_comments = true,
	-- 			eslint_bin = "eslint_d",
	-- 			eslint_config_fallback = nil,
	-- 			eslint_enable_diagnostics = true,

	-- 			-- formatting
	-- 			enable_formatting = true,
	-- 			formatter = "prettier",
	-- 			formatter_config_fallback = nil,

	-- 			-- parentheses completion
	-- 			complete_parens = false,
	-- 			signature_help_in_parens = false,

	-- 			-- update imports on file move
	-- 			update_imports_on_move = true,
	-- 			require_confirmation_on_move = true,
	-- 			watch_dir = nil,
	-- 		})

	-- 		ts_utils.setup_client(client)

	-- 		vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>co", ":TSLspOrganize<CR>", { silent = true })
	-- 		vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", { silent = true })
	-- 		vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>cR", ":TSLspRenameFile<CR>", { silent = true })
	-- 		vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>ci", ":TSLspImportAll<CR>", { silent = true })
	-- 	end,
	-- })
	--
end

return M
