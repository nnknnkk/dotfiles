" vim: set foldmethod=marker:
" ======= internal encoding ======= {{{
if has('windows') && !has('nvim') && !has('gui_running')
" windows gvim cmd.exe no-windows-terminal
	set encoding=cp932
else
	set encoding=utf-8
endif
scriptencoding utf-8
" set encodingはscriptencodingより早く宣言する
" scriptencodingはマルチバイト文字より早く宣言する
" ==========
" UTF-8対応
" source ~\vimfiles\kaoriya_encode_japan.vim
" source encode.vim
" SKK動作不良時は :call SkkDeleteRulesSelection() した状態で動くように
" if !has('kaoriya')
"     set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp
"     set fileformats=dos,unix,mac
" endif
" scriptencoding utf-8
" encode.vim設定後は明示的にscriptencodingを設定した方がよい

" ======= }}}

" ======= コンソール端末のカラースキーム ======= {{{
if !has('gui_running') && !exists('g:vscode')
    " colorscheme desert-cs
    " autocmd VimEnter * colorscheme codedark
    " autocmd VimEnter * set background=dark
    " autocmd VimEnter * colorscheme iceberg
    colorscheme iceberg
endif
" ======= }}}

" ======= 基本的なOption ======= {{{

set viminfo=
" set viminfo=c,h,'0,<0,f0
set viminfo=c,h,'0,<0,f0,n~/.cache/vim/viminfo
set nobackup
set directory=$TEMP,.
set undodir=$TEMP,.
set noundofile
" set directory=
" スワップファイルはもう不要かも

set cmdheight=2
set iminsert=0
set imsearch=0
set shortmess+=I
set iskeyword+=-

set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan
set nowrap

set belloff=all
set confirm
set hidden
set backspace=indent,eol,start

" 一部のCUIのターミナルで貼り付けを行いたい時に一時的に有効にするもの
" expandtabなどの設定を変えてしまうのでvimrcで設定するものではない
" set paste

set expandtab
set tabstop=4
set softtabstop=4
set smarttab
set shiftwidth=4
set shiftround

set autoindent
set smartindent
"set columns=100
"set lines=30
set scrolloff=5
set sessionoptions-=options,blank,help
set helplang=ja

"set ambiwidth=double
set display=lastline
set wildmode=list:longest,list:full
set completeopt=preview,menuone,noinsert
set complete=.,w,b,u,k,i,t

set lazyredraw

" 長い行を入力した時の自動改行禁止
" フォーマットは gq で可能
set formatoptions-=t
set formatoptions-=c

set splitright
set ruler
set laststatus=2


set showbreak=↪
set showtabline=2
" set tabline=

set nospell  " z= で修正候補一覧
set spelllang=en_us,cjk

" 不要なメニューの削除
if has('gui_running')
    autocmd VimEnter * aunmenu Syntax
endif

" markdownモードのコードブロックでハイライトする言語
let g:markdown_fenced_languages = ['javascript','python','json']
let g:markdown_enable_conceal = 0

" JavaScriptのカラースキーム
autocmd FileType javascript setf typescript

" 香り屋じゃない時用
if ! has('kaoriya')
    " syntax enable
    language ja
endif

" ======= }}}

" ======= QuickRun(不使用) ======= {{{
" カスタムキーマッピングから選択範囲を実行する場合はmode指定がいる
" nnoremap <silent> <Leader>r :QuickRun -mode n<CR>
" vnoremap <silent> <Leader>r :QuickRun -mode v<CR>
" 垂直分割にする、時間を計る
" let g:quickrun_config={'_': {'split': 'vertical','hook/time/enable':'1', 'hook/sweep': '1'}}
" set splitright " 新しいウィンドウを右に開く
" 水平分割にする
" let g:quickrun_config={'*': {'split': ''}}
" set splitbelow " 新しいウィンドウを下に開く
" let g:quickrun_config.python={'hook/output_encode': '0', 'hook/output_encode/encoding': 'cp932:utf-8'}
" ======= }}}

" ======= ステータスライン ======= {{{
"
set statusline=%<%f%*\ %M\ B:%n
set statusline+=\ %{SkkGetModeStr()}
set statusline+=%=
" if &enc =~ "^u"
"     set statusline+=\ u+%B
" else
"     set statusline+=\ 0x%B
" endif
if exists('g:coc_enabled')
    set statusline+=\ %{get(g:,'coc_git_status','')}
endif
set statusline+=\ %r%h%w%y\ %12(行%-04.4l\ 列%-03v%)\ %{(&fenc!=''?&fenc:&enc).((&bomb)?'^':'\ ').&ff}
if exists('g:coc_enabled')
    set statusline^=%#Search#%{CocStatusDiagnostic()}%*\ 
endif

" 以前使用していたステータスライン {{{

" SKK利用時(ALE)
" ~/.vimrc [+][RO] (VIM:cp932+unix) B:1  [SKK:あ] 0x82A0:あ  100:20 30%
" set statusline=%<%f\ %m%r%h%w\ (%Y:%{(&fenc!=''?&fenc:&enc).'+'.&ff})\ B:%n%=%{SkkGetModeStr()}\ 0x%B:%2{matchstr(getline('.'),'.',col('.')-1)}\ %8(%c%V%)\ %{LLAle()}

