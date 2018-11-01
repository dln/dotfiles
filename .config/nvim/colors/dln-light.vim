hi clear
if version > 580
    if exists("syntax_on")
        syntax reset
    endif
endif

let colors_name="dln-light"

if has("gui_running")
    set background=light
endif

hi Normal       guifg=#000000 guibg=#ffffff gui=NONE 
hi DiffAdd      guifg=#003300 guibg=#DDFFDD gui=NONE 
hi DiffChange   guibg=#ECECEC gui=NONE 
hi DiffText     guifg=#000033 guibg=#DDDDFF gui=NONE 
hi DiffDelete   guifg=#DDCCCC guibg=#FFDDDD gui=NONE 
hi Folded       guifg=#808080 guibg=#ECECEC gui=NONE 
hi LineNr       guifg=#d0d0d0 guibg=#fcfcfc gui=none 
hi NonText      guifg=#808080 guibg=#fcfcfc gui=none
hi VertSplit    guifg=#BBBBBB guibg=#BBBBBB gui=NONE 
hi SignColumn   guifg=#404040 guibg=#fcfcfc gui=none
hi StatusLine   guifg=#404040 guibg=#BBBBBB gui=BOLD 
hi StatusLineNC guifg=#BBBBBB guibg=#ECECEC gui=ITALIC 
hi ModeMsg      guifg=#990000 gui=NONE 
hi MoreMsg      guifg=#990000 gui=NONE 
hi Title        guifg=#EF5939 gui=NONE 
hi WarningMsg   guifg=#EF5939 gui=NONE 
hi SpecialKey   guifg=#FFFFFF guibg=#FF1100 gui=ITALIC 
hi MatchParen   guifg=#000000 guibg=#CDCDFD gui=NONE 
hi Underlined   guifg=#000000 gui=UNDERLINE 
hi Directory    guifg=#990000 gui=NONE 
hi Visual       guifg=#FFFFFF guibg=#3465A4 gui=NONE 
hi VisualNOS    guifg=#FFFFFF guibg=#204A87 gui=NONE 
hi IncSearch    guifg=#000000 guibg=#FFF9C4 gui=none 
hi Search       guifg=#000000 guibg=#FFF9C4 gui=none
hi Ignore       guifg=#808080 gui=NONE 
hi Identifier   guifg=#0086B3 gui=NONE 
hi PreProc      guifg=#A0A0A0 gui=BOLD 
hi Comment      guifg=#607D8B gui=ITALIC 
hi Operator     guifg=#8E24AA gui=bold 
hi Constant     guifg=#177F80 gui=NONE 
hi String       guifg=#388E3C gui=italic
hi Function     guifg=#990000 gui=BOLD 
hi Statement    guifg=#000000 gui=BOLD 
hi Type         guifg=#445588 gui=BOLD 
hi Number       guifg=#1C9898 gui=NONE 
hi Todo         guifg=#f44336 guibg=#FFF3E0 gui=none
hi Special      guifg=#9E9D24 guibg=#ffffff gui=bold
hi rubySymbol   guifg=#960B73 gui=NONE 
hi Error        guifg=#F8F8FF guibg=#FF1100 gui=NONE 
hi Label        guifg=#000000 gui=BOLD 
hi StorageClass guifg=#000000 gui=BOLD 
hi Structure    guifg=#000000 gui=BOLD 
hi TypeDef      guifg=#000000 gui=BOLD 
hi WildMenu     guifg=#7FBDFF guibg=#425C78 gui=NONE 
hi Pmenu        guifg=#FFFFFF guibg=#808080 gui=BOLD 
hi PmenuSel     guifg=#000000 guibg=#CDCDFD gui=ITALIC 
hi PmenuSbar    guifg=#444444 guibg=#000000 gui=NONE 
hi PmenuThumb   guifg=#AAAAAA guibg=#AAAAAA gui=NONE 
hi TabLine      guifg=#404040 guibg=#DDDDDD gui=NONE 
hi TabLineFill  guifg=#404040 guibg=#DDDDDD gui=NONE 
hi TabLineSel   guifg=#404040 gui=BOLD 
hi cucumberTags guifg=#333333 guibg=#FFFF66 gui=BOLD 
hi htmlTagN     gui=BOLD 
hi Cursor       guifg=#F8F8FF guibg=#444454 gui=NONE 
hi CursorLine   guibg=#D8D8DD gui=NONE 
hi CursorColumn guibg=#D8D8DD gui=NONE 
hi goFunctionCall guifg=#512DA8 gui=NONE 
hi Bookmark   guifg=#EDE7F6 guibg=#9575CD gui=italic

hi link rubyStringDelimiter String
