local lspconfig = require("lspconfig")
-- local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


vim.lsp.handlers["textDocument/publishDiagnostics"] =
vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics,
{
	update_in_insert = false,
  virtual_text = false,
}
)
local signs = { Error = "🔥", Warn = "⚠️ ", Hint = "💡", Info = "💡" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local on_attach = function()
	require("folding").on_attach()
	require "lsp_signature".on_attach()  -- Note: add in lsp client on-attach
end

-- simple setups --
local servers = {
	"bashls",
	"dockerls",
	"gopls",
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

lspconfig.cssls.setup {
	cmd = { "vscode-css-languageserver", "--stdio" },
    capabilities = capabilities,
}

lspconfig.cssmodules_ls.setup{}

lspconfig.html.setup {
	cmd = { "vscode-html-languageserver", "--stdio" },
	filetypes = { "html" },
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
		}
	},
	settings = {}
}

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

-- npm install -g typescript typescript-language-server
require'lspconfig'.tsserver.setup({
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    on_attach(client)

    require'lsp_signature'.on_attach({
      bind = false, -- This is mandatory, otherwise border config won't get registered.
                   -- If you want to hook lspsaga or other signature handler, pls set to false
      doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                     -- set to 0 if you DO NOT want any API comments be shown
                     -- This setting only take effect in insert mode, it does not affect signature help in normal
                     -- mode, 10 by default

      floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
      fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
      hint_enable = false, -- virtual hint enable
      hint_prefix = "🐼 ",  -- Panda for parameter
      hint_scheme = "String",
      use_lspsaga = true,  -- set to true if you want to use lspsaga popup
      hi_parameter = "Search", -- how your parameter will be highlight
      max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                       -- to view the hiding contents
      max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
      handler_opts = {
        border = "single"   -- double, single, shadow, none
      },
      extra_trigger_chars = {} -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    })

    local ts_utils = require("nvim-lsp-ts-utils")

    ts_utils.setup {
        debug = false,
        disable_commands = false,
        enable_import_on_completion = false,
        import_all_timeout = 5000, -- ms

        -- eslint
        eslint_enable_code_actions = true,
        eslint_enable_disable_comments = true,
        eslint_bin = 'eslint_d',
        eslint_config_fallback = nil,
        eslint_enable_diagnostics = true,

        -- formatting
        enable_formatting = true,
        formatter = 'prettier',
        formatter_config_fallback = nil,

        -- parentheses completion
        complete_parens = false,
        signature_help_in_parens = false,

        -- update imports on file move
        update_imports_on_move = true,
        require_confirmation_on_move = true,
        watch_dir = nil,
    }

    ts_utils.setup_client(client)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>co", ":TSLspOrganize<CR>",   { silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":TSLspFixCurrent<CR>",         { silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>cR", ":TSLspRenameFile<CR>", { silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>ci", ":TSLspImportAll<CR>",  { silent = true })
  end
})
