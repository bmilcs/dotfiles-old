"  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
"  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
"  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
"  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
"  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
"────────────────────────────────────────────────────────────
"   VIM PLUGINS RC
"────────────────────────────────────────────────────────────
" TODO
" 1. FZF: Add search for string in project folder
" 2. Clean up syntax
"────────────────────────────────────────────────────────────
" INSTALL VIM-PLUG & PLUGINS IF MISSING
"────────────────────────────────────────────────────────────

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vim/plugins.vim
endif
autocmd! VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | q | endif

"────────────────────────────────────────────────────────────
" LIST
"────────────────────────────────────────────────────────────

filetype plugin indent on                       " help plugins load
call plug#begin('~/.vim/plugged')               " plugin manager
  Plug 'tpope/vim-sensible'                     " general improvements
  Plug 'arcticicestudio/nord-vim'               " colorscheme
  Plug 'christoomey/vim-tmux-navigator'         " tmux
  Plug 'airblade/vim-gitgutter'                 " git
  Plug 'tpope/vim-fugitive'
  Plug 'preservim/nerdtree'                     " file browser
      \ Plug 'Xuyuanp/nerdtree-git-plugin' |
      \ Plug 'ryanoasis/vim-devicons'
  "Plug '~/.fzf'                                 " fuzzy finder
  Plug 'junegunn/fzf.vim'
"  Plug 'mhinz/vim-grepper'                      " multi-file find and replace.
  Plug 'chrisbra/Colorizer'                     " color hexcode highlighter
  Plug 'vim-airline/vim-airline'                " status bar
  Plug 'vim-airline/vim-airline-themes'         " status bar themes
  Plug 'kovetskiy/sxhkd-vim'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}  " language: markdown (.md)
  Plug 'mboughaba/i3config.vim',
  Plug 'dense-analysis/ale',                  " syntax analysis
call plug#end()                                 " end of plugins
set rtp+=~/.fzf

"────────────────────────────────────────────────────────────
" NORD THEME
"────────────────────────────────────────────────────────────
colorscheme nord                              " color scheme

"────────────────────────────────────────────────────────────
" MARKDOWN PREVIEW
"────────────────────────────────────────────────────────────

let g:mkdp_auto_start = 1 " auto-start w/ .md file
let g:mkdp_auto_close = 1 " auto-close on .md exit
let g:mkdp_refresh_slow = 0 " reduce refresh speed
let g:mkdp_command_for_global = 0 " md can be used on all files
let g:vim_markdown_no_default_key_mappings = 1

"────────────────────────────────────────────────────────────
" COLORIZER
"────────────────────────────────────────────────────────────

let g:colorizer_auto_color = 1  " colorizer (auto)

"────────────────────────────────────────────────────────────
" NERDTREE
"────────────────────────────────────────────────────────────

set modifiable " allow d
let g:NERDTreeWinSize=20 " column width

" bind f6: toggle view
nnoremap <silent> <expr> <F6> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

" start nerdtree, unless a file or session is specified, eg. vim -s session_file.vim.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif

" if closing last open document, nuke nerdtree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" nerdtree clone on every tab
autocmd BufWinEnter * silent NERDTreeMirror

"────────────────────────────────────────────────────────────
" NERDTREE GIT STATUS
"────────────────────────────────────────────────────────────

" show untracked & custom icons:
let g:NERDTreeGitStatusUntrackedFilesMode = 'all'

" custom git icons
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  :'â¹',
    \ 'Staged'    :'â',
    \ 'Untracked' :'â­',
    \ 'Renamed'   :'â',
    \ 'Unmerged'  :'â',
    \ 'Deleted'   :'â',
    \ 'Dirty'     :'â',
    \ 'Ignored'   :'â',
    \ 'Clean'     :'âï¸',
    \ 'Unknown'   :'?',
    \ }

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

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" Customize fzf colors to match your color scheme.
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-b': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}

" Launch fzf with CTRL+P.
nnoremap <silent> <C-p> :FZF -m<CR>
nnoremap <silent> <C-S-p> :FZF -m<CR>

" Map a few common things to do with FZF.
nnoremap <silent> <Leader>b :BMdotfiles<CR>
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>

" Allow \assing optional flags into the Rg command.
"   Example: :Rg myterm -g '*.md'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ "rg --column --line-number --no-heading --color=always --smart-case " .
  \ <q-args>, 1, fzf#vim#with_preview(), <bang>0)

" FZF: ~/bm dotfile search
command! -bang BMdotfiles call fzf#vim#files('~/bm', <bang>0)

" Path completion with custom source command
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

" Word completion with custom spec with popup layout option
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})

"────────────────────────────────────────────────────────────
" FILE(TYPE) AUTOMATION
"────────────────────────────────────────────────────────────

" force plugins to load correctly when it is turned back on below.
filetype off
syntax on
augroup filetypedetect
  au BufNewFile,BufRead *.fsh,*.vsh setf glsl
  au BufRead,BufNewFile *.conf setf dosini
  au BufRead,BufNewFile *rc setf dosini
augroup END
filetype on

aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

"────────────────────────────────────────────────────────────
" ALE
"────────────────────────────────────────────────────────────

let g:ale_fix_on_save = 1
call ale#handlers#shellcheck#DefineLinter('sh')
" " remove trailing whitespaces / ^M chars
" augroup ws
"   au!
"   autocmd FileType c,cpp,java,php,js,json,css,scss,sass,py,rb,coffee,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" augroup end

"