" SKK利用時
" ~/.vimrc [+][RO] (VIM:cp932+unix) B:1  [SKK:あ] 0x82A0:あ  100:20 30%
" set statusline=%<%f\ %m%r%h%w\ (%Y:%{(&fenc!=''?&fenc:&enc).'+'.&ff})\ B:%n%=%{SkkGetModeStr()}\ 0x%B:%2{matchstr(getline('.'),'.',col('.')-1)}\ %12(%l:%c%V%)%8P

" SKK利用時、BOM表示
" ~/.vimrc [+][RO] (VIM:utf-8^unix) B:1  [SKK:あ] 0x82A0:あ  100:20 30%
" set statusline=%<%f\ %m%r%h%w\ (%Y:%{(&fenc!=''?&fenc:&enc).((&bomb)?'^':'+').&ff})\ W:%{winnr()}%=%{SkkGetModeStr()}\ 0x%B:%2{matchstr(getline('.'),'.',col('.')-1)}\ %12(%l:%c%V%)%8P
" set statusline=%<%f\ %m%r%h%w\ (%Y:%{(&fenc!=''?&fenc:&enc).((&bomb)?'^':'+').&ff})\ W:%{winnr()}%=%{eskk#statusline()}\ 0x%B:%2{matchstr(getline('.'),'.',col('.')-1)}\ %12(%l:%c%V%)%8P

" ~/.vimrc [+][RO] (VIM:cp932+unix) B:1           0x82A0:あ  100:20 30%
" set statusline=%<%f\ %m%r%h%w\ (%Y:%{(&fenc!=''?&fenc:&enc).'+'.&ff})\ B:%n%=0x%B:%2{matchstr(getline('.'),'.',col('.')-1)}\ %12(%l:%c%V%)%8P

" ~/.vimrc [+][RO] (VIM:cp932+unix) B:1                      100:20 30%
" set statusline=%<%f\ %m%r%h%w\ (%Y:%{(&fenc!=''?&fenc:&enc).'+'.&ff})\ B:%n%=%l:%c%V%8P

" echo nr2char("0x82A0")
" echo nr2char( 0x82a0 )
" echo matchstr(strpart(getline(line(".")),col(".")\ -\ 1,2),'.')
" echo matchstr(getline(line('.')),'.',col('.')-1)
" echo matchstr(getline('.'),'.',col('.')-1)
" }}}

" ======= }}}

" ======= 基本的なキーマッピング ======= {{{
" keymap

" 自分用キーマップに使えそうなキー
" <Leader>キー デフォルトでは \
" <Enter>
" <Space>

" 方向キー
" m        マーク

" inoremap <backspace> <nop>

nnoremap <S-Right>  :bn<Return>
nnoremap <S-Left>   :bN<Return>
nnoremap <S-Down>   :BD<Return>

nnoremap <Right>    <C-W>w
nnoremap <Left>     <C-W>W
nnoremap <M-S-Down> <C-W>=
nnoremap <M-Up>    3<C-W>+
nnoremap <M-Down>  3<C-W>-
nnoremap <M-Right> 3<C-W>>
nnoremap <M-Left>  3<C-W><

nnoremap <M-HOME>   :simalt ~x<Return><C-W>=
nnoremap <M-S-HOME> :simalt ~x<Return>
nnoremap <M-END>    :simalt ~r<Return>
nnoremap <M-DEL>    :simalt ~n<Return>

nnoremap <F1> <ESC>
inoremap <F1> <ESC>

nnoremap k gk
vnoremap k gk
nnoremap j gj
vnoremap j gj
nnoremap ZZ <NOP>
nnoremap Q <NOP>
vnoremap Q <NOP>
onoremap Q <NOP>

inoremap <C-l> <Right>
" ウィンドウを閉じないbd
" command! BClose :bprevious<bar>split<bar>bnext<bar>bd
" command! BClose :enew<bar>bd#

" クリップボード
command! Put put +
nnoremap gy "+y
vnoremap gy "+y
augroup vimrc
	autocmd!
	autocmd VimEnter * nmap <S-ins> "*]p
	autocmd VimEnter * imap <S-ins> <C-r><C-o>*
augroup END
" nnoremap ga :silent !start <cfile><cr>
" ターミナル
tnoremap <F1> <C-\><C-n>
tnoremap <C-w><C-n> <C-w><S-n>
tnoremap <C-w>+ <C-w>"+
tnoremap <S-ins> <C-w>"+
" tnoremap <Esc> <C-\><C-n>
" nnoremap <F2> <ESC>i<C-R>=strftime("[%Y.%m.%d %a %H:%M]")<CR><ESC>
" nnoremap <F3> <ESC>i<C-R>=strftime("%H:%M")<CR><ESC>

" 補完をVSCode風にする(補完表示時のEnterで改行をしない等)
" set completeopt=menuone,noinsert との組合せ
inoremap <expr><TAB>   pumvisible() ? "\<C-y>"  : "\<TAB>"
inoremap <expr><CR>    pumvisible() ? "\<C-y>"  : "\<CR>"
inoremap <expr><C-n>   pumvisible() ? "\<Down>" : "\<C-n>"
inoremap <expr><C-p>   pumvisible() ? "\<Up>"   : "\<C-p>"

" ======= }}}

