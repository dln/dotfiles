vim.g.zenbones = {
  style = 'light',
  lightness = 'bright',
  colorize_diagnostic_underline_text = true,
  transparent_background = true,
  zenbones_compat = 1,
}

local lush = require "lush"
local base = require "zenbones"

-- Create some specs
local specs = lush.parse(function()
  return {
    CursorLine   { bg = "#f0f5fa" },
    CursorLineNr { fg = "#607D8B", bg="#f0f5fa" },
    String  { fg = "#33691E", gui = "italic" },
    Comment { fg = "#8D6E63", gui = "bold,italic" },
    LineNr  { fg = "#CFD8DC", gui = "bold,italic" },
    Indent1 { fg = "#FFEBEE", gui = "italic" },
    Indent2 { fg = "#E8F5E9", gui = "italic" },
    Indent3 { fg = "#E8F5E9", gui = "italic" },
    Indent4 { fg = "#FFF3E0", gui = "italic" },
    Indent5 { fg = "#E0F7FA", gui = "italic" },
    Indent6 { fg = "#F3E5F5", gui = "italic" },
    NormalFloat { bg = "#FFF9C4" },
    FloatBorder { fg = "#FFB74D", bg = "#FFF9C4" },
    TelescopeNormal    { bg = "#EFEBE9" },
    TelescopeBorder    { fg = "#A1887F", bg = "#EFEBE9" },
    TelescopeSelection { fg = "#FFFFFF", bg = "#1976D2" },
    DiagnosticVirtualTextError { fg = "#D50000", bg = "#FFEBEE" },
    DiagnosticUnderlineError { fg = "#DD2C00", gui = "undercurl" },
  }
end)

-- Apply specs using lush tool-chain
vim.cmd("colorscheme zenbones")
lush.apply(lush.compile(specs))
