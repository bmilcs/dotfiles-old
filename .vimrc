" BMILCS/VIMRC
"
" -------------------------------------------------------
" TODO shortcut: sort alphabetically --- :sort u
" TODO fix clipboards: 2x shortcuts - system & vim buffer
" -------------------------------------------------------

" help plugins load 
filetype plugin indent on

" plugin manager 
call plug#begin('~/.vim/plugged')

"
" PLUGINS: GLOBAL
"
  
" general improvements
Plug 'tpope/vim-sensible'

" colorscheme
Plug 'arcticicestudio/nord-vim'

" tmux
Plug 'christoomey/vim-tmux-navigator'

" git 
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" file browser
Plug 'preservim/nerdtree' |
      \ Plug 'Xuyuanp/nerdtree-git-plugin' |
      \ Plug 'ryanoasis/vim-devicons'

" color hexcode highlighter
Plug 'chrisbra/Colorizer'

" status bar 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"
" PLUGINS: LANGUAGE SPECIFIC
"

" configs 
Plug 'mboughaba/i3config.vim'
Plug 'kovetskiy/sxhkd-vim'

" markdown (.md)
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  "Plug 'godlygeek/tabular'
  "Plug 'plasticboy/vim-markdown'

call plug#end()

"
" COLOR SCHEME
"

colorscheme nord

" 
" KEY BINDINGS 
"

" show full error messages
nnoremap <silent> E :call LanguageClient#explainErrorAtPoint()<CR>

" macros
nnoremap <Space> @q " quick macro replay @q
nnoremap <leader>q :<c-u><c-r><c-r>='let @q = '. string(getreg('q'))<cr><c-f><left> " Easily edit the macro stored at register q


" swap ; with :
nnoremap ; :
nnoremap : ;

" disable arrow keys
noremap <Up> <nop>    
noremap <Left> <nop>
noremap <Right> <nop>
noremap <Down> <nop>
    " insert mode:
    " inoremap <Up> <nop>
    " inoremap <Down> <nop>
    " inoremap <Left> <nop>
    " inoremap <Right> <nop>

" vs code > new line 
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" vs code > move line up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


" clipboard mod 
    " vnoremap <C-c> y: call system("xclip -i", getreg("\""))<CR>
    " noremap <A-V> :r !xclip -o <CR>

" clipboard > system
set clipboard+=unnamedplus

"
" GENERAL CUSTOMIZATIONS
"

set hidden " hide buffers when they are abandoned
set backspace=indent,eol,start " fixes common backspace problems
set shell=zsh\ -l   
set nocompatible " set compatibility to vim only
set modelines=0 " turn off modelines
set formatoptions=tcqrn1    " set textwidth=79
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
set scrolloff=5 " display 5 lines above/below the cursor when scrolling with a mouse.
set ttyfast " speed up scrolling in vim
set laststatus=2    " status bar
set showmode  " display options
set showcmd
set matchpairs+=<:> " highlight matching pairs of brackets. use the '%' character to jump between them.
set number  " show line numbers
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}    " Set status line display
set encoding=utf-8    " encoding 
set hlsearch  " highlight matching search patterns
set incsearch " enable incremental search
set ignorecase  " include matching uppercase words with lowercase search term
set smartcase " include only uppercase words with uppercase search term
" store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. useful for copying large amounts of data between files.
set viminfo='1000,<99999,s1000  
set relativenumber  " line numbers move up/down
" set wrap    " auto word wrap
" set list " display different types of white spaces.
" set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

"
" FILE EXTENSION CUSTOMIZATION
"

" force plugins to load correctly when it is turned back on below.
filetype off
  syntax on
  augroup filetypedetect
    au BufNewFile,BufRead *.fsh,*.vsh setf glsl
    au BufRead,BufNewFile *.conf setf dosini
  augroup END
filetype on


" PLUGIN TWEAKS ---------------------------------------------------

"
" MARKDOWN PREVIEW 
"

let g:mkdp_auto_start = 1 " auto-start w/ .md file
let g:mkdp_auto_close = 1 " auto-close on .md exit
let g:mkdp_refresh_slow = 0 " reduce refresh speed
let g:mkdp_command_for_global = 0 " md can be used on all files
let g:vim_markdown_no_default_key_mappings = 1

"
" COLORIZER
"

let g:colorizer_auto_color = 1  " colorizer (auto)

"
" NERDTREE
"

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
" NERDTREE: GIT STATUS
"

" show untracked & custom icons:
let g:NERDTreeGitStatusUntrackedFilesMode = 'all' 

" custom git icons
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


"
" AIRLINE STATUS BAR
"

" fix > status bar symbols
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
let g:airline_symbols.linenr = '' 
let g:airline_powerline_fonts = 1
