"  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
"  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
"  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
"  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
"  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
"                VIM PLUGINS
"────────────────────────────────────────────────────────────
filetype plugin indent on                     " help plugins load
call plug#begin('~/.config/nvim/plugged')     " plugin manager
Plug 'junegunn/vim-plug'                      " plugin manager
"────────────────────────────────────────────────────────────
" UNIVERSAL
"────────────────────────────────────────────────────────────
" sensible improvements
" Plug 'tpope/vim-sensible'
" color scheme
  Plug 'arcticicestudio/nord-vim'
" status bar
  Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
" fuzzy finder
  Plug '~/.config/fzf'
" completion
  Plug 'neoclide/coc.nvim',
" snippets w/ library
  Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
" ssh copy/paste
  Plug 'ojroques/vim-oscyank'
"────────────────────────────────────────────────────────────
" GIT
"────────────────────────────────────────────────────────────
" core
  Plug 'tpope/vim-fugitive'
" open lines > visually selected
  Plug 'tpope/vim-rhubarb'
" diff
  Plug 'jreybert/vimagit'
" gutter symbols
  Plug 'airblade/vim-gitgutter'
"────────────────────────────────────────────────────────────
" PROGRAMMING
"────────────────────────────────────────────────────────────
" universal
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'puremourning/vimspector'
" .md markdown
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" python
  Plug 'vim-scripts/indentpython.vim'
" i3 wm
  Plug 'mboughaba/i3config.vim',
  " universal
  " Plug 'sheerun/vim-polyglot'
"────────────────────────────────────────────────────────────
" end of plugins
call plug#end()
" disable upgrade (automatic now)
delc PlugUpgrade


"────────────────────────────────────────────────────────────
"────────────────────────────────────────────────────────────
" GRAVEYARD
"────────────────────────────────────────────────────────────
"────────────────────────────────────────────────────────────
" tmux vim nav
" Plug 'christoomey/vim-tmux-navigator'
"────────────────────────────────────────────────────────────
" " sh syntax analysis
" Plug 'dense-analysis/ale',
"────────────────────────────────────────────────────────────
" " color hexcode highlighter
" Plug 'chrisbra/Colorizer'
"────────────────────────────────────────────────────────────
" fzf
" Plug 'junegunn/fzf.vim'
"────────────────────────────────────────────────────────────
" multi-file find and replace.
" Plug 'mhinz/vim-grepper'
"────────────────────────────────────────────────────────────
" file browser
" Plug 'preservim/nerdtree'
"     \ Plug 'Xuyuanp/nerdtree-git-plugin' |
"     \ Plug 'ryanoasis/vim-devicons'
"────────────────────────────────────────────────────────────
" sh parser, format, interpret
"Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
"────────────────────────────────────────────────────────────
" .md markdown
" Plug 'godlygeek/tabular'
"   Plug 'plasticboy/vim-markdown'
"────────────────────────────────────────────────────────────
" sxhkd
" Plug 'kovetskiy/sxhkd-vim'
