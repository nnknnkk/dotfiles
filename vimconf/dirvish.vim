
let s:dirlog = expand('~/.dirvishlog')
" titlestringでカレントディレクトリを表示
" set titlestring=%{getcwd()}>\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set titlestring=%{getcwd()}>\ %t%(\ %m%r%y%a%)
" 相対パスを使う
let g:dirvish_relative_paths = 0
let g:dirvish_mode = ':sort ,^.*[\/],'
" dirvish Shdoの生成するバッチファイルのエンコードをcmd.exeに合わせる
" autocmd FileType dirvish set fenc=cp932
" cp932に変換できないファイル名を扱うためにPowerShellとutf8とbombを使う
" if has('win32')
"     set shell=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
"     set shellcmdflag=-c
"     set shellquote=\"
"     set shellxquote=
" endif
" set shellcmdflag=/c\ chcp\ 65001\ &&\ cmd\ /c
" function! ToggleDirvishRelativePathsThenReload()
"     let g:dirvish_relative_paths=!g:dirvish_relative_paths
"     " フォルダを上に並べる
"     if g:dirvish_relative_paths
"         let g:dirvish_mode = ':sort ,^\v(.*[\/])|\ze,'
"     else
"         let g:dirvish_mode = ':sort ,^.*[\/],'
"     endif
"     if (exists('b:dirvish')&&isdirectory(expand('%:p')))
"         execute ':Dirvish %'
"     endif
" endfunction
function! IsExistingDirectory(dir) abort
    return exists('b:dirvish') && isdirectory(a:dir)
