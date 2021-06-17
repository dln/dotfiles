local lspconfig = require("lspconfig")
-- local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

vim.lsp.handlers["textDocument/publishDiagnostics"] =
vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics,
{
	update_in_insert = false,
	virtual_text = {prefix = "‹❮❰ " }
}
)
vim.fn.sign_define(
"LspDiagnosticsSignError",
{
	text = "🔥",
	texthl = "LspDiagnosticsSignError"
}
)

vim.fn.sign_define(
"LspDiagnosticsSignWarning",
{
	text = "⚠",
	texthl = "LspDiagnosticsSignWarning"
}
)
vim.fn.sign_define(
"LspDiagnosticsSignInformation",
{
	text = "💡",
	texthl = "LspDiagnosticsSignInformation",
}
)
vim.fn.sign_define(
"LspDiagnosticsSignHint",
{
	text = "💡",
	texthl = "LspDiagnosticsSignHint",
}
)

local on_attach = function()
	require("folding").on_attach()
end

-- simple setups --
local servers = {
	"bashls",
	"cssls",
	"dockerls",
	"gopls",
	"html",
	"jsonls",
	-- "sql",
	"sumneko_lua",
	"terraformls",
	"yamlls",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {on_attach = on_attach}
end

local efm_prettier = {
	formatCommand = "prettier --stdin-filepath ${INPUT}",
	formatStdin = true
}


lspconfig.sumneko_lua.setup {
	cmd = {"lua-language-server", "-E", "/usr/share/lua-language-server/main.lua"},
	settings = {
		Lua = {
			completion = {kewordSnippet = "Disable"},
			diagnostics = {
				enable = true,
				globals = {"renoise", "use", "vim"}
			},
			runtime = {
				version = "LuaJIT",
				path = {"?.lua", "?/init.lua", "?/?.lua"}
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
					[vim.fn.stdpath("data") .. "/site/pack"] = true
				},
				maxPreload = 2000,
				preloadFileSize = 1000
			}
		}
	}
}

lspconfig.terraformls.setup {}

local yaml_is_k8s = function(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 50, false) -- Stop after the first 50 lines
	for _, l in pairs(lines) do
		if string.find(l, "apiVersion") ~= nil then return true end
	end
	return false
end

lspconfig.yamlls.setup {
	settings = {
		yaml = {
			format = {enable = true, singleQuote = true},
			schemaStore = {enable = true, url = "https://json.schemastore.org"},
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

			validate = true
		}
	}
}