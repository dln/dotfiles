" Vim color file
" Maintainer:	Daniel Lundin <dln@eintr.org>
" Last Change: Mon Oct 17 13:18:58 CEST 2016

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "dln-light"

hi LineNr ctermfg=250 cterm=italic
hi CursorLine ctermfg=229 ctermbg=25 cterm=NONE
hi Visual ctermbg=220
hi Search ctermbg=226


hi Type ctermfg=5 cterm=NONE
" hi Comment ctermfg=243 cterm=italic
hi Comment ctermfg=1 cterm=italic
hi String ctermfg=2 cterm=italic
" hi Statement ctermfg=4 cterm=NONE
hi Statement ctermfg=17 cterm=bold
hi Constant ctermfg=6 cterm=NONE

" vim: sw=2
