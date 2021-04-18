vim.bo.undofile = true
vim.cmd('set completeopt-=preview')
vim.cmd('set viewoptions-=options')
vim.g.mapleader = ','
vim.o.clipboard = 'unnamed'
vim.o.hidden = true
vim.o.mouse = 'a'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.ttimeout = true
vim.o.ttimeoutlen = 50
vim.o.updatetime = 100
vim.o.autochdir = true
vim.o.backupdir = "/home/dln/.local/share/nvim/backup//"

--- Indent
vim.bo.expandtab = true
vim.bo.smartindent = true
vim.o.joinspaces = false
vim.o.listchars = 'extends:›,precedes:‹,nbsp:·,tab:→ ,trail:·'
vim.wo.foldlevel = 99
vim.wo.linebreak = true
vim.wo.list = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

--- Search
vim.cmd('set path+=**')
vim.cmd('set wildignore+=*/tmp/*,/var/*,*.so,*.swp,*.zip,*.tar,*.pyc')
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wildmode = 'longest:full,full'

if vim.fn.executable('rg') then
  vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'
end

--- Completion
vim.cmd('set shortmess+=c')
vim.o.completeopt = 'menuone,noinsert,noselect'

--- Appearance
vim.o.background = 'light'
vim.o.scrolloff = 8
vim.o.showmode = false
vim.o.sidescrolloff = 5
vim.o.termguicolors = true
vim.wo.cursorline = true
vim.wo.number = true

--- Key mappings
local map = require("dln.utils").map
map('n', '<C-l>', ':let @/=""<CR>')  -- clear search
map('n', 'H', '^')
map('n', 'L', '$')
map('i', '', '<C-w>')

--- Plugins
vim.g.netrw_dirhistmax = 0

require('plugins')
