local opts = function(label)
  return { noremap = true, silent = true, desc = label }
end
require('mini.ai').setup()
require('mini.align').setup()
require('mini.bracketed').setup()
require('mini.comment').setup()
require('mini.diff').setup()
require('mini.extra').setup()
require('mini.icons').setup()
require('mini.jump').setup()
require('mini.surround').setup()
require('mini.splitjoin').setup()
require('mini.trailspace').setup()

local bufremove = require('mini.bufremove')
bufremove.setup()
vim.keymap.set('n', '<space>bd', bufremove.delete, opts("Delete"))

require('mini.cursorword').setup({
  delay = 800
})

require('mini.completion').setup({
   window = {
    info = { height = 25, width = 80, border = 'rounded' },
    signature = { height = 25, width = 80, border = 'rounded' },
  },
})
local imap_expr = function(lhs, rhs)
  vim.keymap.set('i', lhs, rhs, { expr = true })
end
imap_expr('<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

  local keycode = vim.keycode or function(x)
    return vim.api.nvim_replace_termcodes(x, true, true, true)
  end
  local keys = {
    ['cr']        = keycode('<CR>'),
    ['ctrl-y']    = keycode('<C-y>'),
    ['ctrl-y_cr'] = keycode('<C-y><CR>'),
  }

  _G.cr_action = function()
    if vim.fn.pumvisible() ~= 0 then
      -- If popup is visible, confirm selected item or add new line otherwise
      local item_selected = vim.fn.complete_info()['selected'] ~= -1
      return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
    else
      -- If popup is not visible, use plain `<CR>`. You might want to customize
      -- according to other plugins. For example, to use 'mini.pairs', replace
      -- next line with `return require('mini.pairs').cr()`
      return keys['cr']
    end
  end

  vim.keymap.set('i', '<CR>', 'v:lua._G.cr_action()', { expr = true })



local hipatterns = require('mini.hipatterns')
hipatterns.setup({
  highlighters = {
    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
    fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
    todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
    note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
    hex_color = hipatterns.gen_highlighter.hex_color(),
  }
})

local indentscope = require('mini.indentscope')
indentscope.setup({
  draw = {
    delay = 10,
    animation = indentscope.gen_animation.none(),
  },
  symbol = '│',
})

require('mini.jump2d').setup({
  mappings = { start_jumping = 'gw' }
})

require('mini.pick').setup({
  mappings = { move_down = '<tab>' },
  options = { use_cache = true }
})
MiniPick.registry.files_root = function(local_opts)
  local root_patterns = { ".jj", ".git" }
  local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])
  local_opts.cwd = root_dir
  local_opts.tool = "rg"
  return MiniPick.builtin.files(local_opts, { source = { cwd = root_dir, tool = "ripgrep" } })
end
MiniPick.registry.grep_live_root = function(local_opts)
  local root_patterns = { ".jj", ".git" }
  local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])
  local_opts.cwd = root_dir
  return MiniPick.builtin.grep_live(local_opts, { source = { cwd = root_dir } })
end
vim.keymap.set('n', '<space>/', "<cmd>Pick grep_live_root<cr>", opts("Live Grep"))
vim.keymap.set('n', '<space>fF', "<cmd>Pick files<cr>", opts("FindCWD"))
vim.keymap.set('n', '<space>ff', "<cmd>Pick files_root<cr>", opts("Find"))
vim.keymap.set('n', '<space>fr', "<cmd>Pick oldfiles<cr>", opts("Recent"))
vim.keymap.set('n', '<space>bb', "<cmd>Pick buffers<cr>", opts("Switch"))
vim.keymap.set('n', '<space>d', "<cmd>Pick diagnostics<cr>", opts("Diagnostics"))
vim.keymap.set('n', '<tab>', "<cmd>Pick buffers include_current=false<cr>", opts("Buffers"))


local miniclue = require('mini.clue')
miniclue.setup({ -- cute prompts about bindings
  triggers = {
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    { mode = 'n', keys = '<space>' },
    { mode = 'x', keys = '<space>' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },

    -- Bracketed
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },
  },
  clues = {
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
  window = {
    delay = 15,
  }
})

local notify_win_config = function()
  local has_statusline = vim.o.laststatus > 0
  local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
  return { anchor = 'SE', border = 'rounded', col = vim.o.columns, row = vim.o.lines - pad }
end
require('mini.notify').setup({
  window = {
    config = notify_win_config,
    winblend = 0,
  },
})

require('mini.starter').setup({
  header =
    [[ ______                      _
(_____ \     _              (_)
 _____) )___| |_  ____  ____ _  ____
|  ____/ _  |  _)/ _  |/ _  | |/ _  |
| |   ( ( | | |_( ( | ( ( | | ( ( | |
|_|    \_||_|\___)_||_|\_|| |_|\_||_|
                      (_____|]]
})
