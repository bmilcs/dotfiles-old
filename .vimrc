" For plug-ins to load correctly.
filetype plugin indent on

" PLUGINS ------------------------------------------------------
call plug#begin('~/.vim/plugged')
  " markdown plugins
  "Plug 'godlygeek/tabular'
  "Plug 'plasticboy/vim-markdown'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  " tmux vim nav
  Plug 'christoomey/vim-tmux-navigator'
  " theme
  Plug 'arcticicestudio/nord-vim'
  " git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-fugitive'
  Plug 'preservim/nerdtree' |
        \ Plug 'Xuyuanp/nerdtree-git-plugin' |
        \ Plug 'ryanoasis/vim-devicons'
  Plug 'chrisbra/Colorizer'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'mboughaba/i3config.vim'
  Plug 'kovetskiy/sxhkd-vim'
call plug#end()

" COLOR SCHEME -------------------------------------------------
colorscheme nord

" HOTKEY MODS --------------------------------------------------
nnoremap ; :
nnoremap : ;
noremap <Up> <nop>    " disable arrow keys
noremap <Left> <nop>
noremap <Right> <nop>
noremap <Down> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
" new line | shift+enter
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
" move line up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" toggle paste method
" nnoremap <F2> :set invpaste paste?<CR>
" imap <F2> <C-O>:set invpaste paste?<CR>
" set pastetoggle=<F2>
" vnoremap <C-c> y: call system("xclip -i", getreg("\""))<CR>
" noremap <A-V> :r !xclip -o <CR>
set clipboard+=unnamedplus
"let mapleader=";"
" " Copy to clipboard
vnoremap <leader>y  "+y
nnoremap <leader>Y  "+yg_
nnoremap <leader>y  "+y
nnoremap <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Fixes common backspace problems
set backspace=indent,eol,start
" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" FILETYPE SPECIFICS -------------------------------------------
" Helps force plug-ins to load correctly when it is turned back on below.
filetype off
" Turn on syntax highlighting.
syntax on
augroup filetypedetect
  au BufNewFile,BufRead *.fsh,*.vsh setf glsl
  au BufRead,BufNewFile *.conf setf dosini
augroup END
filetype on

" OTHER --------------------------------------------------------
set shell=zsh\ -l   
set nocompatible " Set compatibility to Vim only.
set modelines=0   " turn off modelines
set wrap    " auto word wrap
set formatoptions=tcqrn1    " set textwidth=79
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
set scrolloff=5   " Display 5 lines above/below the cursor when scrolling with a mouse.
set ttyfast   " Speed up scrolling in Vim
set laststatus=2    " Status bar
set showmode    " Display options
set showcmd
set matchpairs+=<:>   " Highlight matching pairs of brackets. Use the '%' character to jump between them.
set number    " Show line numbers
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}    " Set status line display
set encoding=utf-8    " Encoding 
set hlsearch    " Highlight matching search patterns
set incsearch   " Enable incremental search
set ignorecase    " Include matching uppercase words with lowercase search term
set smartcase   " Include only uppercase words with uppercase search term
set viminfo=%,<800,'10,/50,:100,h,f0,n~/.vim/cache/.viminfo
" set viminfo='100,<9999,s100   " Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
" Automatically save and load folds
set relativenumber  " Line numbers move up/down
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview"

" markdown preview = https://github.com/iamcco/markdown-preview.nvim
let g:mkdp_auto_start = 1   " auto-start w/ .md file
let g:mkdp_auto_close = 1   " auto-close on .md exit
let g:mkdp_refresh_slow = 0   " reduce refresh speed
let g:mkdp_command_for_global = 0   " md can be used on all files
let g:vim_markdown_no_default_key_mappings = 1

" colorizer auto
let g:colorizer_auto_color = 1    " COLORIZER

" nerdtree customizations
nnoremap <silent> <expr> <F6> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>" " f6 to toggle nerd tree
" nerd tree on launch: autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
      \ quit | endif
" nerdtree auto-close when last vim doc is closed
autocmd BufWinEnter * silent NERDTreeMirror " nerdtree clone on every tab
let g:NERDTreeGitStatusUntrackedFilesMode = 'all' " nerdtree: show untracked & custom icons:
let g:NERDTreeGitStatusIndicatorMapCustom = {
      \ 'Modified'  :'✹',
      \ 'Staged'    :'✚',
      \ 'Untracked' :'✭',
      \ 'Renamed'   :'➜',
      \ 'Unmerged'  :'═',
      \ 'Deleted'   :'✖',
      \ 'Dirty'     :'✗',
      \ 'Ignored'   :'☒',
      \ 'Clean'     :'✔︎',
      \ 'Unknown'   :'?',
      \ }
let g:NERDTreeWinSize=20 " nerdtree width

"
" air-line
"
"set guifont=Hack:h10:cANSI
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '' air-line
let g:airline_powerline_fonts = 1

" Display different types of white spaces.
" set list
" set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
