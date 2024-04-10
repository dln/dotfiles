return {
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.root_dir = opts.root_dir
				or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
			opts.sources = vim.list_extend(opts.sources or {}, {
				nls.builtins.formatting.mdformat,
				nls.builtins.formatting.stylua,
				nls.builtins.formatting.shfmt,
				nls.builtins.formatting.buf,
				nls.builtins.diagnostics.buf.with({
					args = { "lint", "--disable-symlinks", "--path", "$FILENAME" },
					cwd = function()
						local file_dir = vim.fn.expand("%:p:h") .. ";"
						local buf_yaml = vim.fn.findfile("buf.yaml", file_dir)
						if buf_yaml then
							return vim.fn.fnamemodify(buf_yaml, ":h")
						end
					end,
				}),
			})
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			window = {
				width = 30,
				position = "right",
			},
		},
	},

	{
		"simrat39/rust-tools.nvim",
		enabled = false,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
		opts = {
			server = {
				on_attach = function(_, bufnr)
					vim.keymap.set("n", "<leader>cR", function()
						vim.cmd.RustLsp("codeAction")
					end, { desc = "Code Action", buffer = bufnr })
					vim.keymap.set("n", "<leader>dr", function()
						vim.cmd.RustLsp("debuggables")
					end, { desc = "Rust debuggables", buffer = bufnr })
					vim.keymap.set("n", "<leader>cD", function()
						vim.cmd.RustLsp("externalDocs")
					end, { desc = "Rust external documentation", buffer = bufnr })
				end,
			},
		},
	},

	{
		"monkoose/neocodeium",
		event = "VeryLazy",
		config = function()
			local neocodeium = require("neocodeium")
			neocodeium.setup()
			vim.keymap.set("i", "<C-j>", neocodeium.accept)
		end,
	},
}