" ======= 非同期シンタックスチェッカ(ALE)(不使用) ======= {{{
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_insert_text = 1
" let g:ale_lint_on_text_changed = 0 " 'normal'
" let g:ale_lint_on_filetype_changed = 0
" let g:ale_lint_delay = 1000
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" let g:ale_list_window_size = 4
" let g:ale_completion_max_suggestions = 1 " 補完
" let g:ale_linters = {
" \   'python': ['mypy', 'pylint'],
" \ }
" let g:ale_change_sign_column_color = 1
" " highlight ALESignColumnWithoutErrors guibg=
" " highlight ALESignColumnWithErrors guigb=
" function! LLAle()
"     let l:count = ale#statusline#Count(bufnr(''))
"     let l:errors = l:count.error + l:count.style_error
"     let l:warnings = l:count.warning + l:count.style_warning
"     return l:count.total == 0 ? 'OK' : 'E:' . l:errors . ' W:' . l:warnings
" endfunction

" ======= }}}

" ======= 自動保存 ======= {{{

set updatetime=1000
let g:svbfre = '.\+' " ファイルパターン
function! AutoUpdate()
    if expand('%') =~ g:svbfre && !&readonly && &buftype == ''
        silent update
    endif
endfunction
autocmd CursorHold * call AutoUpdate()

" ======= }}}

" ======= 自作コマンド(ほぼ無効) ======= {{{
" " 編集中のファイルを実体ごと移動する
" function! MoveCurrentFile( dist )
"     echo "編集中ファイル " . expand("%") . " を移動します"
"     let error_msg    = ""
"     let current_path = expand("%:p")
"     let default      = expand("%:p:h") . "\\" . strftime("%Y-%m-%d.txt")
"     " 引数があればそれを使い、無ければ尋ねる
"     if strlen(a:dist) != 0
"         let dist_path = a:dist
"         echo "新しいファイル名: " . dist_path . "\n"
"     else
"         let dist_path = input( "新しいファイル名: ", default )
"         echo "\n"
"     endif
"     if !bufexists( dist_path )
"         let result = rename( current_path, dist_path )
"         if result == 0
"             silent exe "file " . dist_path
"             echo "移動に成功しました(" . expand("%:t") . ")\n"
"             return
"         else
"             let error_msg = "既に存在するファイル名です\n"
"         endif
"     else
"         let error_msg = "新しいファイル名のバッファが既に存在します\n"
"     endif
"     echo "ファイルを移動できません(" . dist_path . ")\n"
"     echo error_msg
" endfunction
" command! -nargs=? -complete=file MoveCurrentFile call MoveCurrentFile("<args>")


" ウィンドウを閉じないbd(簡易、引数ムシ)
" function! BD()
"     let target_buffer_no = bufnr("%")
"     silent exe "bnext"
"     silent exe "bd " . target_buffer_no
" endfunction
" command! BD call BD()

" バッファをファイルごと削除する
" function! BDRM()
"     let target_buffer_name = bufname("%")
"     let target_buffer_no   = bufnr("%")
"     let choice = confirm( target_buffer_name . " を削除してバッファを閉じますか？", "&Yes\n&No", 2 )
"     if choice == 1
"     else
"         echo target_buffer_name . "の削除をキャンセルしました"
"         return 0
"     end
"     echo target_buffer_name . "を削除します..."
"     let result = delete(target_buffer_name)
"     if result == 0
"         echo "削除に成功しました: " . target_buffer_name
"         silent exe "bnext"
"         silent exe "bd " . target_buffer_no
"     else
"         echo "削除に失敗しました(返り値:" . result . "): " . target_buffer_name
"     end
" endfunction
" command! BDRM call BDRM()

" 無名レジスタの各行の最初の数値の和を表示する
" 範囲を与えた場合は直近のVisualMode選択範囲を同様に処理する
" function! MySum() range
"     if a:firstline == a:lastline
"         let selected = @@
"     else
"         let tmp = @@      " 無名レジスタをtmpに入れる
"         silent normal gvy " 直前の選択範囲を再選択してyank
"         let selected = @@ " 無名レジスタをselectedに入れる
"         let @@ = tmp      " tmpを無名レジスタに入れる(復帰)
"     endif
"     let list = split( selected, '\n' )
"     " echo list
"     let result = 0
"     for cell in list
"         let num = matchstr( cell, '[0-9.]\+' )
"         " echo num
"         let result = result + str2float( num )
"     endfor
"     echo result
" endfunction
" command! -range MySum :<line1>,<line2>call MySum()

" au  GUIEnter * set transparency=255"
" let s:_transparency = &transparency"
" noremap <Space>t+ :set transparency+=10"
" noremap <Space>t- :set transparency-=10"
" autocmd GUIEnter * simalt ~x"
" winpos 1276 60
if has('kaoriya')
    function! CheatSheet()
        if &transparency != 255
            " set guioptions-=C
            execute 'set transparency=' . 255
            set laststatus=2
            set nonumber
            set list
            set nowrap
            set ruler
        else
            " set guioptions+=C
            set transparency=208
            set laststatus=0
            set nonumber norelativenumber nolist nowrap noruler
            set cmdheight=1 foldcolumn=2
            endif
    endfunction
    command! CheatSheet call CheatSheet()
endif

" ======= }}}

