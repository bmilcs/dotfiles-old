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
" VS CODE 
"────────────────────────────────────────────────────────────
" new line = shift+enter
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
" shift lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


"────────────────────────────────────────────────────────────
" CLIPBOARD
"────────────────────────────────────────────────────────────
" logical replacement; copy from cursor > end of line
map Y y$

" copy/paste via system clipboard
vnoremap <leader>y "+y
nnoremap <leader>Y "+y$
nnoremap <leader>y "+y
"nnoremap <leader>yy "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

"────────────────────────────────────────────────────────────
" FIND/REPLACE ALL
"────────────────────────────────────────────────────────────
nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<left><left>

"────────────────────────────────────────────────────────────
" TOGGLE VE=BLOCK|ALL
"────────────────────────────────────────────────────────────
nnoremap <leader>v :call ToggleVE()<cr>
function! ToggleVE()
    if &ve ==# "all"
        " TODO add status bar notification / ECHO
        setlocal ve=block
    else
        " TODO add status bar notification / ECHO
        setlocal ve=all
    endif
endfunction


"────────────────────────────────────────────────────────────
" GIT SHORTCUTS LOWERCASE
"────────────────────────────────────────────────────────────
" source: https://www.reddit.com/r/vim/comments/90vy21/more_accessible_fugitive_commands/
for gcommand in ['Git', 'Gcd', 'Glcd', 'Gstatus', 'Gcommit', 'Gmerge', 'Gpull',
\ 'Grebase', 'Gpush', 'Gfetch', 'Grename', 'Gdelete', 'Gremove', 'Gblame', 'Gbrowse',
\ 'Ggrep', 'Glgrep', 'Glog', 'Gllog', 'Gedit', 'Gsplit', 'Gvsplit', 'Gtabedit', 'Gpedit',
\ 'Gread', 'Gwrite', 'Gwq', 'Gdiff', 'Gsdiff', 'Gvdiff', 'Gmove']
  exe 'cnoreabbrev g'.gcommand[1:].' '.gcommand
endfor


"m   0\bf"D045lp\b

"────────────────────────────────────────────────────────────
" CHEAT SHEET
"────────────────────────────────────────────────────────────

" mode 	              nmap
" insert              imap
" visual & select     vmap
" visual only 	      xmap
" command-line        cmap
" operator-pending    omap
" terminal            tmap
