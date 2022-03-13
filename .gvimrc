scriptencoding utf-8

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
set signcolumn=yes
set guioptions=cmgt!
set foldcolumn=1

" colorscheme codedark
" colorscheme torte-cs
colorscheme iceberg
set background=light

" 現在のタブに下線を引く
highlight TabLineSel gui=underline

