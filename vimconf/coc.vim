" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
" set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>



" カーソルを動かさなかった時にドキュメントを表示する
" autocmd CursorHold * silent call <SID>show_documentation()


imenu       COC(&C).入力補完<TAB>^@                         ^@

nmenu       COC(&C).coc-diagnostic-info<TAB>                <Plug>(coc-diagnostic-info)
nmenu       COC(&C).coc-diagnostic-prev<TAB>[g              <Plug>(coc-diagnostic-prev)
nmenu       COC(&C).coc-diagnostic-next<TAB>]g              <Plug>(coc-diagnostic-next)
nmenu       COC(&C).coc-diagnostic-error-prev<TAB>          <Plug>(coc-diagnostic-error-prev)
nmenu       COC(&C).coc-diagnostic-error-next<TAB>          <Plug>(coc-diagnostic-error-next)

nmenu       COC(&C).coc-definition<TAB>gd                   <Plug>(coc-definition)
nmenu       COC(&C).coc-declaration<TAB>                    <Plug>(coc-declaration)
nmenu       COC(&C).coc-type-definition<TAB>gD              <Plug>(coc-type-definition)
nmenu       COC(&C).coc-implementation<TAB>gi               <Plug>(coc-implementation)
nmenu       COC(&C).coc-references<TAB>gr                   <Plug>(coc-references)
nmenu       COC(&C).coc-references-used<TAB>                <Plug>(coc-references-used)
nnoremenu   COC(&C).ドキュメント表示<TAB>K                  <Cmd>call <SID>show_documentation()<CR>

nmenu       COC(&C).coc-rename<TAB><leader>rn               <Plug>(coc-rename)
nmenu       COC(&C).coc-command-repeat<TAB>                 <Plug>(coc-command-repeat)

xmenu       COC(&C).coc-format<TAB>                         <Plug>(coc-format)
xmenu       COC(&C).coc-format-selected<TAB><leader>f       <Plug>(coc-format-selected)
nmenu       COC(&C).coc-format-selected<TAB><leader>f       <Plug>(coc-format-selected)
xmenu       COC(&C).coc-codeaction-selected<TAB><leader>a   <Plug>(coc-codeaction-selected)
nmenu       COC(&C).coc-codeaction-selected<TAB><leader>a   <Plug>(coc-codeaction-selected)

nmenu       COC(&C).coc-codeaction<TAB><leader>ac           <Plug>(coc-codeaction)
nmenu       COC(&C).coc-fix-current<TAB><leader>qf          <Plug>(coc-fix-current)
nmenu       COC(&C).coc-refactor<TAB><leader>rf             <Plug>(coc-refactor)

nmenu       COC(&C).coc-codelens-action<TAB><leader>cl      <Plug>(coc-codelens-action)

xmenu       COC(&C).coc-funcobj-i<TAB>if                    <Plug>(coc-funcobj-i)
xmenu       COC(&C).coc-funcobj-a<TAB>af                    <Plug>(coc-funcobj-a)
xmenu       COC(&C).coc-classobj-i<TAB>ic                   <Plug>(coc-classobj-i)
xmenu       COC(&C).coc-classobj-a<TAB>ac                   <Plug>(coc-classobj-a)
nmenu       COC(&C).coc-range-select<TAB><C-s>              <Plug>(coc-range-select)
xmenu       COC(&C).coc-range-select<TAB><C-s>              <Plug>(coc-range-select)
nmenu       COC(&C).coc-range-select-backward<TAB>          <Plug>(coc-range-select-backward)
xmenu       COC(&C).coc-range-select-backward<TAB>          <Plug>(coc-range-select-backward)
nmenu       COC(&C).coc-open-link<TAB>                      <Plug>(coc-open-link)

nnoremenu COC(&C).CoCList\ diagnostics<TAB><space>a   :<C-u>CocList diagnostics<cr>
nnoremenu COC(&C).CocList\ extensions<TAB><space>e    :<C-u>CocList extensions<cr>
nnoremenu COC(&C).CocList\ commands<TAB><space>c      :<C-u>CocList commands<cr>
nnoremenu COC(&C).CocList\ outline<TAB><space>o       :<C-u>CocList outline<cr>
nnoremenu COC(&C).CocList\ -I\ symbols<TAB><space>s   :<C-u>CocList -I symbols<cr>
nnoremenu COC(&C).CocList\ CocNext<TAB><space>j       :<C-u>CocNext<CR>
nnoremenu COC(&C).CocList\ CocPrev<TAB><space>k       :<C-u>CocPrev<CR>
nnoremenu COC(&C).CocList\ CocListResume<TAB><space>p :<C-u>CocListResume<CR>


nmap <leader>rf <Plug>(coc-refactor)

let g:coc_data_home = expand('~/.local/share/coc')
let g:coc_config_home = expand('~/vimfiles')
let g:coc_global_extensions = [
      \'coc-tsserver', 
      \'coc-pyright',
      \'coc-lists',
      \'coc-json',
      \'coc-yaml',
      \'coc-tabnine'
\]


function! CocStatusDiagnostic() abort
    " 囲み文字(HackGen) ⊠⚠ⓘ 💡 ⊕⊖⊗⊘⊙⊝ ☑☒ ◐◑◒◓ ❯ 
    " ░▒▓
    " ▖▗▘▙▚▛▜▝▞▟
    " ambiwidth ⎇
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []
    if get(info, 'error', 0)
        call add(msgs, '⊠' . info['error'])
    endif
    if get(info, 'warning', 0)
        call add(msgs, '⚠' . info['warning'])
    endif
    return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '') . get(b:,'coc_current_function','')
endfunction
