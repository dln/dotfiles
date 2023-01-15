local M = {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
	local null_ls = require("null-ls")
	local builtins = require("null-ls.builtins")

	null_ls.setup({
		sources = {
			builtins.formatting.black,
			builtins.formatting.buf,
			builtins.formatting.cue_fmt,
			builtins.formatting.shfmt,
			builtins.formatting.buildifier,
			builtins.completion.spell,
			builtins.diagnostics.buf.with({
				args = { "lint", "--disable-symlinks", "--path", "$FILENAME" },
				cwd = function()
					local file_dir = vim.fn.expand("%:p:h") .. ";"
					local buf_yaml = vim.fn.findfile("buf.yaml", file_dir)
					if buf_yaml then
						return vim.fn.fnamemodify(buf_yaml, ":h")
					end
				end,
			}),
			builtins.diagnostics.buildifier,
			builtins.diagnostics.cue_fmt,
		},
		debug = true,
	})
end

return M