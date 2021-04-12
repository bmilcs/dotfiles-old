"  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
"  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
"  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
"  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
"  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
"                 VIM GENERAL SEETTINGS [./00-general.vim]
"────────────────────────────────────────────────────────────

" vim settings (not vi)
set nocompatible  " must be first

" better autocomplete
"set wildmenu

" ask to save
set confirm

" flash if doing something wrong
set visualbell

" set vim runtimepath
set rtp+=~/.config/nvim/

" security: turn off modelines
set modelines=0

" fix common backspace problems
set backspace=indent,eol,start

" don't redraw in middle of macro
set lazyredraw

" retain undo history
set undofile
set undodir=~/.config/nvim/undo

" disable swap file
set noswapfile

" disable backup
set nobackup       " coc: backup is removed after successful write
set nowritebackup  " coc: backup does not run at all
set updatetime=300 " coc
set shortmess+=c   " coc: don't pass messages to |ins-completion-menu|.
" set cmdheight=2  " bottom bar height

" case insensitivity
set ignorecase   " match upper/lowercase versions of search term
set smartcase    " only uppercase words w/ uppercase search term

" <tab> behavior
set shiftwidth=2  " columns of whitespace: “level of indentation"
set tabstop=2     " columns of whitespace: \t char
set softtabstop=2 " columns of whitespace per tab/backspace keypresses
set expandtab     " convert \t to spaces
set autoindent    " auto indentation

" search features
set hlsearch      " highlight matching search patterns
set incsearch     " enable incremental search
if has("nvim")
  set inccommand=split
endif

" set mapleader before other configs
let mapleader=" "
nnoremap <SPACE> <Nop>

set pumheight=50                              " auto-complete drop down menu size
set completeopt=longest,menuone               " view full error msg pumheight?
set directory=$HOME/.config/nvim/swap//    " vim swap file location
set encoding=utf-8                            " encoding
set formatoptions=tcqrn1                      " set textwidth=79
set hidden                                    " hide buffers when they are abandoned
set laststatus=2                              " status bar
set matchpairs+=<:>                           " highlight matching pairs of brackets. use the '%' character to jump between them.
set mouse=a                                   " allow mouse interaction
set noshiftround
set nowrap                                    " no word wrap
set number                                    " show line numbers
set relativenumber                            " line numbers move up/down
set scrolloff=10                               " display 5 lines above/below the cursor when scrolling with a mouse.
set shell=zsh\ -l
set showcmd                                   " display command
set showmode                                  " display options

" set status line display
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}
"set ttyfast                                   " speed up scrolling in vim

" set list                                    " display different types of white spaces.
" set wrap                                    " auto word wrap


"set list listchars=trail:.,extends:>
"set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
"set listchars=tab:..,trail:_,extends:>,precedes:<,nbsp:~
set showbreak=↪\ 
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨


set cc=80
"'let &colorcolumn = join(range(81,999), ',')

"────────────────────────────────────────────────────────────
" VIMINFO
"────────────────────────────────────────────────────────────

set viminfo=%,<1500,'25,/250,:1000,n~/.config/nvim/cache/.viminfo

"           %,<800,'10,/50,:100,h,f0,n~/.vim/cache/.viminfo
"           | |    |   |   |    | |  + viminfo file path
"           | |    |   |   |    | + file marks 0-9,A-Z 0=NOT stored
"           | |    |   |   |    + disable 'hlsearch' loading viminfo
"           | |    |   |   + command-line history saved
"           | |    |   + search history saved
"           | |    + files marks saved
"           | + lines saved each register (old name for <, vi6.2)
"           + save/restore buffer list

"────────────────────────────────────────────────────────────
" AUTOMATION
"────────────────────────────────────────────────────────────

" auto save on focus lost
:au FocusLost * silent! wa

" disable folding
" set nofoldenable    " disable folding
