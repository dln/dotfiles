require('mini.ai').setup()
require('mini.align').setup()
require('mini.bracketed').setup()
require('mini.bufremove').setup()
require('mini.comment').setup()
require('mini.diff').setup()
require('mini.extra').setup()
require('mini.icons').setup()
require('mini.jump').setup()
require('mini.surround').setup()
require('mini.splitjoin').setup()
require('mini.trailspace').setup()

require('mini.cursorword').setup({
  delay = 800
})

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

local picker_win_config = function()
  local height = vim.o.lines - 8
  local width = 80
  return {
    border = 'rounded',
    anchor = 'NW',
    height = height,
    width = width,
    row = 2,
    col = math.floor((vim.o.columns - width) / 2),
  }
end

require('mini.pick').setup({
  mappings = {
    move_down      = '<tab>',
    toggle_info    = '<C-k>',
    toggle_preview = '<C-p>',
  },
  options = { use_cache = true },
  window = {
    config = picker_win_config,
  },
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
    delay = 0,
    config = {
      border = 'rounded',
      width = 'auto',
    },
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
