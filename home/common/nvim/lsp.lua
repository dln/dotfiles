local lspconfig = require("lspconfig")
local servers = {
  cssls = {},
  gopls = {},
  html = {},
  jsonls = {},
  superhtml = {},
  ts_ls = {},

  harper_ls = {
    filetypes = {
      "asciidoc", "c", "gitcommit", "go", "html", "javascript", "just", "lua", "markdown",
      "nix", "python", "ruby", "rust", "text", "toml", "typescript", "zig",
    }
  },

  lua_ls = {
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
  },

  nixd = {
    cmd = { "nixd" },
    settings = {
      nixd = {
        nixpkgs = { expr = "import <nixpkgs> { }" },
        formatting = { command = { "nixfmt" } },
        options = {},
      },
    },
  },
}

for server, config in pairs(servers) do
  config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
  lspconfig[server].setup(config)
end
