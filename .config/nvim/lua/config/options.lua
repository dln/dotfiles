vim.cmd([[set undofile]])
vim.cmd([[set completeopt-=preview]])
vim.cmd([[set viewoptions-=options]])
vim.g.mapleader = ","
vim.o.hidden = true
vim.o.mouse = "a"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.ttimeout = true
vim.o.ttimeoutlen = 50
vim.o.updatetime = 100
vim.o.autochdir = false
vim.o.backupdir = "/home/dln/.local/share/nvim/backup/"
vim.o.backup = true
vim.g.netrw_dirhistmax = 0
vim.o.clipboard = "unnamedplus"
vim.g.do_filetype_lua = 1
vim.o.spell = false
vim.o.spelllang = "en_us"
vim.opt.winbar = nil

--- Indent
vim.o.autoindent = true
vim.o.breakindent = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.joinspaces = false
vim.o.listchars = "extends:›,precedes:‹,nbsp:·,tab:→ ,trail:·"
vim.wo.foldlevel = 99
vim.wo.linebreak = true
vim.wo.list = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2

--- Search
vim.cmd("set path+=**")
vim.cmd("set wildignore+=/var/*,*.so,*.swp,*.zip,*.tar,*.pyc")
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wildmode = "longest:full,full"

if vim.fn.executable("rg") then
	vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"
end

--- Completion
vim.cmd("set shortmess+=c")
vim.opt.completeopt = { "menuone", "noselect" }

--- Appearance
vim.o.scrolloff = 7
vim.o.showmode = false
vim.o.sidescrolloff = 5
vim.o.termguicolors = true
vim.wo.cursorline = true
vim.wo.number = true
vim.wo.signcolumn = "yes"
vim.o.laststatus = 3
vim.o.cmdheight = 1
-- vim.o.statusline = "═"
-- vim.o.title = true
-- vim.o.titlestring = "%F%m %r %y"
vim.o.fillchars = "stl: ,stlnc: ,eob:🮙"
-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.g.netrw_dirhistmax = 0

--- Key mappings
vim.keymap.set("n", "<C-l>", ':let @/=""<CR>') -- clear search
vim.keymap.set("n", ",L", ":luafile %<CR>") -- Reload lua file

-- AutoCommand OSC7 workaround for tmux
-- see https://github.com/neovim/neovim/issues/21771
vim.cmd([[autocmd DirChanged * call chansend(v:stderr, printf("\033]7;file://%s\033\\", v:event.cwd))]])