" ======= 便利な機能やコマンドのメモ ======= {{{
" Tips等
" ==========================================================
"
" redir @a-zA-Z*+   " message( :version )の出力をレジスタに書き込む
" redir END         " redir を終わらせる
"
" :diffsplit "file" " file との差分を表示
"
" :mks ファイル名   " 状態保存 mksession!
" :so ファイル名    " 状態復元 so Mksession.vim
"
" :%!sort           " 現在のバッファをコマンドでフィルタ
" :%w !sort         " 現在のバッファをコマンドに流し込む
"
" :bufdo {cmd}      " 各バッファに{cmd}を実行
" :windo {cmd}      " 各ウィンドウに{cmd}を実行
" :tabdo {cmd}      " 各タブに{cmd}を実行
"
" :ruby script
" :ruby << EOS      " ruby スクリプト実行
" ...script...
" EOS
" :%rubydo script   " 選択範囲の各行にワンライナー実行
" :rubyfile file    " = :ruby load 'file'
"
" テキストオブジェクト(visualモードでの範囲選択やmotionのかわりに使う)
"
" at                " tag block   タグの内外( <a> ... </a> )
" it                " tag block   タグの内側(     ...      )
" aw                " a word
" aW                " a WORD
" iw                " inner word  単語
" iW                " inner WORD  単語
" is                " sentence    文
" ip                " paragraph   段落
" i" i' i'          " 記号の中
" i{ i( i[ ib iB    " 括弧の中(blanket)
"
" テキストオブジェクトの囲い文字操作(surround.vim)
"   ※ <motion>はテキストオブジェクトでもよい
" ds'               " 囲い文字'を削除
" cs)]              " 囲い文字の括弧を()から[]へ
" ys<motion>        " <motion>の範囲を括る(プロンプト)
"   ※ プロンプトの abBr は対応する括弧に t< はタグモードに \l はTexモードに
" yss               " 行を括る       tや<でタグモード
" (visual)s         " 選択範囲を括る tや<でタグモード
" (visual)gS        " 選択範囲を改行付きで括る tや<でタグモード
" yS ySS (visual)S  " インデント付き
" ys<motion>(       " <motion>の範囲を()で括る(空白付き) ※)だと空白なし
" ys<motion>>       " <motion>の範囲を<>で括る
" ys<motion>a       " <motion>の範囲を<>で括る
" ys<motion><span   " <motion>の範囲を<span>タグで括る(属性もOK)
" ys<motion>tspan   " <motion>の範囲を<span>タグで括る(属性もOK)
"
"
" 折り畳み
" zi                " 折り畳みの有効・無効をトグルする
" zf<motion>        " 折り畳みを作る
" <visual>zf        " 折り畳みを作る
"
" zo                " カーソル位置の折り畳みを開く
" zO                " カーソル位置の折り畳みを再帰的に開く
" zr                " 折り畳みを開く
" zR                " すべての折り畳みを開く
"
" zc                " カーソル位置の折り畳みを閉じる
" zC                " カーソル位置の折り畳みを再帰的に閉じる
" zm                " 折り畳みを閉じる
" zM                " すべて折り畳みを閉じる
"
" za                " 折り畳みをトグルする
" zA                " 折り畳みを再帰的にトグルする
"
" zd                " カーソル位置の折り畳みを削除する
" zD                " カーソル位置の折り畳みを再帰的に削除する
" zE                " そのファイルの折り畳みをすべて削除する
"
"
" vimscriptを書く時、複数行の設定をコピペで変更する時に便利 usr_41.txt
" :@
" :@{reg}
"
"
" eregex.vim        " PerlやRubyの正規表現を利用する
" :M/pat/
" :S/pat/str/
" :G
" :V
"
" zoomwin.vim
" C-w C-o           " 最大画面化トグル
"
"
" タグの切れ目に改行を入れる
" :s:>\ze\zs<:\r:g

"
" 選択範囲を<span>で囲う
" vnoremap tg <Esc>:s:\%V.*\%V.:<span>\0<\/span>:<cr>:nohlsearch<cr>



" ======= }}}

" ======= Quick-Scope ======= {{{
let g:qs_lazy_highligh=1
function s:QuickScopeHighlight() abort
    augroup qs_colors
        autocmd!
        highlight QuickScopePrimary gui=underline,bold cterm=underline,bold
        highlight QuickScopeSecondary gui=undercurl,bold cterm=undercurl,bold
    augroup END
endfunction
autocmd ColorScheme * call s:QuickScopeHighlight()
" ======= }}}

