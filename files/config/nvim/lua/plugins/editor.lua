return {
	{
		"folke/flash.nvim",
		enabled = false,
	},

	{
		"telescope.nvim",
		keys = {
			{
				"<Leader><Leader>",
				function()
					local telescope = require("telescope")
					local jj_pick_status, jj_res = pcall(telescope.extensions.jj.files, opts)
					if jj_pick_status then
						return
					end
					local git_files_status, git_res = pcall(telescope.builtin.git_files, opts)
					if not git_files_status then
						error("Could not launch jj/git files: \n" .. jj_res .. "\n" .. git_res)
					end
				end,
				desc = "VCS Files",
			},
			{
				"<C-p>",
				"<cmd>Telescope projects<cr>",
				desc = "Projects",
			},
		},
		opts = function(_, opts)
			local actions = require("telescope.actions")
			opts.defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					anchor = "top",
					horizontal = {
						prompt_position = "top",
						mirror = false,
						preview_width = 0.49,
						-- preview_height = 0.5,
					},
					width = 0.99,
					height = 0.9,
					preview_cutoff = 10,
				},
				mappings = {
					i = {
						["<esc>"] = actions.close, -- <Esc> close popup
						["<C-u>"] = false, -- <C-u> clear prompt
						["<C-w>"] = false, -- <C-u> clear prompt
					},
				},
				path_display = { "filename_first" },
				-- previewer = false,
				preview = {
					-- hide_on_startup = true,
				},
				sorting_strategy = "ascending",
				winblend = 0,
				wrap_results = true,
			}
		end,
	},

	{ "avm99963/vim-jjdescription", lazy = false },

	{
		"zschreur/telescope-jj.nvim",
		keys = {
			{
				"<Leader>jc",
				function()
					require("telescope").extensions.jj.conflicts()
				end,
				desc = "jj conflicts",
			},
			{
				"<Leader>jd",
				function()
					require("telescope").extensions.jj.diff()
				end,
				desc = "jj diffs",
			},
			{
				"<Leader>jf",
				function()
					require("telescope").extensions.jj.files()
				end,
				desc = "jj files",
			},
		},
		config = function()
			LazyVim.on_load("telescope.nvim", function()
				local telescope = require("telescope")
				telescope.load_extension("jj")
			end)
		end,
	},
}
