local null_ls = require("null-ls")
local builtins = require("null-ls.builtins")

null_ls.setup({
	sources = {
		builtins.formatting.buf,
		builtins.formatting.shfmt,
		builtins.formatting.buildifier,
		builtins.completion.spell,
		builtins.diagnostics.buf,
		builtins.diagnostics.buildifier,
	},
	debug = true,
})
