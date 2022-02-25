" torte-cs.vim
"
" Modified torte.vim
 
set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "torte-cs"

" GUI
" GUI Comment : #80a0ff = Lightblue
" SpecialKey: TABと制御文字
" NonText: CRLF等非テキスト領域
hi SpecialKey   guifg=#222222   gui=none
hi NonText      guifg=#222222   gui=none
hi Normal       guifg=White     guibg=Black
hi clear Visual
hi Visual                                           gui=reverse
hi Cursor       guifg=Black     guibg=Green
hi Search                       guibg=#ff80ff       gui=underline
hi IncSearch                                        gui=reverse,underline
hi StatusLine   guifg=Black     guibg=Lightblue     gui=NONE
hi StatusLineNC guifg=Black     guibg=DarkGrey      gui=NONE
hi VertSplit    guifg=DarkGrey  guibg=Black
hi CursorIM     guifg=Black     guibg=Purple
hi LineNr       guifg=Yellow
hi MatchParen   guifg=Black     guibg=Red           gui=none

hi Pmenu                        guibg=#222222
hi PmenuSel     guifg=LightBlue guibg=#222222       gui=underline
hi PmenuSbar                    guibg=#222222
hi PmenuThumb                   guibg=LightBlue

hi Comment      guifg=#80a0ff
hi Constant     guifg=#ffa0a0
hi Special      guifg=Orange
hi Identifier   guifg=#40ffff
hi Statement    guifg=Yellow                        gui=NONE
hi PreProc      guifg=#ff80ff
hi Type                                             gui=NONE
hi Underlined   guifg=#80a0ff                       gui=underline

" 全角スペースを視覚化
hi ZenkakuSpace guifg=#222222 gui=underline
match ZenkakuSpace /　/

" DOS-Color Console
hi Normal       ctermfg=white   ctermbg=Black
hi Search       ctermfg=Black   ctermbg=Red     cterm=NONE
hi Visual       ctermfg=Black   ctermbg=Darkcyan
hi Cursor       ctermfg=Black   ctermbg=Green   cterm=bold
hi StatusLine   ctermfg=White   ctermbg=Darkred
hi StatusLineNC ctermfg=Black   ctermbg=Darkgrey
hi Special      ctermfg=Darkred
hi Comment      ctermfg=Darkcyan
hi Statement    ctermfg=Yellow                  cterm=NONE
hi Type                                         cterm=NONE


