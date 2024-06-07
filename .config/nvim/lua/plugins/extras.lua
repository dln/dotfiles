return {
	{
		"direnv/direnv.vim",
		lazy = false,
		priority = 900,
		config = function()
			vim.g.direnv_silent_load = 1
		end,
	},

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
				nls.builtins.formatting.buildifier,
				nls.builtins.diagnostics.buildifier,
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
		enabled = false,
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

			settings = {
				-- rust-analyzer language server configuration
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
						loadOutDirsFromCheck = true,
						runBuildScripts = true,
						targetDir = true,
					},
					-- Add clippy lints for Rust.
					checkOnSave = {
						allFeatures = true,
						command = "clippy",
						extraArgs = { "--no-deps" },
					},
					procMacro = {
						enable = true,
						ignored = {
							["async-trait"] = { "async_trait" },
							["napi-derive"] = { "napi" },
							["async-recursion"] = { "async_recursion" },
						},
					},
				},
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
			vim.keymap.set("i", "<C-h>", neocodeium.cycle_or_complete)
		end,
	},
}
