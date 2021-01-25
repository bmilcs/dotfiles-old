"  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
"  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
"  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
"  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
"  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
"────────────────────────────────────────────────────────────
"   VIM CUSTOM SHORTCUTS
"────────────────────────────────────────────────────────────
"────────────────────────────────────────────────────────────
" TODO    Add leader shortcuts:
"         - delete double spaces
"         - format/move comments to column #45
"         - improve fzf shortcuts, for project files, within
"           files, etc.
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
"────────────────────────────────────────────────────────────
" <silent>            no command shown in statusline

"────────────────────────────────────────────────────────────
" FILES
"────────────────────────────────────────────────────────────

" (s)ource vimrc config
nnoremap <silent> <leader>` :source ~/.vimrc<CR>

" expand error (m)essages
nnoremap <silent> <leader>wm :messages<CR>

" (r)eload file
nnoremap <silent> <leader>wr :e!<CR>

" (q)uit current file
nnoremap <silent> <leader>wq :close<CR>

" vertical (s)plit > explore
nnoremap <silent> <leader>ws :Vexplore<CR>

" horizontal (S)plit > explore
nnoremap <silent> <leader>wS :Sexplore<CR>

"────────────────────────────────────────────────────────────
" TEXT MANIPULATION
"────────────────────────────────────────────────────────────

" (d)elete double white(s)pace lines
nnoremap <silent> <leader>ds :%s/^$\n^$//g<CR>

" (d)elete all white(s)pace lines
nnoremap <silent> <leader>dS :%s/^$\n//g<CR>

" patented titlebar swap
nnoremap <silent> <leader>tb :%s/^\(#\<bar>"\<bar>;\)$/\1────────────────────────────────────────────────────────────/g<CR>

" find/replace all
nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<left><left>

" clear highlighted matches
nnoremap <leader>/ :nohlsearch<CR>

"────────────────────────────────────────────────────────────
" GIT
"────────────────────────────────────────────────────────────

" git diff split
nnoremap <silent> <leader>gd :Gdiffsplit<CR>

" git status
nnoremap <silent> <leader>gs :Gstatus<CR>

"────────────────────────────────────────────────────────────
" VISUAL
"────────────────────────────────────────────────────────────

" retain visual block after issuing command
nmap Y y$
vmap < <gv
vmap > >gv

"────────────────────────────────────────────────────────────
" STOCK REMAP
"────────────────────────────────────────────────────────────

" remove shift requirement for issuing cmds
nnoremap ; :
nnoremap : ;

" logical replacement; copy from cursor > end of line
map Y y$

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
" SYSTEM CLIPBOARD
"────────────────────────────────────────────────────────────

" yank to system clipboard (copy)
vnoremap <leader>y "+y
nnoremap <leader>Y "+y$
nnoremap <leader>y "+y

" put from system clipboard (paste)
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

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
" https://www.hillelwayne.com/post/intermediate-vim/
