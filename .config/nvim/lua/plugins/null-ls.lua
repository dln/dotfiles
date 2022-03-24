local null_ls = require("null-ls")
local builtins = require("null-ls.builtins")

null_ls.setup({
	sources = {
    require("null-ls").builtins.formatting.prettierd,
    require("null-ls").builtins.formatting.protolint,
    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.diagnostics.eslint,
    require("null-ls").builtins.completion.spell,
	},
	debug = true,
})
