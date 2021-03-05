"  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
"  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
"  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
"  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
"  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
"                VIM PLUGINS RC
"────────────────────────────────────────────────────────────

filetype plugin indent on                     " help plugins load
call plug#begin('~/.config/nvim/plugged')     " plugin manager

Plug 'junegunn/vim-plug'
  Plug 'tpope/vim-sensible'                     " general improvements
  Plug 'arcticicestudio/nord-vim'               " colorscheme
  Plug '~/.config/fzf'                          " fuzzy finder
  Plug 'vim-airline/vim-airline'                " status bar
    Plug 'vim-airline/vim-airline-themes'         " status bar themes
  Plug 'christoomey/vim-tmux-navigator'         " tmux vim nav
  Plug 'mboughaba/i3config.vim',                " language: i3config 
  Plug 'neoclide/coc.nvim',                     " completion
  Plug 'kovetskiy/sxhkd-vim'                    " language: sxhkd
  Plug 'tpope/vim-fugitive'                     " git core
  Plug 'tpope/vim-rhubarb'                      " git open lines > visually selected
  Plug 'jreybert/vimagit'                       " git diff
  Plug 'airblade/vim-gitgutter'                 " git gutter symbols
  Plug 'godlygeek/tabular'                      " tabular (must before markdown)
    Plug 'plasticboy/vim-markdown'                " markdown syntax, match, map
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}  " language: markdown (.md)
" Plug 'dense-analysis/ale',                  " sh syntax analysis
" Plug 'chrisbra/Colorizer'                   " color hexcode highlighter
" Plug 'junegunn/fzf.vim'
"  Plug 'mhinz/vim-grepper'                   " multi-file find and replace.
"  Plug 'preservim/nerdtree'                     " file browser
"      \ Plug 'Xuyuanp/nerdtree-git-plugin' |
"      \ Plug 'ryanoasis/vim-devicons'
"Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }     " sh parser, format, interpret

call plug#end()                                 " end of plugins
delc PlugUpgrade                                " disable upgrade (automatic now)
autocmd VimEnter *                              " auto-install missing plugins
  \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall | q
  \| endif

set rtp+=~/.config/fzf

" auto update vim-plug


"────────────────────────────────────────────────────────────
" NORD THEME
"────────────────────────────────────────────────────────────
colorscheme nord                              " color scheme

"────────────────────────────────────────────────────────────
" COC
"────────────────────────────────────────────────────────────
" TODO: :CocConfig
" figure out global langauge server, linter, prettier, etc.
" coc-sh, coc-diagnostic,
  " https://kimpers.com/vim-intelligent-autocompletion/
  " https://www.chrisatmachine.com/Neovim/04-vim-coc/
  " https://github.com/neoclide/coc.nvim/network/dependents?dependents_before=NDA0MzM0NjQyNA
  " https://www.chrisatmachine.com/Neovim/04-vim-coc/
  
  " set pyxversion=3
set cmdheight=1
set updatetime=300

" close the preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" enable CocList
let g:coc_enable_locationlist = 1

"────────────────────────────────────────────────────────────
"COC-SNIPPETS
"────────────────────────────────────────────────────────────

" Use <C-l> for trigger snippet expand.
imap <C-j> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-k> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

"────────────────────────────────────────────────────────────
" FILE(TYPE) AUTOMATION
"────────────────────────────────────────────────────────────

filetype off
syntax on
augroup filetypedetect
  au BufRead,BufNewFile *.conf setf dosini
  au BufNewFile,BufRead *.fsh,*.vsh setf glsl
  au BufRead,BufNewFile *rc setf dosini
augroup END
filetype on

autocmd BufRead,BufNewFile ~/txt/* set syntax=markdown
autocmd BufRead,BufNewFile ~/bin/* set syntax=sh
autocmd BufRead,BufNewFile ~/.config/i3/config set filetype=i3config

"────────────────────────────────────────────────────────────
" GIT GUTTER
"────────────────────────────────────────────────────────────
"────────────────────────────────────────────────────────────
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

"────────────────────────────────────────────────────────────
" MARKDOWN PREVIEW
"────────────────────────────────────────────────────────────

let g:mkdp_auto_start = 1 " auto-start w/ .md file
let g:mkdp_auto_close = 1 " auto-close on .md exit
let g:mkdp_refresh_slow = 0 " reduce refresh speed
let g:mkdp_command_for_global = 0 " md can be used on all files
let g:vim_markdown_no_default_key_mappings = 1

"────────────────────────────────────────────────────────────
" AIRLINE STATUS BAR
"────────────────────────────────────────────────────────────

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_highlighting_cache = 1

"────────────────────────────────────────────────────────────
" FZF: FUZZY FINDER
"────────────────────────────────────────────────────────────
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path './**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

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

"────────────────────────────────────────────────────────────
" NERDTREE
"────────────────────────────────────────────────────────────
"  
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
"  "────────────────────────────────────────────────────────────
"  " NERDTREE GIT STATUS
"  "────────────────────────────────────────────────────────────
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
"────────────────────────────────────────────────────────────
" COLORIZER
"────────────────────────────────────────────────────────────

" let g:colorizer_auto_color = 1  " colorizer (auto)

