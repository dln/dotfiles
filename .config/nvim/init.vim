"" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'VundleVim/Vundle.vim'
" Plugin 'bling/vim-airline'
Plugin 'chriskempson/base16-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'itchyny/lightline.vim'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tomtom/tcomment_vim'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()

set timeoutlen=250
set ttimeoutlen=200

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
set novisualbell
set noerrorbells
set ruler
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

"" X clipboard copy paste
map <silent> ,v :r!xclip -o<cr>


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
set backupdir=~/.vim/backup,~/.tmp,~/tmp,/var/tmp,/tmp"
set directory=~/.vim/backup,~/.tmp,~/tmp,/var/tmp,/tmp"
let myvar = strftime("%y%m%d-%H%M")
let myvar = "set backupext=_". myvar
execute myvar 
au BufWritePre * let &backupext = substitute(expand("%:p"), "\/", "_", "g")

"" CtrlP
let g:ctrlp_match_window = 'top'
" let g:ctrlp_custom_ignore = '\v[\/](.DS_Store|.sass-cache|.bundle|.git|.hg|.svn|node_modules|vendor|bower_components)$'
" let g:ctrlp_custom_ignore = '\v[\/]\.(DS_Storegit|hg|svn|optimized|compiled|node_modules|bower_components)$'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*/target/*,*/.git/*"
" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = 'node_modules$\|.lock$\|.gitkeep$\|tmp/\|bower_components$\|dist$'


let g:ctrlp_working_path_mode = 'ra'

map <silent> <space> :CtrlPBuffer<cr>
map <silent> ,` :CtrlPBuffer<cr>
map <silent> ,; :CtrlPChange<cr>
map <silent> ,e :CtrlPRoot<cr>
map <silent> ,d :CtrlPCurWD<cr>
map <silent> ,f :CtrlPMRUFiles<cr>
map <silent> ,g :CtrlPLine<cr>
map <silent> ,q :CtrlPQuickfix<cr>
map <silent> ,/ :CtrlPLine<cr>
map <silent> ,m :CtrlPBookmarkDir<cr>
map <silent> ,<C-m> :CtrlPBookmarkDirAdd<cr>

"" Key bindings
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

"" Comments
map <silent> <c-/> :TComment<cr>
imap <silent> <c-/> <c--><c-->

"" SCM Stuff
let g:SCMDiffCommand = "git"
let VCSCommandDeleteOnHide = 1
let g:git_branch_status_nogit=""
let g:git_branch_status_around="[]"
let g:git_branch_status_text=""
let g:git_branch_status_head_current=1

"" Buffer navigation
map <silent> ` :b#<CR>


"" "Turn off search highlight
map <silent> <leader><cr> :noh<cr>
nmap <silent> ,/ :let @/=""<CR>

""
"" File types
""

au BufNewFile,BufRead manifest setlocal ft=json
au BufNewFile,BufRead *.aurora set filetype=python 
au BufNewFile,BufRead *.avdl setlocal ft=avro-idl
au BufNewFile,BufRead *.avpr setlocal ft=json
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
autocmd FileType python set omnifunc=pythoncomplete#Complete

" pydoc integration
let g:pydoc_highlight = 0
let python_highlight_all = 1
let g:pcs_check_when_saving = 0
let g:pymode_lint = 0
let g:pymode_lint_checker = "pyflakes"


" YouCompleteMe
set completefunc=youcompleteme#Complete
set completeopt=preview,menuone

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

""
"" Color theme
""
if $TERM =~ '^xterm'
        set t_Co=256 
elseif $TERM =~ '^screen'
        set t_Co=256            " just guessing
elseif $TERM =~ '^rxvt'
        set t_Co=256
elseif $TERM =~ '^linux'
        set t_Co=8
else
        set t_Co=16
endif

if &term =~ "xterm" || &term =~ "screen" || &term == "screen"
    set t_Co=256
    if has("terminfo")
        let &t_Sf=nr2char(27).'[3%p1%dm'
        let &t_Sb=nr2char(27).'[4%p1%dm'
    else
        let &t_Sf=nr2char(27).'[3%dm'
        let &t_Sb=nr2char(27).'[4%dm'
    endif
endif

" Show syntax highlight group in the status bar
map ,h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

set background=light
let g:PaperColor_Light_Override = { 'Background' : '#fefe00' }

let g:lightline = {
  \ 'colorscheme': 'seoul256',
  \ }

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

color dln-light

