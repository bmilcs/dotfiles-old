"  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
"  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
"  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
"  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
"  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
"────────────────────────────────────────────────────────────
"   VIM PLUGINS RC
"────────────────────────────────────────────────────────────

" install vim-plug and plugins if vim-plug is not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
autocmd! VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | q | endif

"
" PLUGINS
"

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
  Plug '~/.fzf'                                 " fuzzy finder
  Plug 'junegunn/fzf.vim'
  Plug 'mhinz/vim-grepper'                      " multi-file find and replace.
  Plug 'chrisbra/Colorizer'                     " color hexcode highlighter
  Plug 'vim-airline/vim-airline'                " status bar 
  Plug 'vim-airline/vim-airline-themes'         " status bar themes

  Plug 'kovetskiy/sxhkd-vim'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}  " language: markdown (.md)
call plug#end()                                 " end of plugins
set rtp+=~/.fzf

"
" PLUGIN: MARKDOWN PREVIEW 
"

let g:mkdp_auto_start = 1 " auto-start w/ .md file
let g:mkdp_auto_close = 1 " auto-close on .md exit
let g:mkdp_refresh_slow = 0 " reduce refresh speed
let g:mkdp_command_for_global = 0 " md can be used on all files
let g:vim_markdown_no_default_key_mappings = 1

"
" PLUGIN: COLORIZER
"

let g:colorizer_auto_color = 1  " colorizer (auto)

"
" PLUGIN: NERDTREE
"

set modifiable " allow d
let g:NERDTreeWinSize=20 " column width

" bind f6: toggle view
nnoremap <silent> <expr> <F6> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>" 

" start nerdtree, unless a file or session is specified, eg. vim -s session_file.vim.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif

" if closing last open document, nuke nerdtree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" nerdtree clone on every tab
autocmd BufWinEnter * silent NERDTreeMirror 

"
" PLUGIN: NERDTREE GIT STATUS
"

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

"
" PLUGIN: AIRLINE STATUS BAR
"

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_highlighting_cache = 1

