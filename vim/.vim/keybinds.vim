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
" COC
"────────────────────────────────────────────────────────────

nnoremap <space>e :CocCommand explorer<CR>
let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'cocConfig': {
\      'root-uri': '~/.config/coc',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   },
\   'buffer': {
\     'sources': [{'name': 'buffer', 'expand': v:true}]
\   },
\ }

" Use preset argument to open it
nnoremap <space>ed :CocCommand explorer --preset .vim<CR>
nnoremap <space>ef :CocCommand explorer --preset floating<CR>
nnoremap <space>ec :CocCommand explorer --preset cocConfig<CR>
nnoremap <space>eb :CocCommand explorer --preset buffer<CR>

" List all presets
nnoremap <space>el :CocList explPresets


"────────────────────────────────────────────────────────────
" FILES
"────────────────────────────────────────────────────────────

" (w)rite (w)indow as sudo
nnoremap <leader>ww :execute ':silent w !sudo tee % > /dev/null' \| :edit!<CR>

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
"nnoremap <leader>r :%s/\<<C-r><C-w>\>//gc<left><left><left>
nnoremap <leader>r :%s///gc<left><left><left>
nnoremap <leader>R :%s///g<left><left>

" clear highlighted matches
nnoremap <leader>/ :nohlsearch<CR>

"────────────────────────────────────────────────────────────
" GIT
"────────────────────────────────────────────────────────────

" git push
nnoremap <silent> <leader>gp :Gpush<CR>

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
