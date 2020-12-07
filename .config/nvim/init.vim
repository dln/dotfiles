call plug#begin('~/.local/share/nvim/plugged')

Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'
Plug '~/src/github.com/shelmangroup/nvim-shelman-theme'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'steelsojka/completion-buffers'

Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Ansible
Plug 'pearofducks/ansible-vim'

" Markdown
Plug 'jtratner/vim-flavored-markdown'
Plug 'tpope/vim-markdown'

" remove trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

" comment lines out (gc in visual mode)
Plug 'tomtom/tcomment_vim'

" Golang
Plug 'fatih/vim-go'

" Terraform
Plug 'jvirtanen/vim-hcl'
Plug 'hashivim/vim-terraform'

" Jsonnet filetype plugin
Plug 'google/vim-jsonnet'

" toml
Plug 'cespare/vim-toml'

" Plug 'ervandew/supertab'
Plug 'google/vim-maktaba'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'kshenoy/vim-signature'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'NLKNguyen/papercolor-theme'
Plug 'tsandall/vim-rego'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

call plug#end()

" language en_US
set encoding=utf8
set ffs=unix,dos,mac

set ttimeout
set ttimeoutlen=0
" set timeoutlen=150
" set ttimeoutlen=100

filetype on " detect the type of file
filetype plugin indent on " load filetype plugins
syntax on

set history=1000 " How many lines of history to remember
set viminfo='100,!,f1,\"100,:40,%,n~/.config/nvim/viminfo

set isk+=_,$,@,%,#,- " none of these should be word dividers, so make them not be
set hidden
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set softtabstop=2
set autoindent
set copyindent
set smartindent " Don't mess with comments
set nojoinspaces
set ttyfast
set lazyredraw
set autochdir
set autoread        "Reload files changed outside vim
set nofoldenable    " disable folding
set title
set titlestring=%F%m\ %r\ %y

" Wordwrap
" set formatoptions=l
" formatoptions:
" c - autowrap COMMENTS using textwidth
" r - insert comment leader (?) on <enter>
" o - insert comment leader on 'o' or 'O'
" q - gq formats comments (?)
" n - recon numbered lists
" v - wrap on blanks
" t - autowrap TEXT using textwidth
set fo=croqnvt

set lbr
set backspace=eol,start,indent
"Backspace and cursor keys wrap to
set whichwrap+=<,>,h,l
set wrap

"" GUI
set visualbell
set noerrorbells
set ruler
set cursorline
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50

set number " line numbers
set numberwidth=6
set lz " lazy redraw
set so=7 "scope
set sidescroll=1
set scrolloff=10
set mouse=a
set switchbuf=usetab
set showtabline=1
set selection=exclusive
set shortmess=atI
set wildmenu
set wildmode=list:longest
set wildignore=*.swp,*.bak,*.pyc,*.class
set splitbelow " Preview window
set splitright
set updatetime=500

let mapleader=","

"" Session
let g:session_autosave = 'no'

"" Fancy status line.
set laststatus=0

"" Powerline
"set rtp+=/home/dln/.vim/bundle/powerline/powerline/bindings/vim

"" Markers / Signature
let g:SignatureMarkTextHL="Bookmark"

"" Minibuffer
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 0
let g:miniBufExplModSelTarget = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplVSplit = 25
let g:miniBufExplSplitBelow=1


"" minimap
let g:minimap_auto_start = 1


"" Searching
set showmatch
set incsearch
set ignorecase
set smartcase
set hlsearch

"" Use ack for grepping
set grepprg=ag
let g:ackprg='ag -H --nocolor --nogroup'

"" Bookmarks
let g:showmarks_enable=1
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

" Errormarker
let errormarker_errorgroup = "ErrorMsg"
let errormarker_warninggroup = "Todo"

"" Highlighting
map ,H :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"" Hide some files
let g:explHideFiles='^\.,.*\.class$,.*\.swp$,.*\.pyc$,.*\.swo$,\.DS_Store$,/tmp/v\d\d*'
let g:explDetailedHelp=1

