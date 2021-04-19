return require('packer').startup(function()
  use "pierreglaser/folding-nvim"
  use 'tjdevries/colorbuddy.vim'
  use 'wbthomason/packer.nvim'

  use {
	  'b3nj5m1n/kommentary',
	  config = function()
		  require('kommentary.config').use_extended_mappings()
		  vim.api.nvim_set_keymap("n", "", "<Plug>kommentary_line_default", {}) -- C-/
		  vim.api.nvim_set_keymap("v", "", "<Plug>kommentary_visual_default", {}) -- C-/
	  end
  }

  use {
    "hrsh7th/nvim-compe",
    config = function()
      require("compe").setup {
        min_length = 0,
        source = {
          buffer = true,
          nvim_lsp = true,
          nvim_lua = true,
        }
      }
      local utils = require("dln.utils")
      local check_behind = function()
        local is_empty = function(col)
          return col <= 0 or vim.fn.getline("."):sub(col, col):match("%s")
        end
        local pos_col = vim.fn.col(".") - 1
        return is_empty(pos_col) and is_empty(pos_col - 1) and true or false
      end

      _G.complete = function(pum, empty)
        if vim.fn.pumvisible() == 1 then
          return utils.term_codes(pum)
        elseif check_behind() then
          return utils.term_codes(empty)
        else
          return vim.fn["compe#complete"]()
        end
      end

      utils.mapx("is", "<Tab>",   "v:lua.complete('<C-n>', '<Tab>')")
      utils.mapx("is", "<S-Tab>", "v:lua.complete('<C-p>', '<C-h>')")
      utils.mapx("x",  "<CR>",    "compe:#confirm('<CR')")
      utils.mapx("is", "<C-e>",   "compe#close('<C-e>')")
    end
  }


  use {
    "lukas-reineke/indent-blankline.nvim",
    branch = "lua",
    config = function()
      -- vim.wo.colorcolumn = "100"
      vim.g.indent_blankline_char = "│"
      vim.g.indent_blankline_space_char = "⬝"
      vim.g.indent_blankline_space_char_highlight_list = { 'IndentSpace' }
      -- vim.g.indent_blankline_char_list = {'|', '¦', '┆', '┊'}
      vim.g.indent_blankline_buftype_exclude = {"help", "terminal"}
      vim.g.indent_blankline_filetype_exclude = {"text", "markdown"}
      -- vim.g.indent_blankline_show_end_of_line = true
      vim.g.indent_blankline_show_first_indent_level = true
      vim.g.indent_blankline_show_trailing_blankline_indent = true
      vim.g.indent_blankline_char_highlight_list = { 'Indent1', 'Indent2', 'Indent3', 'Indent4'}
    end
  }

  use {
    'neovim/nvim-lspconfig',
    config = function()
      require('dln.lsp-config')
      local map = require('dln.utils').map
      map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
      map('i', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
      map('n', 'gd',  '<Cmd>lua vim.lsp.buf.definition()<CR>')
      map('n', '1gd', '<Cmd>lua vim.lsp.buf.type_definition()<CR>')
      map('n', 'gr',  '<Cmd>lua vim.lsp.buf.references()<CR>')
      map('n', 'g0',  '<Cmd>lua vim.lsp.buf.document_symbol()<CR>')
      map('n', 'gf',  '<Cmd>lua vim.lsp.buf.formatting()<CR>')
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
      'nvim-telescope/telescope-github.nvim'
    },
    config = function()
      require('dln.telescope')
      local map = require('dln.utils').map
      map('n', '<space>', '<cmd>lua require("telescope.builtin").buffers()<CR>')
      map('n', '<leader>b', '<cmd>lua require("telescope.builtin").buffers()<CR>')
      map('n', '<leader>f', '<cmd>lua require("telescope.builtin").oldfiles()<CR>')
      map('n', '<leader>e', '<cmd>lua require("telescope.builtin").git_files()<CR>')
      map('n', '<leader>s', '<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>')
      map('n', '<leader>t', '<cmd>lua require("telescope.builtin").treesitter()<CR>')
    end
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag"
    },
    config = function()
      require("dln.treesitter")
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
    end
  }

  use {
    "~/src/github.com/shelmangroup/nvim-shelman-theme",
    requires ={{'tjdevries/colorbuddy.vim'}},
    config = function()
      require('colorbuddy').colorscheme('shelman-light')
    end
  }

end)
