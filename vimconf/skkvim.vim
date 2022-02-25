scriptencoding utf-8
" vim: set ft=vim : 

" SKK利用時、BOM表示
" ~/.vimrc [+][RO] (VIM:utf-8^unix) B:1  [SKK:あ] 0x82A0:あ  100:20 30%
" set statusline=%<%f\ %m%r%h%w\ (%Y:%{(&fenc!=''?&fenc:&enc).((&bomb)?'^':'+').&ff})\ W:%{winnr()}%=%{SkkGetModeStr()}\ 0x%B:%2{matchstr(getline('.'),'.',col('.')-1)}\ %12(%l:%c%V%)%8P

" ローマ字規則のコンパイルと削除(変更時要削除→コンパイル)
" :call SkkAddRulesSection()
" :call SkkDeleteRulesSection()

" ctrl-j SKKの切り替え(挿入langモード)
"
"   
" 辞書登録モードで登録せずに抜ける方法
" ▼こうう 降雨/項羽/(辞書登録)
" Enter  戻る(xで前候補)
" ESC    戻る(xで前候補)
" ctrl-g ENTER(改行されるがxで前候補)
" ctrl-g ESC(戻るがnormalモードになる、aで挿入モードにしてxで前候補)
" 見出し語入力モードに戻ろうとしてctrl-gを押すと不思議なことになる
"   
" 
" 確定入力モード(■モード)
"   ローマ字でかなを入力できるモード
"   かなモード以外にカナ、全英モードがあるが使わない
"   ※数詞や漢数字への変換はQで始める
"   q1gatu 一月
"   q2hon 2本
"   q1234567890 十二億三千四百五十六万七千八百九十
"   q1234567890 壱拾弐億参阡四百伍拾六萬七阡八百九拾
"   'q1ぴん'に'#2筒'を辞書登録すると一筒と変換できる
"   #のあとの数値は数字の変換方法 #0 #1 #2 
" 
"   /      abbrevモード
"   ※abbrevモードは数詞や記号の変換に使える
"   '/34kin'と入力すると'３四金'
"   一筒
"   
" 
" 
" 
" 見出し語入力モード(▽モード) ※文字幅の都合で▲を設定
"   Tab    補完入力
"   .      補完候補の次候補
"   ,      補完候補の前候補
"   ctrl-g 入力した見出し語の消去
"   space  変換する
"   q      カナで確定する
"   ENTER  確定する
"   ctrl-j 確定する
"   ESC    確定する
"   
" 入力した見出し語を辞書変換するモード(▼モード)
"   ESC    ▽モードに戻る
"   space  次候補
"   x      前候補
"   X      辞書から削除
"   asdfjkl 選択方式の時の選択
"   ENTER  確定する
"   ctrl-j 確定する
"   ctrl-q abbrevモードのときに全英で確定する
"   <>?    接頭辞・接尾辞入力(どれも効果は同じ)
"   ※辞書の接頭辞・接尾辞エントリを利用するので候補が絞られる
"   豊田市 を入力するのに 豊田>市
"   超大型 を入力するのに 超>大型
" 
" (再帰的)単語登録モード
"   何も入力せずにEnterで戻る
"   ESC    戻る
"   ctrl-g なにも起きない
"   ※▼モード、単語登録モードでのESC/ctrl-gの動作は(自分には)あいまい
"   


" set imdisable

" 辞書設定
let g:skk_jisyo_encoding       = "utf-8"
let g:skk_jisyo                = "~/.local/share/skk/skkudic"
let g:skk_large_jisyo_encoding = "utf-8"
let g:skk_large_jisyo          = "~/.local/share/skk/SKK-JISYO.L"
" let g:skk_jisyo                = "~/skk/skkudic"
" let g:skk_large_jisyo          = "~/skk/SKK-JISYO.L"

" ユーザー辞書をvim終了時に自動保存する(0=プロンプト)
let g:skk_auto_save_jisyo = 1

" 変換時に色をつける
" hi skk_henkan  guifg=Black guibg=White gui=reverse
" let g:skk_use_face = 1

" 候補選択時に註釈を表示する (インラインでは未対応)
let g:skk_show_annotation = 0

" <CR>確定時に改行文字を出力しない
let g:skk_egg_like_newline = 1

" Insert モードを抜けて再び Insert モードにしたときに前の状態を維持
let g:skk_keep_state = 0

" ローマ字規則
let g:skk_user_rom_kana_rules = ""
 	\. "z 	　\<NL>"
	\. "zh	←\<NL>"
	\. "zj	↓\<NL>"
	\. "zk	↑\<NL>"
	\. "zl	→\<NL>"
	\. "z,	＜\<NL>"
	\. "z.	＞\<NL>"
	\. "z-	-\<NL>"
	\. "z/	・\<NL>"
	\. "z[	『\<NL>"
	\. "z]	』\<NL>"
	\. "-	ー\<NL>"
	\. "z:	:\<NL>"
	\. "z;	;\<NL>"
	\. "!	！\<NL>"
	\. "?	？\<NL>"
	\. "[	「\<NL>"
	\. "]	」\<NL>"

" 	.	SkkCurrentKuten(kana)\<NL>
" 	,	SkkCurrentTouten(kana)\<NL>
" 	l	SkkAsciiMode(kana)\<NL>
" 	L	SkkZeneiMode(kana)\<NL>
" 	q	SkkToggleKana(kana)\<NL>
" 	Q	SkkSetHenkanPoint1(kana)\<NL>
" 	/	SkkAbbrevMode(kana)\<NL>


let g:skk_show_candidates_count = 3
let g:skk_sticky_key = ";"

let g:skk_marker_white = "▲"
" ▲▼§√†‡□■♪→←↑↓

" highlight / g:skk_use_face は colorscheme の後に設定する必要がある
autocmd VimEnter * highlight default skk_henkan ctermbg=1 ctermfg=15 gui=underline
autocmd VimEnter * let g:skk_use_face = 1

let g:skk_use_color_cursor = 1
let g:skk_cursor_hira_color = '#80a0ff'
" let g:skk_cursor_kata_color
" let g:skk_cursor_zenei_color
" let g:skk_cursor_ascii_color
" let g:skk_cursor_abbrev_color



