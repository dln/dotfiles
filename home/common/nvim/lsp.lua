local configs = require('lspconfig.configs')
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
local servers = {
  'gopls',
  'ts_ls',
}

for _, ls in ipairs(servers) do
  lspconfig[ls].setup {
    capabilities = capabilities,
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