endfunction
function! LCDThenRelativePath() abort
    " 改行区切りフルパスのファイルのリストを相対パスのリストに変換する
    " Dirvishで開いたディレクトリならlcdする
    let dir = expand('%:p')
    if(IsExistingDirectory(dir))
        lcd %:p
    endif
    " :enewしてsetf Dirvishしたバッファの場合
    if(dir==#'')
        let dir = fnamemodify(getcwd(), ':p')
    endif
    " 相対パスに置換する
    execute ':%snomagic;' .. escape(dir,'\\') .. ';;g'
    " 使わない機能をオフにする
    setlocal conceallevel=0
    " nunmap <buffer> /
    " nunmap <buffer> ?
endfunction
augroup dirvish_config
    autocmd!
    " Shdoで生成するバッチファイルでcp932に変換できないNTFのファイル名を扱う
    "   chcp 65001 した後のコンソールでは、バッチファイルはUTF-8 BOMあり・なし両方OK
    autocmd FileType dosbatch if(&fenc!=''?&fenc:&enc) == 'utf-8' | setlocal shellcmdflag=/c\ chcp\ 65001\ &&\ cmd\ \/c | endif
    "
    autocmd FileType dirvish silent! noremap <buffer> gr :call LCDThenRelativePath()<cr>
    " autocmd FileType dirvish silent! noremap <buffer> gr :call ToggleDirvishRelativePathsThenReload()<cr>
    autocmd FileType dirvish silent! lcd %
    autocmd BufNew   dirvish silent! lcd "<afile>"
    "
    autocmd FileType dirvish silent! unmap <buffer> P
    autocmd FileType dirvish silent! unmap <buffer> p
    autocmd FileType dirvish silent! unmap <buffer> i
    autocmd FileType dirvish silent! unmap <buffer> I
    autocmd FileType dirvish silent! unmap <buffer> o
    autocmd FileType dirvish silent! unmap <buffer> O
    autocmd FileType dirvish silent! unmap <buffer> a
    autocmd FileType dirvish silent! unmap <buffer> A
    autocmd FileType dirvish silent! unmap <buffer> x
    autocmd FileType dirvish silent! unmap <buffer> dax
    autocmd FileType dirvish silent! nunmap <buffer> /
    autocmd FileType dirvish silent! nunmap <buffer> ?
    "
    autocmd FileType dirvish silent! map <buffer><silent> T :<C-U>.call dirvish#open("tabedit",0)<CR>
    autocmd FileType dirvish silent! map <buffer><silent> <S-CR> :<C-U>.call dirvish#open("vsplit",0)<CR>
    autocmd FileType dirvish silent! map <buffer><silent><expr> <M-CR> ":!start " . (shellescape(fnamemodify(getline("."),":."))) . "<CR>"
    autocmd FileType dirvish silent! xnoremap <expr><buffer> X ":<C-u>!echo ".getline("v",".")->map({_idx, line->shellescape(fnamemodify(line, ":."))})->join(" ")."<Home><C-Right>"
    autocmd FileType dirvish silent! nnoremap <expr><buffer> X ":<C-u>!echo ".getline("1","$")->map({_idx, line->shellescape(fnamemodify(line, ":."))})->join(" ")."<Home><C-Right>"
    " autocmd FileType dirvish silent! command! -range=% -nargs=0 SortbyMtime <line1>,<line2>%!python -c"import sys,os;s=sys.stdin.read();pl=s.split('\n');pl=[p for p in pl if p];pl=sorted(pl,reverse=True,key=os.path.getmtime);sys.stdout.write('\n',join(pl))"
    autocmd FileType dirvish silent! command! -range=% -nargs=0 SortbyMtime <line1>,<line2>%!powershell.exe -Command 'write-output $input|foreach {get-item $_.trim()} |sort -desc lastwritetime|foreach{$_.name}'
    " 
    autocmd FileType dirvish if IsExistingDirectory(expand('%:p')) | call writefile([expand('%:p')], s:dirlog, 'a') | endif
augroup END

" fzfでカレントディレクトリまたは指定ディレクトリを検索してdirvishで開く
function! FZFdirvish(...) abort
	if a:0 >= 1 " a:0 引数の数 a:1 ...
		let dir = a:1
	else
		let dir = expand('%:h')
	endif
	let dir_content = system('dir /ad /b /s ' . dir)->iconv('cp932', &enc) 
	let dir_list = split(dir_content, '\n')
	call fzf#run({'dir':expand("%:h"), 'source': dir_list, 'sink': 'Dirvish', 'options': '--reverse --prompt "SelectDir: "' })
endfunction
command! -complete=dir -nargs=? FZFD call FZFdirvish(<f-args>)

" fzfで選択範囲をフィルタ
function! FZFBufFilter() range abort
	if a:firstline == a:lastline
		echo "範囲が必要です"
		return
	endif
	let first = a:firstline
	let last = a:lastline
	let buf_name = bufname()
	let lines = getline(a:firstline, a:lastline)
	let lines_utf8 = map(lines[:], {_idx, line-> line->iconv(&enc, 'utf8')})
	function! Sink(lst) abort closure
		let delete_result = deletebufline(buf_name, first, last)
		let lst = map(a:lst[:], {_idx, line-> line->iconv('utf8', &enc)})
		call appendbufline(buf_name, first -1, lst)
		return
	endfunction
	call fzf#run({'source': lines, 'sink*': funcref('Sink'), 'options': '--multi --bind=ctrl-a:toggle-all --reverse --prompt "Filter: "' })
endfunction
command! -range=% -nargs=0 FZFBufFilter <line1>,<line2>call FZFBufFilter()

" 選択範囲を引数化(無引数の場合は現在行)
function! XARGS(...) range abort
	function! ToTermEnc(str)
		if &termencoding == &enc
			return a:str
		endif
		return a:str->iconv(&enc, &termencoding)
	endfunction
	function! ToVimEnc(str)
		if &termencoding == &enc
			return a:str
		endif
		return a:str->iconv(&termencoding, &enc)
	endfunction
	let cmd = ''
	if a:0 >= 1 " a:0 引数の数
		let cmd .= join(a:000, ' ')
	else
		let cmd .= 'echo'
	endif
	let first = a:firstline
	let last = a:lastline
	let lines = getline(a:firstline, a:lastline)
	let lines_escaped = map(lines[:], {_idx, line-> shellescape(line)})
	let joined_lines = join(lines_escaped, " ")
	let commandline = cmd . ' ' . joined_lines
	echo commandline
	let result = system(commandline)
	echo ToVimEnc(result)
endfunction
command! -range -nargs=* -complete=shellcmd XARGS <line1>,<line2>call XARGS(<f-args>)

