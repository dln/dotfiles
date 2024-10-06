-- vim.g.mapleader = "<space>"
vim.g.maplocalleader = ','

-- UI

vim.opt.cursorline = true
vim.opt.laststatus = 0
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.rulerformat = "" -- FIXME: fancify!
vim.opt.rulerformat = "%36(%5l,%-6(%c%V%) %t%)%*"
vim.opt.syntax = "on"
vim.opt.termguicolors = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Tab completion
-- vim.opt.wildmode="list:longest,full"
vim.opt.wildignore="*.swp,*.o,*.so,*.exe,*.dll"

-- Whitespaces
vim.opt.breakindent = true
vim.opt.copyindent = true
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.list = true
vim.opt.listchars="tab:»·,trail:·"

-- Folds
vim.opt.foldenable = false
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

--

vim.o.autochdir = true
vim.o.fillchars = "stl: ,stlnc: ,eob:░,vert:│"
vim.o.list = false
vim.o.scrolloff = 7
vim.o.splitkeep = "screen"
vim.o.updatetime = 50
vim.o.timeout = true
vim.o.timeoutlen = 10
vim.o.icm = "split"
-- vim.o.cia = 'kind,abbr,menu' wait for nightly to drop

vim.o.showmode = false


-- Use rg
vim.o.grepprg = [[rg --glob "!.jj" --glob "!.git" --no-heading --vimgrep --follow $*]]
vim.opt.grepformat = vim.opt.grepformat ^ { "%f:%l:%c:%m" }

vim.fn.sign_define(
	"DiagnosticSignError",
	{ text = "", hl = "DiagnosticSignError", texthl = "DiagnosticSignError", culhl = "DiagnosticSignErrorLine" }
)
vim.fn.sign_define(
	"DiagnosticSignWarn",
	{ text = "", hl = "DiagnosticSignWarn", texthl = "DiagnosticSignWarn", culhl = "DiagnosticSignWarnLine" }
)
vim.fn.sign_define(
	"DiagnosticSignInfo",
	{ text = "", hl = "DiagnosticSignInfo", texthl = "DiagnosticSignInfo", culhl = "DiagnosticSignInfoLine" }
)
vim.fn.sign_define(
	"DiagnosticSignHint",
	{ text = "", hl = "DiagnosticSignHint", texthl = "DiagnosticSignHint", culhl = "DiagnosticSignHintLine" }
)

-- Make <Tab> work for snippets
vim.keymap.set({ "i", "s" }, "<Tab>", function()
	if vim.snippet.active({ direction = 1 }) then
		return "<cmd>lua vim.snippet.jump(1)<cr>"
	else
		return "<Tab>"
	end
end, { expr = true })

vim.keymap.set({ "n" }, "<c-/>", "gcc", { remap = true })
vim.keymap.set({ "v" }, "<c-/>", "gc", { remap = true })
vim.keymap.set({ "n" }, "<c-_>", "gcc", { remap = true })
vim.keymap.set({ "v" }, "<c-_>", "gc", { remap = true })
vim.keymap.set("n", "zz", "zt", { remap = true })
