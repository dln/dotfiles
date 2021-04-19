" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/dln/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/dln/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/dln/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/dln/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/dln/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["colorbuddy.vim"] = {
    loaded = true,
    path = "/home/dln/.local/share/nvim/site/pack/packer/start/colorbuddy.vim"
  },
  ["folding-nvim"] = {
    loaded = true,
    path = "/home/dln/.local/share/nvim/site/pack/packer/start/folding-nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nè\4\0\0\2\0\16\0!6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0005\1\a\0=\1\6\0006\0\0\0009\0\1\0005\1\t\0=\1\b\0006\0\0\0009\0\1\0005\1\v\0=\1\n\0006\0\0\0009\0\1\0+\1\2\0=\1\f\0006\0\0\0009\0\1\0+\1\2\0=\1\r\0006\0\0\0009\0\1\0005\1\15\0=\1\14\0K\0\1\0\1\5\0\0\fIndent1\fIndent2\fIndent3\fIndent4)indent_blankline_char_highlight_list4indent_blankline_show_trailing_blankline_indent-indent_blankline_show_first_indent_level\1\3\0\0\ttext\rmarkdown&indent_blankline_filetype_exclude\1\3\0\0\thelp\rterminal%indent_blankline_buftype_exclude\1\2\0\0\16IndentSpace/indent_blankline_space_char_highlight_list\b‚¨ù indent_blankline_space_char\b‚îÇ\26indent_blankline_char\6g\bvim\0" },
    loaded = true,
    path = "/home/dln/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  kommentary = {
    config = { "\27LJ\2\nÎ\1\0\0\6\0\v\0\0226\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0'\4\b\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\t\0'\3\a\0'\4\n\0004\5\0\0B\0\5\1K\0\1\0$<Plug>kommentary_visual_default\6v\"<Plug>kommentary_line_default\6\31\6n\20nvim_set_keymap\bapi\bvim\26use_extended_mappings\22kommentary.config\frequire\0" },
    loaded = true,
    path = "/home/dln/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\2\n}\0\1\6\0\a\0\22)\1\0\0\2\0\1\0X\1\17Ä6\1\0\0009\1\1\0019\1\2\1'\3\3\0B\1\2\2\18\3\1\0009\1\4\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\5\1'\4\6\0B\1\3\2X\2\3Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\a%s\nmatch\bsub\6.\fgetline\afn\bvimn\1\0\5\0\5\1\0223\0\0\0006\1\1\0009\1\2\0019\1\3\1'\3\4\0B\1\2\2\23\1\0\1\18\2\0\0\18\4\1\0B\2\2\2\15\0\2\0X\3\aÄ\18\2\0\0\23\4\0\1B\2\2\2\15\0\2\0X\3\2Ä+\2\2\0X\3\1Ä+\2\1\0002\0\0ÄL\2\2\0\6.\bcol\afn\bvim\0\2ú\1\0\2\5\2\5\1\0256\2\0\0009\2\1\0029\2\2\2B\2\1\2\t\2\0\0X\2\5Ä-\2\0\0009\2\3\2\18\4\0\0D\2\2\0X\2\rÄ-\2\1\0B\2\1\2\15\0\2\0X\3\5Ä-\2\0\0009\2\3\2\18\4\1\0D\2\2\0X\2\4Ä6\2\0\0009\2\1\0029\2\4\2D\2\1\0K\0\1\0\0¿\1¿\19compe#complete\15term_codes\15pumvisible\afn\bvim\2ç\3\1\0\a\0\22\0%6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\0\0'\2\6\0B\0\2\0023\1\a\0006\2\b\0003\3\n\0=\3\t\0029\2\v\0'\4\f\0'\5\r\0'\6\14\0B\2\4\0019\2\v\0'\4\f\0'\5\15\0'\6\16\0B\2\4\0019\2\v\0'\4\17\0'\5\18\0'\6\19\0B\2\4\0019\2\v\0'\4\f\0'\5\20\0'\6\21\0B\2\4\0012\0\0ÄK\0\1\0\25compe#close('<C-e>')\n<C-e>\26compe:#confirm('<CR')\t<CR>\6x%v:lua.complete('<C-p>', '<C-h>')\f<S-Tab>%v:lua.complete('<C-n>', '<Tab>')\n<Tab>\ais\tmapx\0\rcomplete\a_G\0\14dln.utils\vsource\1\0\3\vbuffer\2\rnvim_lsp\2\rnvim_lua\2\1\0\1\15min_length\3\0\nsetup\ncompe\frequire\0" },
    loaded = true,
    path = "/home/dln/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\ná\4\0\0\6\0\20\0+6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0\18\1\0\0'\3\4\0'\4\5\0'\5\6\0B\1\4\1\18\1\0\0'\3\a\0'\4\b\0'\5\t\0B\1\4\1\18\1\0\0'\3\4\0'\4\n\0'\5\v\0B\1\4\1\18\1\0\0'\3\4\0'\4\f\0'\5\r\0B\1\4\1\18\1\0\0'\3\4\0'\4\14\0'\5\15\0B\1\4\1\18\1\0\0'\3\4\0'\4\16\0'\5\17\0B\1\4\1\18\1\0\0'\3\4\0'\4\18\0'\5\19\0B\1\4\1K\0\1\0*<Cmd>lua vim.lsp.buf.formatting()<CR>\agf/<Cmd>lua vim.lsp.buf.document_symbol()<CR>\ag0*<Cmd>lua vim.lsp.buf.references()<CR>\agr/<Cmd>lua vim.lsp.buf.type_definition()<CR>\b1gd*<Cmd>lua vim.lsp.buf.definition()<CR>\agd.<Cmd>lua vim.lsp.buf.signature_help()<CR>\n<C-k>\6i%<Cmd>lua vim.lsp.buf.hover()<CR>\6K\6n\bmap\14dln.utils\19dln.lsp-config\frequire\0" },
    loaded = true,
    path = "/home/dln/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-shelman-theme"] = {
    config = { "\27LJ\2\nP\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\18shelman-light\16colorscheme\15colorbuddy\frequire\0" },
    loaded = true,
    path = "/home/dln/.local/share/nvim/site/pack/packer/start/nvim-shelman-theme"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nâ\1\0\0\3\0\b\0\f6\0\0\0'\2\1\0B\0\2\0016\0\2\0009\0\3\0'\1\5\0=\1\4\0006\0\2\0009\0\3\0'\1\a\0=\1\6\0K\0\1\0\31nvim_treesitter#foldexpr()\rfoldexpr\texpr\15foldmethod\awo\bvim\19dln.treesitter\frequire\0" },
    loaded = true,
    path = "/home/dln/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/dln/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/home/dln/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/dln/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/dln/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/dln/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/dln/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope-github.nvim"] = {
    loaded = true,
    path = "/home/dln/.local/share/nvim/site/pack/packer/start/telescope-github.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nñ\4\0\0\6\0\16\0&6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0\18\1\0\0'\3\4\0'\4\5\0'\5\6\0B\1\4\1\18\1\0\0'\3\4\0'\4\a\0'\5\6\0B\1\4\1\18\1\0\0'\3\4\0'\4\b\0'\5\t\0B\1\4\1\18\1\0\0'\3\4\0'\4\n\0'\5\v\0B\1\4\1\18\1\0\0'\3\4\0'\4\f\0'\5\r\0B\1\4\1\18\1\0\0'\3\4\0'\4\14\0'\5\15\0B\1\4\1K\0\1\0;<cmd>lua require(\"telescope.builtin\").treesitter()<CR>\14<leader>tE<cmd>lua require(\"telescope.builtin\").lsp_document_symbols()<CR>\14<leader>s:<cmd>lua require(\"telescope.builtin\").git_files()<CR>\14<leader>e9<cmd>lua require(\"telescope.builtin\").oldfiles()<CR>\14<leader>f\14<leader>b8<cmd>lua require(\"telescope.builtin\").buffers()<CR>\f<space>\6n\bmap\14dln.utils\18dln.telescope\frequire\0" },
    loaded = true,
    path = "/home/dln/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  }
}

