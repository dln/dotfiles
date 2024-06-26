return {
  {
    "folke/flash.nvim",
    enabled = false,
  },

  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
    config = function()
      local util = require("lazyvim.util")
      util.on_load("telescope.nvim", function()
        local telescope = require("telescope")
        telescope.load_extension("smart_open")
      end)
    end,
  },

  {
    "telescope.nvim",
    keys = {
      {
        "<leader><leader>",
        function()
          require("telescope").extensions.smart_open.smart_open({
            filename_first = false,
          })
        end,
        desc = "Telescope smart open",
      },
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")
      opts.defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          anchor = "top",
          horizontal = {
            prompt_position = "top",
            mirror = false,
            preview_width = 0.49,
            -- preview_height = 0.5,
          },
          width = 0.9,
          height = 0.9,
          preview_cutoff = 10,
        },
        mappings = {
          i = {
            ["<esc>"] = actions.close, -- <Esc> close popup
            ["<C-u>"] = false,         -- <C-u> clear prompt
            ["<C-w>"] = false,         -- <C-u> clear prompt
          },
        },
        -- path_display = { "filename_first" },
        -- previewer = false,
        preview = {
          -- hide_on_startup = true,
        },
        sorting_strategy = "ascending",
        winblend = 0,
        wrap_results = true,
      }
    end,
  },
}
