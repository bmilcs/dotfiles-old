" ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   
" ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.    https://dot.bmilcs.com
" ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
" ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█    ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
" ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀    ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
" vim plugins

"────────────────────────────────────────────────────────────  MANAGER  ──────"

filetype plugin indent on                     " help plugins load
call plug#begin('~/.config/nvim/plugged')     " plugin manager
Plug 'junegunn/vim-plug'                      " plugin manager

"──────────────────────────────────────────────────────────  UNIVERSAL  ──────"

" color schemes
  Plug 'arcticicestudio/nord-vim'
  Plug 'morhetz/gruvbox'

" status bar
  Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

" fuzzy finder
  Plug '~/.config/fzf'
    Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
    Plug 'junegunn/fzf.vim'

" completion
  Plug 'neoclide/coc.nvim',

" snippets w/ library
  Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

" indentation lines (tab)
  Plug 'Yggdroot/indentLine'
  " Plug 'lukas-reineke/indent-blankline.nvim'

" note taking stack: vimwiki, taskwiki, taskwarrior
  Plug 'vimwiki/vimwiki'
" Plug 'tbabej/taskwiki'

" windows terminal / ws2 clipboard
  Plug 'ojroques/vim-oscyank'

"────────────────────────────────────────────────────────────────  GIT  ──────"

" gutter symbols
  Plug 'airblade/vim-gitgutter'

"────────────────────────────────────────────────────────  PROGRAMMING  ──────"

" universal
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'puremourning/vimspector'

" html css 
  Plug 'turbio/bracey.vim'

" nginx
  Plug 'chr4/nginx.vim'

" docker-compose
  Plug 'kkvh/vim-docker-tools'

" .md markdown
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" python
" Plug 'vim-scripts/indentpython.vim'

" i3 wm
  Plug 'mboughaba/i3config.vim'

" ansible
  Plug 'pearofducks/ansible-vim'      " syntax highlighting
  Plug 'phenomenes/ansible-snippets'  " snippets

"────────────────────────────────────────────────────────────  the end  ──────"

call plug#end()
delc PlugUpgrade " disable upgrade (automatic now)

"──────────────────────────────────────────────────────────  graveyard  ──────"
"
"────────────────────────────────────────────────────────────────  git  ──────"
" core
" Plug 'tpope/vim-fugitive'

" open lines > visually selected
" Plug 'tpope/vim-rhubarb'

" diff
" Plug 'jreybert/vimagit'

"
" universal
" Plug 'sheerun/vim-polyglot'
"
"─────────────────────────────────────────────────────────────────────────────"
"
" sensible improvements
" Plug 'tpope/vim-sensible'
"
"─────────────────────────────────────────────────────────────────────────────"
"
" tmux vim nav
" Plug 'christoomey/vim-tmux-navigator'
"
"─────────────────────────────────────────────────────────────────────────────"
"
" " sh syntax analysis
" Plug 'dense-analysis/ale',
"
"─────────────────────────────────────────────────────────────────────────────"
"
" " color hexcode highlighter
" Plug 'chrisbra/Colorizer'
"
"─────────────────────────────────────────────────────────────────────────────"
"
" fzf
" Plug 'junegunn/fzf.vim'
"
"─────────────────────────────────────────────────────────────────────────────"
"
" multi-file find and replace.
" Plug 'mhinz/vim-grepper'
"
"─────────────────────────────────────────────────────────────────────────────"
"
" file browser
" Plug 'preservim/nerdtree'
"     \ Plug 'Xuyuanp/nerdtree-git-plugin' |
"     \ Plug 'ryanoasis/vim-devicons'
"
"─────────────────────────────────────────────────────────────────────────────"
"
" sh parser, format, interpret
"Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
"
"─────────────────────────────────────────────────────────────────────────────"
"
" .md markdown
" Plug 'godlygeek/tabular'
"   Plug 'plasticboy/vim-markdown'
"
"─────────────────────────────────────────────────────────────────────────────"
"
" sxhkd
" Plug 'kovetskiy/sxhkd-vim'
"
