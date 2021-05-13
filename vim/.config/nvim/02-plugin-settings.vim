"  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
"  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
"  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
"  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
"  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
"                VIM PLUGIN SETTINGS
"───────────────────────────────────────────────────────────────  misc  ──────"

" fzf integration
set rtp+=~/.config/fzf

" nord theme
colorscheme nord
set nocompatible
if (has("termguicolors"))
  set termguicolors
endif

"─────────────────────────────────────────────────────────  VIMSPECTOR  ──────"

let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

"────────────────────────────────────────────────────────────  ansible  ───────
  au BufRead,BufNewFile */ans/inventory set filetype yaml.ansible
  au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
"─────────────────────────────────────────────────────────  indentline  ───────

"let g:indentLine_setColors = 0

"────────────────────────────────────────────────────────────────  coc  ──────"

let g:coc_disable_startup_warning = 1

" close the preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" enable coclist
let g:coc_enable_locationlist = 1

" always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" use tab for trigger completion with characters ahead and navigate.
" note: use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
noremap <silent><expr> <TAB>
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
  inoremap <silent><expr> <c-space> coc#refesh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

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
nmap <leader>cmv <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>cac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>cqf  <Plug>(coc-fix-current)

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
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>ck  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>cp  :<C-u>CocListResume<CR>

" TODO: :CocConfig
" figure out global langauge server, linter, prettier, etc.
" coc-sh, coc-diagnostic,
  " https://kimpers.com/vim-intelligent-autocompletion/
  " https://www.chrisatmachine.com/Neovim/04-vim-coc/
  " https://github.com/neoclide/coc.nvim/network/dependents?dependents_before=NDA0MzM0NjQyNA
  " https://www.chrisatmachine.com/Neovim/04-vim-coc/

"──────────────────────────────────────────────────────────  ULTISNIPS  ──────"

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="horizontal"

" remove Ultisnips if you don't want plugin addons
let g:UltiSnipsSnippetDirectories=["UltiSnips", "snips"]

"─────────────────────────────────────────────────────────  GIT GUTTER  ──────"
" custom symbols
let g:gitgutter_sign_added = '落'
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''
let g:gitgutter_override_sign_column_highlight = 0

" speed update
set updatetime=250

command! Gqf GitGutterQuickFix | copen

"───────────────────────────────────────────  INSTANT MARKDOWN PREVIEW   ──────

let g:mkdp_auto_start = 0 " auto-start w/ .md file
let g:mkdp_auto_close = 1 " auto-close on .md exit
let g:mkdp_auto_open = 0  " auto-open on .md 
let g:mkdp_refresh_slow = 1 " reduce refresh speed

let g:vim_markdown_no_default_key_mappings = 1

"─────────────────────────────────────────────────  AIRLINE STATUS BAR  ──────"

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_highlighting_cache = 1

"────────────────────────────────────────────────────────────────  FZF   ─────"

let $FZF_DEFAULT_OPTS=''
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path './**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4  --bind=ctrl-j:preview-down,ctrl-k:preview-up'
"let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(50)
  let width = float2nr(80)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

" #############################################################################
" ############################# G R A V E Y A  R D  ###########################
" #############################################################################

"───────────────────────────────────────────────────────────  NERDTREE  ──────"

"  set modifiable " allow d
"  let g:NERDTreeWinSize=20 " column width
"
"  " bind f6: toggle view
"  nnoremap <silent> <expr> <F6> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
"
"  " start nerdtree, unless a file or session is specified, eg. vim -s session_file.vim.
"  " autocmd StdinReadPre * let s:std_in=1
"  " autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif
"
"  " if closing last open document, nuke nerdtree
"  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
"      \ quit | endif
"
"  " nerdtree clone on every tab
"  autocmd BufWinEnter * silent NERDTreeMirror
"
"────────────────────────────────────────────────  NERDTREE GIT STATUS  ──────"
"
"  " show untracked & custom icons:
"  let g:NERDTreeGitStatusUntrackedFilesMode = 'all'
"
"  " custom git icons
"  let g:NERDTreeGitStatusIndicatorMapCustom = {
"      \ 'Modified'  :'â¹',
"      \ 'Staged'    :'â',
"      \ 'Untracked' :'â­',
"      \ 'Renamed'   :'â',
"      \ 'Unmerged'  :'â',
"      \ 'Deleted'   :'â',
"      \ 'Dirty'     :'â',
"      \ 'Ignored'   :'â',
"      \ 'Clean'     :'âï¸',
"      \ 'Unknown'   :'?',
"      \ }
"──────────────────────────────────────────────────────────  COLORIZER  ──────"
" let g:colorizer_auto_color = 1  " colorizer (auto)

