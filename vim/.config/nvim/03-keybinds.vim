"  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
"  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
"  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
"  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
"  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
"                 VIM CUSTOM KEYBINDS [./03-keybinds.vim]
" TODO  - format/move comments to column #45
"       - fzf shortcuts, project files, ripgrep project dir
"────────────────────────────────────────────────────────────
" FILE SHORTCUTS
"────────────────────────────────────────────────────────────
nnoremap <leader>os :tabedit ~/.config/nvim/snips/all.snippets<CR>
nnoremap <leader>op :tabedit ~/.config/nvim/01-plugins.vim<CR>
nnoremap <leader>opp :tabedit ~/.config/nvim/01-plugins.vim<CR>
nnoremap <leader>ops :tabedit ~/.config/nvim/02-plugin-settings.vim<CR>
nnoremap <leader>ok :tabedit ~/.config/nvim/03-keybinds.vim<CR>
nnoremap <leader>of :tabedit ~/.config/nvim/04-filetype.vim<CR>
nnoremap <leader>pu :PlugUpdate<CR>
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>ps :PlugStatus<CR>
nnoremap <leader>pc :PlugClean<CR>
"────────────────────────────────────────────────────────────
" WHITESPACE
"────────────────────────────────────────────────────────────
" Removes trailing spaces
 function TrimWhiteSpace()
   %s/\s*$//
   ''
 endfunction
" autocmd FileWritePre * call TrimWhiteSpace()
" autocmd FileAppendPre * call TrimWhiteSpace()
" autocmd FilterWritePre * call TrimWhiteSpace()
" autocmd BufWritePre * call TrimWhiteSpace()

map <F2> :call TrimWhiteSpace()<CR>
map! <F2> :call TrimWhiteSpace()<CR>

noremap <F3> :set list!<CR>
inoremap <F3> <C-o>:set list!<CR>
cnoremap <F3> <C-c>:set list!<CR>

"────────────────────────────────────────────────────────────
" VIMSPECTOR
"────────────────────────────────────────────────────────────
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

"────────────────────────────────────────────────────────────
" COC
"────────────────────────────────────────────────────────────
" update CoC
nnoremap <leader>cu :CocUpdate<CR>
" show marketplace
nnoremap <leader>ci :CocList marketplace<CR>

nmap <silent> <leader>k <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>j <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>cr <Plug>(coc-references)
nmap <silent> <leader>co :<C-u>CocListResume<CR>

"────────────────────────────────────────────────────────────
" FILES
"────────────────────────────────────────────────────────────

" (w)rite (w)indow as sudo
nnoremap <silent> <leader>ww :silent execute ':w !sudo tee % > /dev/null' \| :edit!<CR>

" reload vimrc config
nnoremap <silent> <leader>` :source ~/.vimrc<CR>

" expand (e)rror (m)essages
nnoremap <silent> <leader>em :messages<CR>

" (r)eload (w)indow (document)
nnoremap <silent> <leader>wr :e!<CR>

" (q)uit current (w)indow
nnoremap <silent> <leader>wq :close<CR>

" tab navigation
nnoremap <silent> <C-j> :tabprevious<CR>
nnoremap <silent> <C-k> :tabnext<CR>

" vertical (s)plit > explore
nnoremap <silent> <leader>we :tabe<CR>:Explore<CR>

" vertical (s)plit > explore
nnoremap <silent> <leader>ws :Vexplore<CR>

" vertical (s)plit
nnoremap <silent> <leader>ss :Vsplit<CR>

" horizontal (S)plit > explore
nnoremap <silent> <leader>WS :Split<CR>

" horizontal (S)plit
nnoremap <silent> <leader>SS :Split<CR>

"────────────────────────────────────────────────────────────
" TEXT MANIPULATION
"────────────────────────────────────────────────────────────

" title bar test
nnoremap <silent> <leader>tT :center 80<cr>hhv0r#A<space><esc>40A#<esc>d80<bar>YppVr#kk.
nnoremap <silent> <leader>tt :right 70<cr>3hv0lr─0r#A<space><space><esc>40A─<esc>d79<bar>r#0
nnoremap <silent> <leader>ty :right 70<cr>3hv0lr─0r#A<space><space><esc>40A─<esc>d79<bar>r#0YpVr─0r#A<esc>r#Ykkp0

" sort paragraph
nnoremap <silent> <leader>1 :'{,'}sort<CR>

" (d)elete double white(s)pace lines
nnoremap <silent> <leader>ds :%s/^$\n^$//g<CR><C-o>

" (d)elete all white(s)pace lines
nnoremap <silent> <leader>dS :%s/^$\n//g<CR><C-o>

" patented titlebar swap
nnoremap <silent> <leader>tb :%s/^\(#\<bar>"\<bar>;\)$/\1────────────────────────────────────────────────────────────/g<CR>

" find/replace all
nnoremap <leader>r :%s///gc<left><left><left>
nnoremap <leader>R :%s///g<left><left>

" search literally
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" clear highlighted matches
nnoremap <leader>/ :nohlsearch<CR>

" surround selection: ()
" xnoremap <leader>( c()<Esc>P

" replay last macro
nnoremap , @
nnoremap ,, @@
nnoremap <leader>, @@

" convert link to markdown
nnoremap <leader>l   0Di[]()^[P^[F]i^[

"────────────────────────────────────────────────────────────
" GIT
"────────────────────────────────────────────────────────────

" git diff split
nnoremap <silent> <leader>gd :Gdiffsplit<CR>

" git status
" nnoremap <silent> <leader>gs :Gstatus<CR>

" open vimagit pane (git status)
nnoremap <silent> <leader>gs :Magit<CR>

" allow magit to del untracked files
" let g:magit_discard_untracked_do_delete=1

" highlight changed lines
nnoremap <silent> <leader>gh :GitGutterLineHighlightsToggle<CR>

" navigate next/prev git hunk
nmap <silent> <Leader>j <Plug>(GitGutterNextHunk)
nmap <silent> <Leader>k <Plug>(GitGutterPrevHunk)

" git push  remote
nnoremap <leader>gP :! git push<CR>

" show commits for all source lines
nnoremap <Leader>gb :gq<CR>

" open current line in the browser
nnoremap <Leader>gb :.Gbrowse<CR>

" open visual selection in the browser
vnoremap <Leader>gb :Gbrowse<CR>

" add the entire file to the staging area
nnoremap <Leader>gaf :Gw<CR>

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
map ; :
noremap ;; ;

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

" delete to system clipboard (cut)
vnoremap <leader>d "+d
nnoremap <leader>D "+d$
nnoremap <leader>d "+d

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

" https://www.hillelwayne.com/post/intermediate-vim/
"────────────────────────────────────────────────────────────
" CHEATSHEET
"────────────────────────────────────────────────────────────
" normal mode         nmap
" insert              imap
" visual & select     vmap
" visual only         xmap
" command-line        cmap
" operator-pending    omap
" terminal            tmap
" <silent>            hide command in statusline

