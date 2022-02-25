scriptencoding utf-8
" gvimrc
" set columns=100
" set lines=30
" colorscheme torte-cs

" set guifont=Andale_Mono:h9:cSHIFTJIS
" set guifont=ＤＦパブリW5D:h12:cSHIFTJIS
" set guifont=BDF_Ticago95_M+:h9:cSHIFTJIS
" set guifont=BDF_M+:h7.5:cSHIFTJIS
" set guifont=BDF_UM+:h9:cSHIFTJIS
" set guifont=Migu_1M:h10.5:cSHIFTJIS
" set guifont=BDF_UM+_OUTLINE:h9.5:cDEFAULT " a+u0301合字を表示できる
" set guifont=Consolas:h10:w4.5:cSHIFTJIS
" set guifont=MeiryoKe_Console:h10:w4.5:cSHIFTJIS
" set guifont=源真ゴシック等幅_Regular:h12:cSHIFTJIS
" set linespace=0
" set guifont=MeiryoKe_Console:h12:cSHIFTJIS
" set linespace=3 guifont=NasuM:h11:cDEFAULT:qCLEARTYPE
if has('nvim')
	autocmd GUIEnter * silent GuiFont HackGen:h11
	GuiTabline 0
	GuiPopupmenu 1
	GuiLinespace 2
	GuiScrollBar 1
else
	set linespace=4 guifont=HackGen:h11:cDEFAULT:qCLEARTYPE
	set renderoptions=type:directx,renmode:5 ",gamma:1.2,geom:0,renmode:4,taamode:1
endif
set listchars=eol:/,tab::.
set list
set number
" set number relativenumber
set signcolumn=yes
set guioptions=cmgt!
set foldcolumn=1
" set cmdheight=2 foldcolumn=2

" au GUIEnter * simalt ~x
" au GUIEnter * set notitle

" カラースキーム
" ==========================================================
" if expand("$USERDOMAIN")=="DISTAL"
"     " colorscheme desert-cs
"     colorscheme codedark
"     set linespace=4 guifont=MeiryoKe_Console:h12:cSHIFTJIS
" elseif has('win32')
"     " colorscheme torte-cs
"     " colorscheme desert-cs
"     colorscheme codedark
" endif
colorscheme codedark

" 現在のタブに下線を引く
highlight TabLineSel gui=underline
" SKKの変換時に色と下線を付ける
" highlight default skk_henkan ctermbg=1 ctermfg=15 guifg=#80a0ff gui=underline
" highlight default skk_henkan ctermbg=1 ctermfg=15 gui=underline
" let g:skk_use_face = 1