" ======= vim-lsp asyncomplete(不使用) ======= {{{
" asyncomplete(tab補完) vim-lsp
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
" let g:asyncomplete_auto_popup = 1
" let g:asyncomplete_auto_completeopt = 1
" let g:asyncomplete_popup_delay = 30
" let g:lsp_diagnostics_enabled = 1
" let g:lsp_diagnostics_echo_cursor = 1
" let g:lsp_text_edit_enabled = 0
" let g:lsp_signs_enabled = 1
" let g:lsp_virtual_text_enabled = 1
" let g:lsp_highlight_references_enabled = 1
" let g:lsp_signs_error = {'text': '✗'} " 💢
" let g:lsp_signs_warning = {'text': '‼'} " ‼⚠
" let g:lsp_signs_information = {'text': 'i'} " i💬
" let g:lsp_signs_hint = {'text': '?'} " 🔰?
" " 💬🔰🗨🗯 ⊠⚠⊕⊖⊗⊘⊙⊚⊛⊜⊝⊞⊟☑☒
" function! s:on_lsp_buffer_enabled() abort
"     setlocal omnifunc=lsp#complete
"     setlocal signcolumn=yes
"     if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"     set foldmethod=expr
"       \ foldexpr=lsp#ui#vim#folding#foldexpr()
"       \ foldtext=lsp#ui#vim#folding#foldtext()
"     set wildmenu
"     " nmap <buffer> gd <plug>(lsp-definition)
"     " nmap <buffer> gr <plug>(lsp-references)
"     " nmap <buffer> gi <plug>(lsp-implementation)
"     " nmap <buffer> gt <plug>(lsp-type-definition)
"     " nmap <buffer> <leader>rn <plug>(lsp-rename)
"     " nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
"     " nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
"     " nmap <buffer> K <plug>(lsp-hover)
"     imap <c-space> <Plug>(asyncomplete_force_refresh)
"     nnoremap <silent> <f2> :LspRename<cr>
"     nnoremap <silent> gd   :LspDefinition<cr>
"     nnoremap <silent> gr   :LspReference<cr>
"     nnoremap <silent> gR   :LspImplementation<cr>
"     nnoremap <silent> [g   :LspPreviousDiagnostic<cr>
"     nnoremap <silent> ]g   :LspNextDiagnostic<cr>
"     nnoremap <silent> ga   :LspDocumentDiagnostics<cr>
"     nnoremap <silent> K    :LspHover<cr>
"     nnoremap <silent> gq   :LspDocumentFormat<cr>
"     anoremenu   LSP(&L).Rename<Tab>F2                :LspRename<cr>
"     anoremenu   LSP(&L).-0010- <nop>
"     anoremenu   LSP(&L).Definition<Tab>gd            :LspDefinition<cr>
"     anoremenu   LSP(&L).Reference<Tab>gr             :LspReference<cr>
"     anoremenu   LSP(&L).Implementation<Tab>gR        :LspImplementation<cr>
"     anoremenu   LSP(&L).-0020- <nop>
"     anoremenu   LSP(&L).PreviousDiagnostic<Tab>[g    :LspPreviousDiagnostic<cr>
"     anoremenu   LSP(&L).NextDiagnostic<Tab>]g        :LspNextDiagnostic<cr>
"     anoremenu   LSP(&L).DocumentDiagnostics<Tab>ga   :LspDocumentDiagnostics<cr>
"     anoremenu   LSP(&L).-0030- <nop>
"     anoremenu   LSP(&L).Hover<Tab>K                  :LspHover<cr>
"     anoremenu   LSP(&L).-0040- <nop>
"     anoremenu   LSP(&L).DocumentFormat<Tab>gq        :LspDocumentFormat<cr>
"     anoremenu   LSP(&L).-0050- <nop>
"     anoremenu   LSP(&L).CodeAction<Tab>              :LspCodeAction<cr>
"     anoremenu   LSP(&L).-0060- <nop>
"     anoremenu   LSP(&L).LspAddTreeCallHierarchyIncoming :LspAddTreeCallHierarchyIncoming<cr>
"     anoremenu   LSP(&L).LspCallHierarchyIncoming        :LspCallHierarchyIncoming<cr>
"     anoremenu   LSP(&L).LspCallHierarchyOutgoing        :LspCallHierarchyOutgoing<cr>
"     anoremenu   LSP(&L).LspCodeLens                     :LspCodeLens<cr>
"     anoremenu   LSP(&L).LspDocumentSymbol               :LspDocumentSymbol<cr>
"     anoremenu   LSP(&L).LspDocumentSymbolSearch         :LspDocumentSymbolSearch<cr>
"     anoremenu   LSP(&L).LspPeekDefinition               :LspPeekDefinition<cr>
"     anoremenu   LSP(&L).LspPeekImplementation           :LspPeekImplementation<cr>
"     anoremenu   LSP(&L).LspPeekTypeDefinition           :LspPeekTypeDefinition<cr>
"     anoremenu   LSP(&L).LspTypeDefinition               :LspTypeDefinition<cr>
"     anoremenu   LSP(&L).LspTypeHierarchy                :LspTypeHierarchy<cr>
"     anoremenu   LSP(&L).LspWorkspaceSymbol              :LspWorkspaceSymbol<cr>
"     anoremenu   LSP(&L).LspWorkspaceSymbolSearch        :LspWorkspaceSymbolSearch<cr>
"     anoremenu   LSP(&L).LspDocumentFold                 :LspDocumentFold<cr>
"     anoremenu   LSP(&L).LspDocumentFoldSync             :LspDocumentFoldSync<cr>
"     anoremenu   LSP(&L).LspDocumentFormat               :LspDocumentFormat<cr>
"     anoremenu   LSP(&L).LspDocumentFormatSync           :LspDocumentFormatSync<cr>
"     anoremenu   LSP(&L).LspDocumentRangeFormat          :LspDocumentRangeFormat<cr>
"     anoremenu   LSP(&L).LspDocumentRangeFormatSync      :LspDocumentRangeFormatSync<cr>
"     anoremenu   LSP(&L).LspSignatureHelp                :LspSignatureHelp<cr>
"     anoremenu   LSP(&L).LspSemanticScope                :LspSemanticScope<cr>
"     anoremenu   LSP(&L).LspStatus                       :LspStatus<cr>
"     anoremenu   LSP(&L).LspManageServers                :LspManageServers<cr>
"     " 定義ジャンプ(デフォルトのctagsによるジャンプを上書きしているのでこのあたりは好みが別れます)
"     " nnoremap <C-]> :<C-u>LspDefinition<CR>
"     " " 定義情報のホバー表示
"     " nnoremap K :<C-u>LspHover<CR>
"     " " 名前変更
"     " nnoremap <LocalLeader>R :<C-u>LspRename<CR>
"     " " 参照検索
"     " nnoremap <LocalLeader>n :<C-u>LspReferences<CR>
"     " " Lint結果をQuickFixで表示
"     " nnoremap <LocalLeader>f :<C-u>LspDocumentDiagnostics<CR>
"     " " テキスト整形
"     " nnoremap <LocalLeader>s :<C-u>LspDocumentFormat<CR>
" endfunction
" Leaderは未設定時<backslash> sも空いている
" <enter> <space>
" ======= }}}

