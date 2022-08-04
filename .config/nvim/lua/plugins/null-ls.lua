local null_ls = require("null-ls")
local builtins = require("null-ls.builtins")

null_ls.setup({
	sources = {
		builtins.formatting.buf,
		builtins.formatting.cue_fmt,
		builtins.formatting.shfmt,
		builtins.formatting.buildifier,
		builtins.completion.spell,
		builtins.diagnostics.buf.with({
			args = { "lint", "--path", "$FILENAME" },
		}),
		builtins.diagnostics.buildifier,
		builtins.diagnostics.cue_fmt,
	},
	debug = true,
})
