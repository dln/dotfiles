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


"" Temporary hacks

" Show syntax highlight group in the status bar
map ,H :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

map ,L :luafile %<CR>