" ======= プラグイン管理(vim-plug) ================= {{{
" 自動インストール
let s:vim_plug_path = expand('~/vimfiles/autoload/plug.vim')
if empty(glob(s:vim_plug_path))
    echo "vim-plugを配置します"
    silent execute '!curl -fLo '.s:vim_plug_path.' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.local/share/plugged')

" 日本語Help
Plug 'vim-jp/vimdoc-ja'

" SKK
Plug 'vim-skk/skk.vim', Cond(!exists('g:vscode'))
" Plug 'vim-skk/eskk.vim'
" Plug 'vim-denops/denops.vim'
" Plug 'vim-skk/denops-skkeleton.vim'


" colorscheme
Plug 'tomasiser/vim-code-dark'
Plug 'cocopon/iceberg.vim'


" surround
Plug 'tpope/vim-surround'
" Plug 'machakann/vim-sandwich'

" sneak
Plug 'justinmk/vim-sneak'

" filer(renamer)
Plug 'justinmk/vim-dirvish'

" ==============

" ウィンドウを閉じない:bdの代替コマンド
" :BDなど :bdと入れ替えるにはvim-altercmdが必要
" Plug 'qpkorr/vim-bufkill'
Plug 'mhinz/vim-sayonara'

" 複雑なアライン
Plug 'junegunn/vim-easy-align'
" いい感じの自動括弧
Plug 'cohama/lexima.vim'

" csv表示編集 rainbowも気になる
Plug 'chrisbra/csv.vim'

" SonicTemplate  Postfix Code Completion
" Plug 'mattn/sonictemplate-vim'

" 選択範囲の拡張 + -
Plug 'terryma/vim-expand-region'

" f/F/t/Tで動ける文字の強調
" Plug 'unblevable/quick-scope'

" messageをキャプチャする (例1):Capture scriptnames (例2):Capture !dir
Plug 'tyru/capture.vim'

" ファジーファインダー
" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'

Plug 'lifepillar/vim-zeef'


" ===============
" LSP
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
" Plug 'mattn/vim-lsp-icons'

" Plug 'neoclide/coc.nvim', Cond(!exists('g:vscode'), {'branch': 'release'})
" " Plug 'neoclide/coc.nvim', {'branch': 'release', 'on': []}
" " 'for': ['python', 'javascript', 'typescript', 'json', 'yaml', 'html'],

" 非同期補完
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'

" モーション
Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))
Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })
Plug 'tpope/vim-repeat'
" Plug 'hrsh7th/vim-searchx'
" Plug 'justinmk/vim-sneak'

" テキストオブジェクトに対する置換
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'

" ケース変換
" Plug 'tyru/operator-camelize.vim'
Plug 'arthurxavierx/vim-caser'

" マルチカーソル
Plug 'mg979/vim-visual-multi'

" Google翻訳
Plug 'skanehira/translate.vim'

" 置換プレビュー
Plug 'markonm/traces.vim'

" ターミナルにコードを送信する
Plug 'jpalardy/vim-slime'

call plug#end()

" 遅延読み込み {{{
" augroup load_us_hold
"     autocmd!
"     autocmd CursorHold * call plug#load(
"                 \ 'vim-easymotion',
"                 \ )| autocmd! load_us_hold
" augroup END
" }}}

" 分割した設定ファイル
let s:config_dir = expand('~/dotfiles/vimconf/')
if !exists('g:vscode') && exists('g:coc_enabled')
    execute 'source '.s:config_dir.'coc.vim'
endif

" ======= }}}

" ======= skk.vim(外部設定) ======= {{{
" skk.vim の設定を読み込む
" InsertMode 時 <CTRL-J> で起動
execute 'source '.s:config_dir.'skkvim.vim'
" source ~/.eskkvim
" source ~/.skkeletonvim
if exists('g:vscode')
    set imdisable
endif
" ======= }}}

" ======= fzf(不使用) ========== {{{
" let $FZF_DEFAULT_OPTS = '--reverse --bind=alt-a:toggle-all --bind=change:clear-screen'
" let g:fzf_layout = {'down': '60%'}
" let g:fzf_action = {'ctrl-t': 'tab split', 'ctrl-x': 'split', 'ctrl-v': 'vsplit' }
" ======= }}}

" ======= dirvish ================= {{{
execute 'source '.s:config_dir.'dirvish.vim'
" ======= }}}

" ======= 囲み関係 expand-region operator-replace ====== {{{
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" map si <Plug>(operator-replace)
map gr <Plug>(operator-replace)

" ======= }}}

" ======= Misc EasyMotion vim-visual-multi ======= {{{

" EasyMotion {{{
let g:EasyMotion_do_mapping = 0
" let g:EasyMotion_use_migemo = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
" let g:EasyMotion_prompt = '{n} 貼付(^v) 補完(^l/^r^w/^r^a/^r^f) 下向(tab) 展開(^z) 戻る(^o): '
autocmd User EasyMotionPromptBegin silent! CocDisable
autocmd User EasyMotionPromptEnd   silent! CocEnable
autocmd VimEnter * EMCommandLineNoreMap ; <CR>
autocmd VimEnter * EMCommandLineNoreMap <Space> <CR>
function s:EasyMotionHighligh() abort
    highlight EasyMotionTarget gui=bold
    if &background=='light'
        highlight EasyMotionTarget guifg=#cc517a
    endif
