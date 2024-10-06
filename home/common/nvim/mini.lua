          local opts = function(label)
            return {noremap = true, silent = true, desc = label}
          end
          require('mini.ai').setup()
          require('mini.align').setup()
          require('mini.bracketed').setup()
          require('mini.completion').setup()
          require('mini.diff').setup()
          require('mini.extra').setup()
          require('mini.icons').setup()
          require('mini.jump').setup()
          -- require('mini.pairs').setup()
          -- require('mini.statusline').setup()
          require('mini.surround').setup()
          require('mini.splitjoin').setup()

          require('mini.files').setup()
          local oil_style = function()
            if not MiniFiles.close() then
              MiniFiles.open(vim.api.nvim_buf_get_name(0))
              MiniFiles.reveal_cwd()
            end
          end
          vim.keymap.set('n', '-', oil_style, opts("File Explorer"));

          local hipatterns = require('mini.hipatterns')
          hipatterns.setup({  -- highlight strings and colors
            highlighters = {
              -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
              fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
              hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
              todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
              note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

              -- Highlight hex color strings (`#rrggbb`) using that color
              hex_color = hipatterns.gen_highlighter.hex_color(),
            }
          })

          require('mini.jump2d').setup({
            mappings = {
              start_jumping = 'gw'
            }
          })

          require('mini.pick').setup({
            mappings = {
              move_down = '<tab>'
            },
            options = {
              use_cache = true
            }
          })
          MiniPick.registry.files_root = function(local_opts)
            local root_patterns = { ".jj", ".git" }
            local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])
            local opts = { source = { cwd = root_dir, tool = "ripgrep"} }
            local_opts.cwd = root_dir
            local_opts.tool = "rg"
            return MiniPick.builtin.files(local_opts, opts)
          end
          MiniPick.registry.grep_live_root = function(local_opts)
            local root_patterns = { ".jj", ".git" }
            local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])
            local opts = { source = { cwd = root_dir } }
            local_opts.cwd = root_dir
            return MiniPick.builtin.grep_live(local_opts, opts)
          end
          vim.keymap.set('n', '<space>/', "<cmd>Pick grep_live_root<cr>", opts("Live Grep"))
          vim.keymap.set('n', '<space>F', "<cmd>Pick files<cr>", opts("Find Files in CWD"))
          vim.keymap.set('n', '<space>ff', "<cmd>Pick files_root<cr>", opts("Find Files"))
          vim.keymap.set('n', '<space>fr', "<cmd>Pick oldfiles<cr>", opts("Recent Files"))
          vim.keymap.set('n', '<space>b', "<cmd>Pick buffers<cr>", opts("Buffers"))
          vim.keymap.set('n', '<space>d', "<cmd>Pick diagnostics<cr>", opts("Diagnostics"))
          vim.keymap.set('n', '<tab>', "<cmd>Pick buffers include_current=false<cr>", opts("Buffers"))
          vim.keymap.set('n', "<space>'", "<cmd>Pick resume<cr>", opts("Last Picker"))
          vim.keymap.set('n', "<space>g", "<cmd>Pick git_commits<cr>", opts("Git Commits"))


          local miniclue = require('mini.clue')
          miniclue.setup({                   -- cute prompts about bindings
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

