
" sandwichのキーバインド(sa/sd/sdb/sr/srb)の安全対策
nmap s <Nop>
xmap s <Nop>

" sdf/sdFがオブジェクトのメソッド全体を削除するようにする
" console.log(1)のlog()だけ消えてconsole.1になるのが全部消えるようになる
let g:sandwich#magicchar#f#patterns = [
    \   {'header': '\<\%(\h\k*\.\)*\h\k*', 'bra': '(', 'ket': ')', 'footer': ''},
    \ ]
" 囲みとして認識されるパターンを増やす
autocmd FileType python call sandwich#util#addlocal([
    \   {'buns': ['"""', '"""'], 'nesting': 0, 'input': ['3"']},
    \   {'buns': ["'''", "'''"], 'nesting': 0, 'input': ['3"']},
    \ ])

nmenu       囲み(&S).追加：sa{motion/obj}{addition}<Tab>sa        sa
vmenu       囲み(&S).追加：sa{addition}<Tab>sa                    sa
vmenu       囲み(&S).削除：sd<Tab>sd                              sd
nmenu       囲み(&S).削除：sdb<Tab>sdb                            sdb
nmenu       囲み(&S).削除：sd{deletion}<Tab>sd                    sd
vmenu       囲み(&S).変更：sr{addition}<Tab>sr                    sr
nmenu       囲み(&S).変更：srb<Tab>srb                            srb
nmenu       囲み(&S).変更：sr{deletion}{addition}<Tab>sr          sr
anoremenu   囲み(&S).-0020-                                       <nop>
amenu       囲み(&S).囲みの中を無名レジスタで置換<Tab>siib        siib
amenu       囲み(&S).囲みの中をクリップボードで置換<Tab>"+siib    "+siib
anoremenu   囲み(&S).-0030-                                       <nop>
vmenu       囲み(&S).関数呼び出しを追加<Tab>saf                   saf
nmenu       囲み(&S).関数呼び出しを追加<Tab>saiwf                 saiwf
nmenu       囲み(&S).関数呼び出しを削除<Tab>sdf                   sdf
nmenu       囲み(&S).外側の関数呼び出しを削除<Tab>sdF             sdF
anoremenu   囲み(&S).-0050-                                       <nop>
vmenu       囲み(&S).タグ追加<Tab>sat                             sat
nmenu       囲み(&S).タグ変更<Tab>srtt                            srtt
nmenu       囲み(&S).タグ変更(属性削除)<Tab>srTT                  srTT
nmenu       囲み(&S).タグ削除<Tab>sdt                             sdt
anoremenu   囲み(&S).-0090-                                       <nop>
vmenu       囲み(&S).文字列を指定して囲む<Tab>sai                 sai
nmenu       囲み(&S).saiで使用した文字列で囲む<Tab>saI            saI
nmenu       囲み(&S).saiで作成した囲みの削除<Tab>sdI              sdI
anoremenu   囲み(&S).-0300-                                       <nop>
vmenu       囲み(&S).囲みの内側を選択<Tab>ib                      ib
vmenu       囲み(&S).囲みの外側を選択<Tab>ab                      ab
vmenu       囲み(&S).文字を指定して内側を選択<Tab>is              is
vmenu       囲み(&S).文字を指定して外側を選択<Tab>as              as
vmenu       囲み(&S).囲みの内側を選択(2回)<Tab>2ib                2ib
vmenu       囲み(&S).囲みの外側を選択(2回)<Tab>2ab                2ab
anoremenu   囲み(&S).-0330-                                       <nop>
vmenu       囲み(&S).選択範囲を広げる(sandwich)<Tab>ab            ab
vmenu       囲み(&S).選択範囲を広げる(vim-expand-region)<Tab>v    <Plug>(expand_region_expand)
vmenu       囲み(&S).選択範囲を狭める(vim-expand-region)<Tab>^v   <Plug>(expand_region_shrink)
anoremenu   囲み(&S).-0900-                                       <nop>
anoremenu   囲み(&S).sandwichのヘルプ                             :h   sandwich
anoremenu   囲み(&S).vim-expand-regionsのヘルプ                   :h   vim-expand-regions
anoremenu   囲み(&S).operator-replaceのヘルプ                     :h   operator-replace
