return {

	{
		"mcchrish/zenbones.nvim",
		lazy = false,
		priority = 1000,
		dependencies = {
			"rktjmp/lush.nvim",
		},
		config = function()
			vim.g.zenbones = {
				style = "light",
				lightness = "bright",
				colorize_diagnostic_underline_text = true,
				transparent_background = true,
			}

			local lush = require("lush")
			local base = require("zenbones")

			-- Create some specs
			---@diagnostic disable = undefined-global
			local specs = lush.parse(function(injected_functions)
				-- See https://github.com/rktjmp/lush.nvim/issues/109
				local sym = injected_functions.sym
				return {
					Special({ fg = "#EFEBE9" }),
					Normal({ fg = "#f0f0f0" }),
					Statement({ fg = "#e0e0e0", gui = "bold" }),
					Identifier({ fg = "#e7f0f7" }),
					Type({ fg = "#E3F2FD" }),
					CursorLine({ bg = "#102030" }),
					Error({ fg = "#d9534f", bg = "#110000" }),
					CursorLineNr({ fg = "#BCAAA4", bg = "#102030" }),
					MsgArea({ fg = "#A1887F", bg = "#f1f1f1" }),
					Number({ fg = "#32936F" }),
					sym("@field")({ fg = "#E3F2FD" }),
					String({ fg = "#C5E1A5", gui = "italic" }),
					sym("@string")({ fg = "#C5E1A5", gui = "italic" }),
					sym("@type.definition")({ fg = "#CE93D8", gui = "bold" }),
					sym("@function")({ fg = "#FFAB91", gui = "bold" }),
					sym("@method")(sym("@function")),
					-- Comment({ fg = "#114499", gui = "bold,italic" }),
					-- Comment({ fg = "#144EE1", gui = "bold,italic" }),
					Comment({ fg = "#E0E0E0", gui = "bold,italic" }),
					Todo({ fg = "#FF0000", gui = "bold,underline" }),
					EndOfBuffer({ fg = "#CBCFE1" }),
					CopilotSuggestion({ fg = "#0066cc", gui = "bold,italic" }),
					LineNr({ fg = "#9FA8AC", gui = "bold,italic" }),
					LineNrAbove({ fg = "#9F080C", gui = "bold,italic" }),
					IndentBlanklineContextChar({ fg = "#699FB5", gui = "italic" }),
					-- Indent1({ fg = "#DFDF9A", gui = "italic" }),
					-- Indent2({ fg = "#BAE1FF", gui = "italic" }),
					-- Indent3({ fg = "#BAFFC9", gui = "italic" }),
					-- Indent4({ fg = "#FFB3BA", gui = "italic" }),
					-- Indent5({ fg = "#FFDFBA", gui = "italic" }),
					-- Indent6({ fg = "#F3E5F5", gui = "italic" }),
					NormalFloat({ bg = "#263238" }),
					FloatBorder({ fg = "#FFB74D", bg = "#263238" }),
					TelescopeNormal({ bg = "#263238" }),
					TelescopeBorder({ fg = "#78909C", bg = "#263238" }),
					TelescopeSelection({ fg = "#FFF8E1", bg = "#01579B" }),
					DiagnosticSignError({ fg = "#ff2200", bg = "#220000", gui = "bold" }),
					DiagnosticVirtualTextInfo({ fg = "#0033bb", bg = "#f7fcff", gui = "bold,italic" }),
					DiagnosticVirtualTextWarn({ fg = "#bb2200", bg = "#110000", gui = "bold,italic" }),
					DiagnosticVirtualTextError({ fg = "#ff2200", bg = "#110000", gui = "italic" }),
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

					Hlargs({ fg = "#FFF8E1" }),

					IlluminatedWordText({ fg = "#FFA000" }),
					NotifyBackground({ bg = "#FFF8D6" }),

					NavicIcons({ fg = "#cc0000" }),
					NavicIconsFile({ fg = "#cc0000" }),
					NavicIconsModule({ fg = "#cc0000" }),
					NavicIconsNamespace({ fg = "#cc0000" }),
					NavicIconsPackage({ fg = "#cc0000" }),
					NavicIconsClass({ fg = "#cc0000" }),
					NavicIconsMethod({ fg = "#cc0000" }),
					NavicIconsProperty({ fg = "#cc0000" }),
					NavicIconsField({ fg = "#cc0000" }),
					NavicIconsConstructor({ fg = "#cc0000" }),
					NavicIconsEnum({ fg = "#cc0000" }),
					NavicIconsInterface({ fg = "#cc0000" }),
					NavicIconsFunction({ fg = "#cc0000" }),
					NavicIconsVariable({ fg = "#cc0000" }),
					NavicIconsConstant({ fg = "#cc0000" }),
					NavicIconsString({ fg = "#cc0000" }),
					NavicIconsNumber({ fg = "#cc0000" }),
					NavicIconsBoolean({ fg = "#cc0000" }),
					NavicIconsArray({ fg = "#cc0000" }),
					NavicIconsObject({ fg = "#cc0000" }),
					NavicIconsKey({ fg = "#cc0000" }),
					NavicIconsKeyword({ fg = "#cc0000" }),
					NavicIconsNull({ fg = "#cc0000" }),
					NavicIconsEnumMember({ fg = "#cc0000" }),
					NavicIconsStruct({ fg = "#cc0000" }),
					NavicIconsEvent({ fg = "#cc0000" }),
					NavicIconsOperator({ fg = "#cc0000" }),
					NavicIconsTypeParameter({ fg = "#cc0000" }),

					NavicText({ fg = "#cc0000", gui = "italic" }),

					-- LspCodeLens({ fg = "#00ff00", gui = "undercurl" }),
					-- LspSignatureActiveParameter({ fg = "#ff0000", bg = "#ffffcc" }),

					NoiceCmdlinePopup({ bg = "#263238" }),
					NoiceMini({ bg = "#263238" }),

					PMenu({ bg = "#263238" }),
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
			vim.cmd([[colorscheme zenbones]])
			lush.apply(lush.compile(specs))
		end,
	},

	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	name = "kanagawa",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("kanagawa").setup({
	-- 			commentStyle = { bold = true, italic = true },
	-- 			functionStyle = {},
	-- 			keywordStyle = {},
	-- 			statementStyle = { bold = true },
	-- 			typeStyle = {},
	-- 			variablebuiltinStyle = { italic = true },
	-- 			transparent = true, -- do not set background color
	-- 			colors = {
	--
	-- 				fujiWhite = "#FFFFFF",
	-- 			},
	-- 			overrides = {},
	-- 			theme = "default", -- Load "default" theme or the experimental "light" theme
	-- 		})
	-- 		-- vim.cmd([[colorscheme kanagawa ]])
	-- 	end,
	-- },

	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("catppuccin").setup({
	-- 			flavour = "mocha", -- latte, frappe, macchiato, mocha
	-- 			background = {
	-- 				light = "latte",
	-- 				dark = "latte",
	-- 			},
	-- 			transparent_background = true,
	-- 			show_end_of_buffer = true,
	-- 			styles = {
	-- 				comments = { "bold,italic" },
	-- 				conditionals = {},
	-- 				loops = {},
	-- 				functions = {},
	-- 				keywords = {},
	-- 				strings = { "italic" },
	-- 				variables = {},
	-- 				numbers = {},
	-- 				booleans = {},
	-- 				properties = {},
	-- 				types = {},
	-- 				operators = {},
	-- 			},
	-- 			custom_highlights = function(colors)
	-- 				return {
	-- 					Comment = { fg = colors.blue },
	-- 					Keyword = { fg = colors.rosewater },
	-- 					["@keyword"] = { fg = colors.rosewater },
	-- 					["@keyword.operator"] = { fg = colors.rosewater },
	-- 					["@keyword.function"] = { fg = colors.rosewater },
	-- 					["@keyword.return"] = { fg = colors.rosewater },
	-- 					["@constant.builtin"] = { fg = colors.peach, style = {} },
	-- 					-- ["@comment"] = { fg = colors.blue, style = { "bold,italic" } },
	-- 				}
	-- 			end,
	-- 		})
	-- 		vim.cmd([[colorscheme catppuccin ]])
	-- 	end,
	-- },
}