endfunction
autocmd colorscheme * call s:EasyMotionHighligh()
" nmap s/ <Plug>(easymotion-sn)
" xmap s/ <Plug>(easymotion-sn)
" omap s/ <Plug>(easymotion-tn)
" nmap ss <Plug>(easymotion-overwin-f2)
" xmap ss <Plug>(easymotion-overwin-f2)
" omap ss <Plug>(easymotion-overwin-f2)
" nmap S  <Plug>(easymotion-overwin-f)
" xmap S  <Plug>(easymotion-overwin-f)
" omap S  <Plug>(easymotion-overwin-f)
nmap <c-k> <Plug>(easymotion-overwin-f2)
xmap <c-k> <Plug>(easymotion-overwin-f2)
omap <c-k> <Plug>(easymotion-overwin-f2)
" bd=Bidirectional w=wordの先頭 e=wordの末尾
" 検索系f2/sn/tn
" <C-;>はvimでは使用できない
" map    <Leader>w   <Plug>(easymotion-bd-w)
" nmap   <Leader>w   <Plug>(easymotion-overwin-w)
" map    <Leader>l   <Plug>(easymotion-bd-jk)
" nmap   <Leader>l   <Plug>(easymotion-overwin-line)
" map    <Leader>F   <Plug>(easymotion-bd-f)
" nmap   <Leader>F   <Plug>(easymotion-overwin-f)
" map    <Leader>f   <Plug>(easymotion-bd-f2)
" nmap   <Leader>f   <Plug>(easymotion-overwin-f2)
" map    <Leader>s   <Plug>(easymotion-sn)
" map    <Leader>t   <Plug>(easymotion-tn)
" map    <Leader>n   <Plug>(easymotion-next)
" map    <Leader>N   <Plug>(easymotion-prev)
" map    <Leader>r   <Plug>(easymotion-repeat)
amenu   Misc(&M).画面内を2打+ラベルで移動<TAB>^k             <Plug>(easymotion-overwin-f2)
amenu   Misc(&M).画面内の行にラベルで移動<TAB>               <Plug>(easymotion-overwin-line)
amenu   Misc(&M).画面内を検索してラベルで移動<TAB>           <Plug>(easymotion-sn)
amenu   Misc(&M).easymotion.easymotion-overwin-w<TAB>        <Plug>(easymotion-overwin-w)
amenu   Misc(&M).easymotion.easymotion-overwin-line<TAB>     <Plug>(easymotion-overwin-line)
amenu   Misc(&M).easymotion.easymotion-overwin-f<TAB>        <Plug>(easymotion-overwin-f)
amenu   Misc(&M).easymotion.easymotion-overwin-f2<TAB>       <Plug>(easymotion-overwin-f2)
amenu   Misc(&M).easymotion.easymotion-s<TAB>                <Plug>(easymotion-s)
amenu   Misc(&M).easymotion.easymotion-s2<TAB>               <Plug>(easymotion-s2)
amenu   Misc(&M).easymotion.easymotion-sn<TAB>               <Plug>(easymotion-sn)
amenu   Misc(&M).easymotion.easymotion-t<TAB>                <Plug>(easymotion-t)
amenu   Misc(&M).easymotion.easymotion-t2<TAB>               <Plug>(easymotion-t2)
amenu   Misc(&M).easymotion.easymotion-tn<TAB>               <Plug>(easymotion-tn)
nmenu   Misc(&M).easymotion.easymotion-next<TAB>             <Plug>(easymotion-next)
nmenu   Misc(&M).easymotion.easymotion-prev<TAB>             <Plug>(easymotion-prev)
nmenu   Misc(&M).easymotion.easymotion-repeat<TAB>           <Plug>(easymotion-repeat)
nmenu   Misc(&M).easymotion.easymotion-n<TAB>                <Plug>(easymotion-n)
nmenu   Misc(&M).easymotion.easymotion-N<TAB>                <Plug>(easymotion-N)
nmenu   Misc(&M).easymotion.easymotion-vim-n<TAB>            <Plug>(easymotion-vim-n)
nmenu   Misc(&M).easymotion.easymotion-vim-N<TAB>            <Plug>(easymotion-vim-N)
amenu   Misc(&M).easymotion.easymotion-lineforward<TAB>      <Plug>(easymotion-lineforward)
amenu   Misc(&M).easymotion.easymotion-linebackward<TAB>     <Plug>(easymotion-linebackward)
amenu   Misc(&M).easymotion.easymotion-j<TAB>                <Plug>(easymotion-j)
amenu   Misc(&M).easymotion.easymotion-k<TAB>                <Plug>(easymotion-k)
amenu   Misc(&M).easymotion.easymotion-iskeyword-bd-w<TAB>   <Plug>(easymotion-iskeyword-bd-w)
amenu   Misc(&M).easymotion.easymotion-iskeyword-bd-e<TAB>   <Plug>(easymotion-iskeyword-bd-e)
amenu   Misc(&M).easymotion.easymotion-jumptoanywhere<TAB>   <Plug>(easymotion-jumptoanywhere)
" }}}