"" Backup
set backup
set backupcopy=yes
set backupdir=~/tmp,/var/tmp,/tmp"
set directory=~/tmp,/var/tmp,/tmp"
let myvar = strftime("%y%m%d-%H%M")
let myvar = "set backupext=_". myvar
execute myvar
au BufWritePre * let &backupext = substitute(expand("%:p"), "\/", "_", "g")

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*/target/*,*/.git/*"


map <silent> <space> :Buffers<cr>
map <silent> <leader><tab> :Buffers<cr>
map <silent> <leader>; :Commits<cr>
map <silent> <leader>e :GitFiles<cr>
map <silent> <leader>d :Files<cr>
map <silent> <leader>f :History<cr>

" map <silent> <leader>g :BLines<cr>
map <silent> <leader>/ :Ag<cr>
map <silent> <leader>m :Marks<cr>

"" Key bindings
cnorea wd w\|:bd

nmap <C-N><C-N> :set invnumber<CR>

imap <silent>  <c-w>
inoremap <C-s> <esc>:w<cr>a
nnoremap <C-s> :w<cr>a


" C-Left, C-right
map <silent> <esc>[1;5D <C-Left>
map <silent> <esc>[1;5C <C-Right>
nnoremap <C-Left> b
vnoremap <C-S-Left> b
nnoremap <C-S-Left> gh<C-O>b
inoremap <C-S-Left> <C-\><C-O>gh<C-O>b
nnoremap <C-Right> w
vnoremap <C-S-Right> w
nnoremap <C-S-Right> gh<C-O>w
inoremap <C-S-Right> <C-\><C-O>gh<C-O>w

"" Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"" Comments
map <silent> <c-/> :TComment<cr>
imap <silent> <c-/> <c--><c-->

"" Git
let g:SCMDiffCommand = "git"
let VCSCommandDeleteOnHide = 1
let g:git_branch_status_nogit=""
let g:git_branch_status_around="[]"
let g:git_branch_status_text=""
let g:git_branch_status_head_current=1
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''


"" Buffer navigation
" map <silent> ` :b#<CR>
map <silent> <M-Tab> :b#<CR>


"" "Turn off search highlight
map <silent> <Bslash><cr> :noh<cr>
map <silent> <leader><cr> :noh<cr>
nmap <silent> ,/ :let @/=""<CR>

""
"" File types
""

au BufNewFile,BufRead manifest setlocal ft=json
au BufNewFile,BufRead *.aurora set filetype=python
au BufNewFile,BufRead *.avdl setlocal ft=avro-idl
au BufNewFile,BufRead *.avpr setlocal ft=json
au BufNewFile,BufRead *.bazel setlocal ft=bzl
au BufNewFile,BufRead *.cql set syntax=cql
au BufNewFile,BufRead *.go setlocal ft=go
au BufNewFile,BufRead *.g setlocal ft=antlr
au BufNewFile,BufRead *.js set ft=javascript
au BufNewFile,BufRead *.json setfiletype json
au BufNewFile,BufRead *.pig set filetype=pig syntax=pig
au BufNewFile,BufRead *.template setfiletype json
au BufNewFile,BufRead *.thrift setlocal ft=thrift
au BufNewFile,BufRead *.upstart set filetype=upstart
au BufNewFile,BufRead *.upstart.conf set filetype=upstart
au BufNewFile,BufRead SCons* set filetype=python

"" JavaScript, Json
let g:vim_json_syntax_conceal = 0

"" Jsonnet

let g:jsonnet_fmt_fail_silently = 0
autocmd BufNewFile,BufAdd,BufRead *.libjsonnet setlocal ft=jsonnet

" tags
set tags=./tags;/


"" syntax and completion
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

:lua << END
require'lspconfig'.gopls.setup{
}

require'lspconfig'.jdtls.setup{
}

require'lspconfig'.sumneko_lua.setup{
  cmd = {"lua-language-server"};
}

require'lspconfig'.terraformls.setup{
  cmd = {'terraform-ls', 'serve'}
}

require'lspconfig'.vimls.setup{
}

require'lspconfig'.yamlls.setup{
}

END

nmap <tab> <Plug>(completion_smart_tab)
nmap <s-tab> <Plug>(completion_smart_s_tab)
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'buffers', 'snippet']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]


" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


"" Diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_insert_delay = 1
let g:diagnostic_virtual_text_prefix = '⟸ '

call sign_define("LspDiagnosticsErrorSign", {"text" : "🔥", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "🎃", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "I", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "💡", "texthl" : "LspDiagnosticsHint"})

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
set completeopt=menuone,noinsert,noselect
set shortmess+=c

autocmd BufEnter * lua require'completion'.on_attach()


"" Treesitter

:lua << END
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        -- Or you can define your own textobjects like this
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
        },
      },
    },
  },
}
END

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

"" fzf
function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 20])])
    " let top = ((&lines - height) / 2) - 1
    let top = 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "┌" . repeat("─", width - 2) . "┐"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "└" . repeat("─", width - 2) . "┘"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

let g:fzf_preview_window = ''
let g:fzf_layout = { 'up': '~40%', 'window': 'call CreateCenteredFloatingWindow()' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Comment'],
  \ 'bg':      ['bg', 'Comment'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'PMenuSel', 'PMenuSel', 'Normal'],
  \ 'bg+':     ['bg', 'PMenuSel', 'PMenuSel'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Normal'] }

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command], 'window': { 'width': 0.9, 'height': 0.6 }}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

map <silent> <leader>/ :RG<cr>

" Show syntax highlight group in the status bar
map ,h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

set background=dark

" Golang
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_updatetime = 200
let g:go_snippet_engine = "neosnippet"
" Let coc.nvim handle GoDef.
let g:go_def_mapping_enabled = 0

autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap <S-k> <Plug>(go-doc)
autocmd FileType go nmap <Leader>d <Plug>(go-doc-vertical)


" Hugo
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1




"" Terminal

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" " undercurl in tmux
set t_Cs = "\e[4:3m"
set t_Ce = "\e[4:0m"


lua require('colorbuddy').colorscheme('shelman-dark')

map ,l :luafile %<CR>
