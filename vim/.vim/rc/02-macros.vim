"  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
"  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
"  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
"  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
"  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
"────────────────────────────────────────────────────────────
"   VIM CUSTOM SHORTCUTS
"────────────────────────────────────────────────────────────
"
" TODO    Add leader shortcuts:
"         - delete double spaces
"         - format/move comments to column #45
"         - improve fzf shortcuts, for project files, within
"           files, etc.
"
"────────────────────────────────────────────────────────────
" KEEP VISUAL BLOCK AFTER ISSUING COMMAND
"────────────────────────────────────────────────────────────
nmap Y y$
vmap < <gv
vmap > >gv

"────────────────────────────────────────────────────────────
" SWAP COMMAND LINE TO :
"────────────────────────────────────────────────────────────
nnoremap ; :
nnoremap : ;

"────────────────────────────────────────────────────────────
" VS CODE > NEW LINE 
"────────────────────────────────────────────────────────────
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

"────────────────────────────────────────────────────────────
" VS CODE > MOVE LINES UP/DOWN
"────────────────────────────────────────────────────────────
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==

"────────────────────────────────────────────────────────────
" CLIPBOARD > SYSTEM
"────────────────────────────────────────────────────────────
set clipboard=unnamed       " * primary, on select 
noremap <Leader>p "+p
noremap <Leader>y "+y
noremap <Leader>P "+P
noremap <Leader>Y "+Y

"────────────────────────────────────────────────────────────
" TOGGLE VE=BLOCK|ALL
"────────────────────────────────────────────────────────────
nnoremap <leader>a :call ToggleVE()<cr>
function! ToggleVE()
    if &ve ==# "all"
        " TODO add status bar notification / ECHO
        setlocal ve=block
    else
        " TODO add status bar notification / ECHO
        setlocal ve=all
    endif
endfunction



"m   0\bf"D045lp\b
