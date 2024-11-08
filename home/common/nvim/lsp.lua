vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = function(str)
			return { buffer = ev.buf, desc = str }
		end

		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client.server_capabilities.codeLensProvider then
			vim.lsp.codelens.refresh({ bufnr = bufnr })
		end
	end,
})

local configs = require('lspconfig.configs')
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

local servers = {
  'gopls',
  'nil_ls',
  'ts_ls',
}

for _, ls in ipairs(servers) do
  lspconfig[ls].setup {
    capabilities = capabilities,
    on_attach = function(_, buf)
      vim.api.nvim_set_option_value('omnifunc', 'v:lua.MiniCompletion.completefunc_lsp', {buf = buf})
    end,
  }
end

lspconfig.nixd.setup({
  capabilities = capabilities,
	cmd = { "nixd" },
	settings = {
		nixd = {
			nixpkgs = { expr = "import <nixpkgs> { }" },
			formatting = { command = { "nixfmt" } },
			options = {},
		},
	},
})

lspconfig.lua_ls.setup({
  capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = { globals = { "vim", "hs" } },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
})
