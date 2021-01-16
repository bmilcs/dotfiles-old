"  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
"  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
"  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
"  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
"  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
"────────────────────────────────────────────────────────────
" VIM RC CORE 
"────────────────────────────────────────────────────────────
" TODO 
" 
" 1. Add shortcuts:
"           sort alphabetically       :sort u
"           bring up errors           :messages
"           reload current file       :e!
"           toggle ve block vs all    :set ve=all/block
"
" 2. Git:
"           establish workflow for commits
"           add keyboard shortcuts
"
" 2. Create titlebar function/hotkey to create headers
"
"
"────────────────────────────────────────────────────────────
" GENERAL CUSTOMIZATIONS
"────────────────────────────────────────────────────────────


set nocompatible                              " set compatibility to vim only
colorscheme nord                              " color scheme
set mouse=a                                   " allow mouse interaction
set directory^=$HOME/.vim/swap//              " vim swap file location
set hidden                                    " hide buffers when they are abandoned
set backspace=indent,eol,start                " fixes common backspace problems
set shell=zsh\ -l
set modelines=0                               " turn off modelines
set formatoptions=tcqrn1                      " set textwidth=79
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
set scrolloff=5                               " display 5 lines above/below the cursor when scrolling with a mouse.
set ttyfast                                   " speed up scrolling in vim
set laststatus=2                              " status bar
set showmode                                  " display options
set showcmd                                   " display command
set matchpairs+=<:>                           " highlight matching pairs of brackets. use the '%' character to jump between them.
set number                                    " show line numbers
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}    " Set status line display
set encoding=utf-8                            " encoding 
set hlsearch                                  " highlight matching search patterns
set incsearch                                 " enable incremental search
set ignorecase                                " include matching uppercase words with lowercase search term
set smartcase                                 " include only uppercase words with uppercase search term
set relativenumber                            " line numbers move up/down
" set wrap                                    " auto word wrap
set nowrap                                    " no word wrap
set completeopt=longest,menuone               " view full error msg pumheight?

"────────────────────────────────────────────────────────────
" VIMINFO
"────────────────────────────────────────────────────────────

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

" set list " display different types of white spaces.
" set listchars=tab:âº\ ,trail:â¢,extends:#,nbsp:.

"────────────────────────────────────────────────────────────
" FILE-TYPE AUTOMATION
"────────────────────────────────────────────────────────────

filetype off " force plugins to load correctly when it is turned back on below.
syntax on
augroup filetypedetect
  au BufNewFile,BufRead *.fsh,*.vsh setf glsl
  au BufRead,BufNewFile *.conf setf dosini
augroup END
filetype on
"
" allow lowercase git commands
" source: https://www.reddit.com/r/vim/comments/90vy21/more_accessible_fugitive_commands/
 for gcommand in ['Git', 'Gcd', 'Glcd', 'Gstatus', 'Gcommit', 'Gmerge', 'Gpull',
\ 'Grebase', 'Gpush', 'Gfetch', 'Grename', 'Gdelete', 'Gremove', 'Gblame', 'Gbrowse',
\ 'Ggrep', 'Glgrep', 'Glog', 'Gllog', 'Gedit', 'Gsplit', 'Gvsplit', 'Gtabedit', 'Gpedit',
\ 'Gread', 'Gwrite', 'Gwq', 'Gdiff', 'Gsdiff', 'Gvdiff', 'Gmove']
  exe 'cnoreabbrev g'.gcommand[1:].' '.gcommand
endfor

"
" gRAVEYARD
"

" pLUGINS

  "Plug 'godlygeek/tabular'                      " markdown
  "Plug 'plasticboy/vim-markdown'                " markdown
"  Plug 'mboughaba/i3config.vim'                 " i3 syntax

" kEY BINDINGS

  " insert mode:
  " inoremap <Up> <nop>
  " inoremap <Down> <nop>
  " inoremap <Left> <nop>
  " inoremap <Right> <nop>

  " clipboard mod 
  " vnoremap <C-c> y: call system("xclip -i", getreg("\""))<CR>
  " noremap <A-V> :r !xclip -o <CR>
    
" cLIPBOARD    
    
  " * = PRIMARY (vim)
  " + = CLIPBOARD (system)
  " set clipboard=unnamedplus  " + plus, system ^c)
  " noremap <Leader>y "*y
  " noremap <Leader>p "*p