-- Config for: kommentary
try_loadstring("\27LJ\2\nÎ\1\0\0\6\0\v\0\0226\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0'\4\b\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\t\0'\3\a\0'\4\n\0004\5\0\0B\0\5\1K\0\1\0$<Plug>kommentary_visual_default\6v\"<Plug>kommentary_line_default\6\31\6n\20nvim_set_keymap\bapi\bvim\26use_extended_mappings\22kommentary.config\frequire\0", "config", "kommentary")
-- Config for: telescope.nvim
try_loadstring("\27LJ\2\nñ\4\0\0\6\0\16\0&6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0\18\1\0\0'\3\4\0'\4\5\0'\5\6\0B\1\4\1\18\1\0\0'\3\4\0'\4\a\0'\5\6\0B\1\4\1\18\1\0\0'\3\4\0'\4\b\0'\5\t\0B\1\4\1\18\1\0\0'\3\4\0'\4\n\0'\5\v\0B\1\4\1\18\1\0\0'\3\4\0'\4\f\0'\5\r\0B\1\4\1\18\1\0\0'\3\4\0'\4\14\0'\5\15\0B\1\4\1K\0\1\0;<cmd>lua require(\"telescope.builtin\").treesitter()<CR>\14<leader>tE<cmd>lua require(\"telescope.builtin\").lsp_document_symbols()<CR>\14<leader>s:<cmd>lua require(\"telescope.builtin\").git_files()<CR>\14<leader>e9<cmd>lua require(\"telescope.builtin\").oldfiles()<CR>\14<leader>f\14<leader>b8<cmd>lua require(\"telescope.builtin\").buffers()<CR>\f<space>\6n\bmap\14dln.utils\18dln.telescope\frequire\0", "config", "telescope.nvim")
-- Config for: indent-blankline.nvim
try_loadstring("\27LJ\2\nè\4\0\0\2\0\16\0!6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0005\1\a\0=\1\6\0006\0\0\0009\0\1\0005\1\t\0=\1\b\0006\0\0\0009\0\1\0005\1\v\0=\1\n\0006\0\0\0009\0\1\0+\1\2\0=\1\f\0006\0\0\0009\0\1\0+\1\2\0=\1\r\0006\0\0\0009\0\1\0005\1\15\0=\1\14\0K\0\1\0\1\5\0\0\fIndent1\fIndent2\fIndent3\fIndent4)indent_blankline_char_highlight_list4indent_blankline_show_trailing_blankline_indent-indent_blankline_show_first_indent_level\1\3\0\0\ttext\rmarkdown&indent_blankline_filetype_exclude\1\3\0\0\thelp\rterminal%indent_blankline_buftype_exclude\1\2\0\0\16IndentSpace/indent_blankline_space_char_highlight_list\b‚¨ù indent_blankline_space_char\b‚îÇ\26indent_blankline_char\6g\bvim\0", "config", "indent-blankline.nvim")
-- Config for: nvim-compe
try_loadstring("\27LJ\2\n}\0\1\6\0\a\0\22)\1\0\0\2\0\1\0X\1\17Ä6\1\0\0009\1\1\0019\1\2\1'\3\3\0B\1\2\2\18\3\1\0009\1\4\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\5\1'\4\6\0B\1\3\2X\2\3Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\a%s\nmatch\bsub\6.\fgetline\afn\bvimn\1\0\5\0\5\1\0223\0\0\0006\1\1\0009\1\2\0019\1\3\1'\3\4\0B\1\2\2\23\1\0\1\18\2\0\0\18\4\1\0B\2\2\2\15\0\2\0X\3\aÄ\18\2\0\0\23\4\0\1B\2\2\2\15\0\2\0X\3\2Ä+\2\2\0X\3\1Ä+\2\1\0002\0\0ÄL\2\2\0\6.\bcol\afn\bvim\0\2ú\1\0\2\5\2\5\1\0256\2\0\0009\2\1\0029\2\2\2B\2\1\2\t\2\0\0X\2\5Ä-\2\0\0009\2\3\2\18\4\0\0D\2\2\0X\2\rÄ-\2\1\0B\2\1\2\15\0\2\0X\3\5Ä-\2\0\0009\2\3\2\18\4\1\0D\2\2\0X\2\4Ä6\2\0\0009\2\1\0029\2\4\2D\2\1\0K\0\1\0\0¿\1¿\19compe#complete\15term_codes\15pumvisible\afn\bvim\2ç\3\1\0\a\0\22\0%6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\0\0'\2\6\0B\0\2\0023\1\a\0006\2\b\0003\3\n\0=\3\t\0029\2\v\0'\4\f\0'\5\r\0'\6\14\0B\2\4\0019\2\v\0'\4\f\0'\5\15\0'\6\16\0B\2\4\0019\2\v\0'\4\17\0'\5\18\0'\6\19\0B\2\4\0019\2\v\0'\4\f\0'\5\20\0'\6\21\0B\2\4\0012\0\0ÄK\0\1\0\25compe#close('<C-e>')\n<C-e>\26compe:#confirm('<CR')\t<CR>\6x%v:lua.complete('<C-p>', '<C-h>')\f<S-Tab>%v:lua.complete('<C-n>', '<Tab>')\n<Tab>\ais\tmapx\0\rcomplete\a_G\0\14dln.utils\vsource\1\0\3\vbuffer\2\rnvim_lsp\2\rnvim_lua\2\1\0\1\15min_length\3\0\nsetup\ncompe\frequire\0", "config", "nvim-compe")
-- Config for: nvim-treesitter
try_loadstring("\27LJ\2\nâ\1\0\0\3\0\b\0\f6\0\0\0'\2\1\0B\0\2\0016\0\2\0009\0\3\0'\1\5\0=\1\4\0006\0\2\0009\0\3\0'\1\a\0=\1\6\0K\0\1\0\31nvim_treesitter#foldexpr()\rfoldexpr\texpr\15foldmethod\awo\bvim\19dln.treesitter\frequire\0", "config", "nvim-treesitter")
-- Config for: nvim-shelman-theme
try_loadstring("\27LJ\2\nP\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\18shelman-light\16colorscheme\15colorbuddy\frequire\0", "config", "nvim-shelman-theme")
-- Config for: nvim-lspconfig
try_loadstring("\27LJ\2\ná\4\0\0\6\0\20\0+6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0\18\1\0\0'\3\4\0'\4\5\0'\5\6\0B\1\4\1\18\1\0\0'\3\a\0'\4\b\0'\5\t\0B\1\4\1\18\1\0\0'\3\4\0'\4\n\0'\5\v\0B\1\4\1\18\1\0\0'\3\4\0'\4\f\0'\5\r\0B\1\4\1\18\1\0\0'\3\4\0'\4\14\0'\5\15\0B\1\4\1\18\1\0\0'\3\4\0'\4\16\0'\5\17\0B\1\4\1\18\1\0\0'\3\4\0'\4\18\0'\5\19\0B\1\4\1K\0\1\0*<Cmd>lua vim.lsp.buf.formatting()<CR>\agf/<Cmd>lua vim.lsp.buf.document_symbol()<CR>\ag0*<Cmd>lua vim.lsp.buf.references()<CR>\agr/<Cmd>lua vim.lsp.buf.type_definition()<CR>\b1gd*<Cmd>lua vim.lsp.buf.definition()<CR>\agd.<Cmd>lua vim.lsp.buf.signature_help()<CR>\n<C-k>\6i%<Cmd>lua vim.lsp.buf.hover()<CR>\6K\6n\bmap\14dln.utils\19dln.lsp-config\frequire\0", "config", "nvim-lspconfig")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
