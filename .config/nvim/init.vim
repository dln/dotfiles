lua require("init")

function s:recompile_plugins()
  luafile %
  PackerCompile
endfunction

"" Autocommands

augroup recompile_plugins
  autocmd!
  autocmd BufWritePost plugins.lua call <SID>recompile_plugins()
augroup END
