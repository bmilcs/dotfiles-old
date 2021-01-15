" ########  ##     ## #### ##        ######   ######  
" ##     ## ###   ###  ##  ##       ##    ## ##    ##  
" ##     ## #### ####  ##  ##       ##       ##        DOTFILES
" ########  ## ### ##  ##  ##       ##        ######   dot.bmilcs.com
" ##     ## ##     ##  ##  ##       ##             ##  
" ##     ## ##     ##  ##  ##       ##    ## ##    ##  00-core.vim
" ########  ##     ## #### ########  ######   ###### 

" TODO shortcut: sort alphabetically --- :sort u
"              : bring up errors --- :messages

" Install vim-plug and plugins if vim-plug is not already installed
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
" KEY BINDINGS 
"

" visual block retention post command
nmap Y y$
vmap < <gv
vmap > >gv

" macros
nnoremap <Space> @q " quick macro replay @q
nnoremap <leader>q :<c-u><c-r><c-r>='let @q = '. string(getreg('q'))<cr><c-f><left> " Easily edit the macro stored at register q

" swap ; with :
nnoremap ; :
nnoremap : ;

" vs code > new line 
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" vs code > move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==

" clipboard > system
set clipboard=unnamed       " * primary, on select 
noremap <Leader>p "+p
noremap <Leader>y "+y

"
" VIMINFO
"

set viminfo=%,<1500,'25,/250,:1000,n~/.vim/cache/.viminfo
"et viminfo=%,<800,'10,/50,:100,h,f0,n~/.vim/cache/.viminfo
"           | |    |   |   |    | |  + viminfo file path
"           | |    |   |   |    | + file marks 0-9,A-Z 0=NOT stored
"           | |    |   |   |    + disable 'hlsearch' loading viminfo
"           | |    |   |   + command-line history saved
"           | |    |   + search history saved
"           | |    + files marks saved
"           | + lines saved each register (old name for <, vi6.2)
"           + save/restore buffer list

"
" GENERAL CUSTOMIZATIONS
"

colorscheme nord " color scheme
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
set relativenumber  " line numbers move up/down
" set wrap    " auto word wrap
set completeopt=longest,menuone   " view full error msg | ie pumheight?

" set list " display different types of white spaces.
" set listchars=tab:âº\ ,trail:â¢,extends:#,nbsp:.

"
" FILE-TYPE AUTOMATION
"

filetype off " force plugins to load correctly when it is turned back on below.
syntax on
augroup filetypedetect
  au BufNewFile,BufRead *.fsh,*.vsh setf glsl
  au BufRead,BufNewFile *.conf setf dosini
augroup END
filetype on

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

"
" FZF: FUZZY FINDER
"

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

" Map a few common things to do with FZF.
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>

" Allow \assing optional flags into the Rg command.
"   Example: :Rg myterm -g '*.md'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ "rg --column --line-number --no-heading --color=always --smart-case " .
  \ <q-args>, 1, fzf#vim#with_preview(), <bang>0)


" 
" MHINZ/VIM-GREPPER
" 

let g:grepper={}
let g:grepper.tools=["rg"]

xmap gr <plug>(GrepperOperator)

" After searching for text, press this mapping to do a project wide find and
" replace. It's similar to <leader>r except this one applies to all matches
" across all files instead of just the current file.
nnoremap <Leader>r
  \ :let @s='\<'.expand('<cword>').'\>'<CR>
  \ :Grepper -cword -noprompt<CR>
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" The same as above except it works with a visual selection.
xmap <Leader>r
    \ "sy
    \ gvgr
    \ :cfdo %s/<C-r>s//g \| update
     \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>



"" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'
"
"" airline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

"
" GRAVEYARD
"

" PLUGINS

  "Plug 'godlygeek/tabular'                      " markdown
  "Plug 'plasticboy/vim-markdown'                " markdown
"  Plug 'mboughaba/i3config.vim'                 " i3 syntax

" KEY BINDINGS

  " insert mode:
  " inoremap <Up> <nop>
  " inoremap <Down> <nop>
  " inoremap <Left> <nop>
  " inoremap <Right> <nop>

  " clipboard mod 
  " vnoremap <C-c> y: call system("xclip -i", getreg("\""))<CR>
  " noremap <A-V> :r !xclip -o <CR>
    
" CLIPBOARD    
    
  " * = PRIMARY (vim)
  " + = CLIPBOARD (system)
  " set clipboard=unnamedplus  " + plus, system ^c)
  " noremap <Leader>y "*y
  " noremap <Leader>p "*p
