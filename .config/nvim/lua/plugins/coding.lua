return {

	{
		"echasnovski/mini.comment",
		keys = {
			{ "<Leader><C-_>", "gcgc", remap = true, silent = true, mode = "n", desc = "Uncomment whole comment" },
			{ "<C-_>", "gcc", remap = true, silent = true, mode = "n" },
			{ "<C-_>", "gc", remap = true, silent = true, mode = "v" },
		},
	},

	{
		"echasnovski/mini.pairs",
		enabled = false,
	},
}
