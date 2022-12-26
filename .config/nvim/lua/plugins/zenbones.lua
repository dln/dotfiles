vim.g.zenbones = {
	style = "light",
	lightness = "bright",
	colorize_diagnostic_underline_text = true,
	transparent_background = true,
	zenbones_compat = 1,
}

local lush = require("lush")
local base = require("zenbones")

-- Create some specs
---@diagnostic disable = undefined-global
local specs = lush.parse(function()
	return {
		CursorLine({ bg = "#f5f5f0" }),
		Error({ fg = "#d9534f" }),
		CursorLineNr({ fg = "#BCAAA4", bg = "#f5f5f0" }),
		MsgArea({ fg = "#A1887F", bg = "#f1f1f1" }),
		String({ fg = "#2E7D32", gui = "italic" }),
		Comment({ fg = "#114499", gui = "bold,italic" }),
		CopilotSuggestion({ fg = "#0066cc", gui = "bold,italic" }),
		LineNr({ fg = "#9FA8AC", gui = "bold,italic" }),
		LineNrAbove({ fg = "#9F080C", gui = "bold,italic" }),
		Indent1({ fg = "#DFDF9A", gui = "italic" }),
		Indent2({ fg = "#BAE1FF", gui = "italic" }),
		Indent3({ fg = "#BAFFC9", gui = "italic" }),
		Indent4({ fg = "#FFB3BA", gui = "italic" }),
		Indent5({ fg = "#FFDFBA", gui = "italic" }),
		Indent6({ fg = "#F3E5F5", gui = "italic" }),
		NormalFloat({ bg = "#FFF9C4" }),
		FloatBorder({ fg = "#FFB74D", bg = "#FFF9C4" }),
		TelescopeNormal({ bg = "#EFEBE9" }),
		TelescopeBorder({ fg = "#A1887F", bg = "#EFEBE9" }),
		TelescopeSelection({ fg = "#FFFFFF", bg = "#1976D2" }),
		DiagnosticSignError({ fg = "#ff2200", bg = "#fff5ff", gui = "bold" }),
		DiagnosticVirtualTextInfo({ fg = "#0033bb", bg = "#f7fcff", gui = "bold,italic" }),
		DiagnosticVirtualTextWarn({ fg = "#bb2200", bg = "#fff9f3", gui = "bold,italic" }),
		DiagnosticVirtualTextError({ fg = "#ff2200", bg = "#fff5f3", gui = "italic" }),
		DiagnosticUnderlineError({ fg = "#ff0000", gui = "undercurl" }),
		DiagnosticUnderlineWarn({ fg = "#ff7700", gui = "undercurl" }),
		DiagnosticUnderlineInfo({ fg = "#3366cc", gui = "undercurl" }),
		MarkSignHL({ fg = "#009688", bg = "#E0F7FA" }),
		MarkSignNumHL({ fg = "#B2DFDB", bg = "#E0F7FA" }),
		GitSignsAdd({ fg = "#81C784" }),
		GitSignsAddNr({ fg = "#C8E6C9" }),
		GitSignsDelete({ fg = "#E53935" }),
		GitSignsDeleteNr({ fg = "#FFCDD2" }),
		GitSignsChange({ fg = "#FFA726" }),
		GitSignsChangeNr({ fg = "#FFE0B2" }),

		PMenu({ bg = "#F7F5F0" }),
		PMenuBorder({ bg = "#F7F5F0", fg = "#886622" }),
		PMenuSel({ fg = "#FFFFFF", bg = "#1976D2" }),
		PMenuSbar({ bg = "#90CAF9" }),
		PMenuThumb({ bg = "#64B5F6" }),
		StatusLine({ base = base.VertSplit, fg = "#BCAAA4" }),
		StatusLineNC({ base = base.VertSplit, fg = "#BCAAA4" }),

		TreesitterContext({ bg = "#f0f0f0", fg = "#BCAAA4", gui = "bold,italic" }),
		TreesitterContextLineNumber({ bg = "#f0f0f0", fg = "#979770", gui = "bold,italic" }),
	}
end)

-- Apply specs using lush tool-chain
vim.cmd("colorscheme zenbones")
lush.apply(lush.compile(specs))