" vim-visual-multi {{{
amenu   Misc(&M).カーソル位置の単語でマルチカーソル<TAB>^n ^n
amenu   Misc(&M).上にカーソルを追加<TAB>^↑ <nop>
amenu   Misc(&M).下にカーソルを追加<TAB>^↓ <nop>
" let g:VM_user_operators = ['sa', 'sd', {'sr': 2}, 'si']
" TAB   マルチカーソルとマルチカーソルヴィジュアルをトグル
" n  N  次・前のハイライトを選択
" q     現在のハイライトをスキップして次を選択
" Q     現在のハイライト、カーソルを削除
" [  ]  次・前のカーソルを選択
" \\a   ビジュアル選択をマルチカーソルビジュアルに変換
" s<op> テキストオブジェクトを選択
" .     直前の編集動作を繰り返す
" \\@   マクロを適用する
" \\z   :normal
" \\x   ex
" }}}

" operator-camelize {{{
" map scc <Plug>(operator-camelize-toggle)
" let g:caser_prefix = 'sc'
" amenu   Misc(&M).キャメルケース<TAB>scc  scc
" amenu   Misc(&M).スネークケース<TAB>sc_  sc_
" amenu   Misc(&M).パスカルケース<TAB>scp  scp
" amenu   Misc(&M).ケバブケース<TAB>sck    sck
" }}}

" vim-slime {{{
if has('nvim')
    let g:slime_target = "neovim"
else
    let g:slime_target = "vimterminal"
endif
let g:slime_python_ipython = 1
" ipythonでのペーストがうまくいかない
"  ~\.local\share\plugged\vim-slime\ftplugin\python\slime.vim
"   return ["%cpaste -q", "\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
"   return [substitute(dedented_lines, add_eol_pat, "", "g"), "\n"]
" ^c^cipythonで起動した場合、初回のペーストは失敗する
amenu   Misc(&M).ターミナルに送信<TAB>^c^c  ^c^c
" }}}

" vim-sayonara {{{
let g:sayonara_confirm_quit = 1
command! BD Sayonara!
" }}}

" <C-@> で :terminal もしくは Terminal ウィンドウにジャンプ {{{
if has('terminal')
    nnoremap <silent><expr> <C-@> <SID>switch_to_terminal(get(term_list(), 0, v:null))
    tnoremap <silent><expr> <C-@> <SID>switch_to_window()
    function! s:switch_to_terminal(nr) abort
        return a:nr == v:null || term_getstatus(a:nr) =~# 'finished'
                    \ ? ":\<C-u>terminal\<CR>"
                    \ : bufwinnr(a:nr) . "\<C-w>w"
    endfunction
    function! s:switch_to_window() abort
        return (empty(&termwinkey) ? "\<C-w>" : &termwinkey) . "\<C-w>"
    endfunction
endif
" }}}  

" Popup Windowの翻訳 {{{
function! s:GetPopUpText() abort
    " call popup_create('foobar1', {})
    " call popup_create('foobar2', {})
    let id_list = popup_list()
    let text_list = id_list->map({_i,id->id->winbufnr()->getbufline(1,"$")})
    if len(text_list) == 0
        return ""
    endif
    let text = text_list->flatten->join("\n")
    return text
endfunction
function! s:Ptranslate() abort
    let text = GetPopUpText()
    if text == ""
        return
    endif
    exec ":Translate " . text
endfunction
command! -nargs=0 Ptranslate call s:Ptranslate()
" nmap \tt <Plug>(Translate)
vmap \tt <Plug>(VTranslate)
nmap \tp :<C-u>Ptranslate<CR>
nnoremap \y  :call <SID>GetPopUpText()->setreg("")
" }}}

" 行末スペース、行末タブの表示 {{{
highlight TrailingSpaces gui=undercurl guisp=red
match TrailingSpaces /\s\{-1,}$/
" au BufNew,BufRead * call matchadd('TrailingSpaces', '\s\{-1,}$')
" }}}

" 不要なプラグインを読み込まない {{{
let g:did_install_default_menus = 1
let g:did_install_syntax_menu   = 1
let g:did_indent_on             = 1
let g:did_load_filetypes        = 1
let g:did_load_ftplugin         = 1
let g:loaded_2html_plugin       = 1
let g:loaded_gzip               = 1
let g:loaded_man                = 1
let g:loaded_matchit            = 1
let g:loaded_matchparen         = 1
let g:loaded_netrwPlugin        = 1
let g:loaded_remote_plugins     = 1
let g:loaded_shada_plugin       = 1
let g:loaded_spellfile_plugin   = 1
let g:loaded_tarPlugin          = 1
let g:loaded_tutor_mode_plugin  = 1
let g:loaded_zipPlugin          = 1
let g:skip_loading_mswin        = 1
let g:did_install_default_menus = 1
let g:did_install_syntax_menu   = 1
let g:did_indent_on             = 1
let g:did_load_filetypes        = 1
let g:did_load_ftplugin         = 1
let g:loaded_2html_plugin       = 1
let g:loaded_gzip               = 1
let g:loaded_man                = 1
let g:loaded_matchit            = 1
let g:loaded_matchparen         = 1
let g:loaded_netrwPlugin        = 1
let g:loaded_remote_plugins     = 1
let g:loaded_shada_plugin       = 1
let g:loaded_spellfile_plugin   = 1
let g:loaded_tarPlugin          = 1
let g:loaded_tutor_mode_plugin  = 1
let g:loaded_zipPlugin          = 1
" 香り屋
let g:skip_loading_mswin        = 1
let g:plugin_autodate_disable   = 1
let g:plugin_cmdex_disable      = 1
let g:plugin_dicwin_disable     = 1
" let g:plugin_hz_ja_disable    = 0 " 変数名が存在すると無効
let g:plugin_scrnmode_disable   = 1
let g:plugin_verifyenc_disable  = 1

" }}}

" ======= }}}


