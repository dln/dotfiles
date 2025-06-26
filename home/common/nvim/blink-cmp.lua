require 'blink-cmp'.setup({
  keymap = {
    preset = 'enter',
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
    ['<PageDown>'] = { 'scroll_documentation_down', 'fallback' },
    ['<PageUp>'] = { 'scroll_documentation_up', 'fallback' },
    ['<A-y>'] = require('minuet').make_blink_map(),
  },
  completion = {
    accept = {
      auto_brackets = { enabled = true, },
    },

    documentation = {
      auto_show = true,
      auto_show_delay_ms = 800,
      window = { border = 'rounded', },
    },

    ghost_text = { enabled = false },

    list = {
      selection = {
        preselect = false,
        auto_insert = false
      },
    },

    menu = {
      auto_show = true,
      border = 'rounded',
      direction_priority = { 'n', 's' },
      draw = {
        components = {
          kind_icon = {
            ellipsis = false,
            text = function(ctx)
              local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
              return kind_icon
            end,
            -- Optionally, you may also use the highlights from mini.icons
            highlight = function(ctx)
              local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              return hl
            end,
          }
        }
      }
    },

    trigger = {
      prefetch_on_insert = false
    },
  },

  fuzzy = {
    prebuilt_binaries = {
      download = false
    },
  },

  signature = {
    enabled = true,
    window = { border = 'rounded', },
  },

  cmdline = {
    keymap = { preset = 'inherit' },
    completion = { menu = { auto_show = false } },
  },

  sources = {
    default = {
      'lsp',
      'emoji',
      'minuet',
    },
    providers = {
      emoji = {
        module = "blink-emoji",
        name = "Emoji",
        score_offset = -40,
        opts = { insert = true },
      },
      minuet = {
        name = 'minuet',
        module = 'minuet.blink',
        async = true,
        timeout_ms = 3000, -- Should match minuet.config.request_timeout * 1000
        score_offset = -50,
      },
    },
  },
})
