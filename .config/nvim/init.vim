"" Vundle
" set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.local/share/nvim/plugged')

" Autocomplete
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-tmux'
" Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-go'
" Plug 'ncm2/ncm2-racer'
" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'janko/vim-test'
Plug 'jgdavey/tslime.vim'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Markdown
Plug 'jtratner/vim-flavored-markdown'
Plug 'tpope/vim-markdown'

" remove trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

" comment lines out (gc in visual mode)
Plug 'tomtom/tcomment_vim'

" Pimped out bar at the bottom of current buffer
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Theme
Plug 'kaicataldo/material.vim'


" Golang
Plug 'fatih/vim-go'
Plug 'mdempsky/gocode'

" Bazel
Plug 'bazelbuild/vim-bazel'
Plug 'bazelbuild/vim-ft-bzl'

" Rust
Plug 'racer-rust/vim-racer'
Plug 'roxma/nvim-cm-racer'
Plug 'rust-lang/rust.vim'

" Terraform
Plug 'b4b4r07/vim-hcl'
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
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'

" Powershell
Plug 'PProvost/vim-ps1'


" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" PowerShell
Plug 'PProvost/vim-ps1'

" Webdev
Plug 'burner/vim-svelte'

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

set autochdir
set autoread        "Reload files changed outside vim
set nofoldenable    " disable folding

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

let mapleader=","

"" Session
let g:session_autosave = 'no'

"" Fancy status line.
set laststatus=2

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

"" Wayland clipboard copy paste
map <silent> ,v :r!wl-paste<cr>


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
set backupdir=~/.vim/backup,~/.tmp,~/tmp,/var/tmp,/tmp"
set directory=~/.vim/backup,~/.tmp,~/tmp,/var/tmp,/tmp"
let myvar = strftime("%y%m%d-%H%M")
let myvar = "set backupext=_". myvar
execute myvar
au BufWritePre * let &backupext = substitute(expand("%:p"), "\/", "_", "g")

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*/target/*,*/.git/*"


map <silent> <space> :Buffers<cr>
map <silent> <leader>` :Buffers<cr>
map <silent> <leader>; :Commits<cr>
map <silent> <leader>e :GitFiles<cr>
map <silent> <leader>d :Files<cr>
map <silent> <leader>f :History<cr>
" map <silent> <leader>g :BLines<cr>
map <silent> <leader>/ :Ag<cr>
map <silent> <leader>m :Marks<cr>

"" Key bindings
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

"" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "✗"
let syntastic_style_error_symbol = "✗"
let g:syntastic_warning_symbol = "∙∙"
let syntastic_style_warning_symbol = "∙∙"

"" ALE
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = ''      "       ﱥ   ﬡ  樂
let g:ale_sign_warning = ''
" let g:ale_linters = {'go': ['gofmt']}
" let g:ale_linters = {'go': ['go build', 'gofmt', 'golint', 'gometalinter', 'gosimple', 'go vet', 'staticcheck']}
" let g:ale_linters = {'go': ['gofmt', 'golint', 'gometalinter', 'gosimple', 'go vet', 'staticcheck']}
let g:ale_linters = {'go': ['gofmt', 'gometalinter']}
let g:go_gometalinter_options = join([
 \    '--fast'
 \ ], ' ')
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


"" Buffer navigation
map <silent> ` :b#<CR>


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



"" Scala
autocmd BufNewFile,BufAdd,BufRead build.sbt setlocal ft=scala
autocmd BufNewFile,BufAdd,BufRead *.scala setlocal ft=scala
autocmd FileType scala setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

"" Rust
autocmd FileType rust setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

"" Clojure
let g:paredit_mode=0
let g:clj_highlight_builtins=1      " Highlight Clojure's builtins
let g:clj_paren_rainbow=1           " Rainbow parentheses'!

"" Python
au FileType python
    \ setlocal efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m |
    \ setlocal makeprg=python\ % |
    \ setlocal tabstop=4 softtabstop=4 shiftwidth=4 |
    \ setlocal nosmartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

" pydoc integration
let g:pydoc_highlight = 0
let python_highlight_all = 1
let g:pcs_check_when_saving = 0
let g:pymode_lint = 0
let g:pymode_lint_checker = "pyflakes"

" enable ncm2 for all buffers
" autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect


"" COC completion

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>


function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd CursorHold * silent call CocActionAsync('doHover')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" vmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)


" tags
set tags=./tags;/

" C++

" Add highlighting for function definition in C++
function! EnhanceCppSyntax()
    syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
    hi def link cppFuncDef Special
endfunction
autocmd Syntax cpp call EnhanceCppSyntax()
autocmd FileType cpp setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" HTML
au FileType html
                \ set makeprg=tidy\ -qe\ -access\ 3\ % |
                \ set errorformat=line\ %l\ column\ %c\ \-\ %m
" let g:html_indent_tags .= '\|p'
" let g:html_indent_tags .= '\|li'


au FileType xml
    \ set makeprg=tidy\ -qe\ -access\ 3\ % |
    \ set errorformat=line\ %l\ column\ %c\ \-\ %m

"" fzf

let g:fzf_layout = { 'up': '~40%' }
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

" Show syntax highlight group in the status bar
map ,h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

set background=dark
let g:one_allow_italics=1
let g:PaperColor_Light_Override = { 'Background' : '#fefe00' }


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


"" Neosnippet
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)
" imap <expr> <CR>  (pumvisible() ?  "\<c-y>\<Plug>(expand_or_nl)" : "\<CR>")
" imap <expr> <Plug>(expand_or_nl) (cm#completed_is_snippet() ? "\<C-k>":"\<CR>")
"
imap <c-j>     <Plug>(neosnippet_expand_or_jump)
vmap <c-j>     <Plug>(neosnippet_expand_or_jump)
inoremap <silent> <c-u> <c-r>=cm#sources#neosnippet#trigger_or_popup("\<Plug>(neosnippet_expand_or_jump)")<cr>
vmap <c-u>     <Plug>(neosnippet_expand_target)
" expand parameters
let g:neosnippet#enable_completed_snippet=1

" Hugo
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1



"" Airline
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_x = ''   " Hide file type
let g:airline_section_z = "\uf0c9 %l \ufb87 %c"
 let g:airline_mode_map = {
      \ '__' : '-',
      \ 'c'  : 'C',
      \ 'i'  : 'I',
      \ 'ic' : 'I',
      \ 'ix' : 'I',
      \ 'n'  : "\ue62b",
      \ 'ni' : "\ue62b",
      \ 'no' : "\ue62b",
      \ 'R'  : 'R',
      \ 'Rv' : 'R',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ 't'  : 'T',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ }

"" Testing
let test#strategy = "tslime"
nmap <M-t> :TestLast<CR>
imap <M-t> :TestLast<CR>
nmap <M-S-t> :TestFile<CR>
imap <M-S-t> :TestFile<CR>



"" Terminal

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"


let darkmode=$DARKMODE
if darkmode == 'true'
  let g:material_terminal_italics = 1
  let g:material_theme_style = 'darker'
  let g:airline_theme='distinguished'
  color material
 else
   let g:airline_theme='sol'
   color dln-light
endif

map ,l :color dln-light<CR>

let s:hidden_all = 1
set noshowmode
set noruler
set laststatus=0
set noshowcmd

function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <S-h> :call ToggleHiddenAll()<CR>

