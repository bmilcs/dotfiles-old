"  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
"  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
"  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
"  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
"  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
"                 VIM CUSTOM KEYBINDS [./03-keybinds.vim]

" TODO  - format/move comments to column #45
"       - fzf shortcuts, project files, ripgrep project dir

"───────────────────────────────────────────────────────────────  tabs  ───────

nnoremap <leader>os  :tabedit         ~/.config/nvim/snips/all.snippets<CR>
nnoremap <leader>oc  :tabedit         ~/.config/nvim/00-general.vim<CR>
nnoremap <leader>opp :tabedit         ~/.config/nvim/01-plugins.vim<CR>
nnoremap <leader>ops :tabedit         ~/.config/nvim/02-plugin-settings.vim<CR>
nnoremap <leader>ok  :tabedit         ~/.config/nvim/03-keybinds.vim<CR>
nnoremap <leader>of  :tabedit         ~/.config/nvim/04-filetype.vim<CR>

" tab navigation
nnoremap <C-S-k> :tabprevious<CR>
nnoremap <C-S-j> :tabnext<CR>
nnoremap <C-S-n> :tabnew<CR>
nnoremap <C-S-e> :Explore<CR>
"nnoremap <silent> <C-Tab>   :tabprevious<CR>
"nnoremap <silent> <C-S-Tab> :tabnext<CR>

" vertical (s)plit > explore
nnoremap <silent> <leader>we :tabe<CR>:Explore<CR>


nnoremap <leader>up  :PlugUpdate<CR>
nnoremap <leader>ip  :PlugInstall<CR>
nnoremap <leader>cp  :PlugClean<CR>

"────────────────────────────────────────────────────────────────  fzf  ───────

nnoremap <silent> <C-p> :tabnew \| Files!<CR>
nnoremap <silent> <C-S-p> :tabnew \| ProjectFiles!<CR>
nnoremap <silent> <C-f> :Rg!<CR>
nnoremap <silent> <C-g> :RipgrepFzf!<CR>

command! -bang -nargs=? -complete=dir ProjectFiles
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline']}, <bang>0)
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

"──────────────────────────────────────────────────  text manipulation   ──────

nnoremap <silent> <leader>dd :%s/^\(.*\)\(\n\1\)\+$/\1/
nnoremap <silent> <leader>q ciW"<c-R>""<esc>


" title bars
nnoremap <silent> <leader>tr :center 80<cr>hhv0r#A<space><esc>40A#<esc>d80<bar>YppVr#kk.
nnoremap <silent> <leader>tt :right 70<cr>3hv0lr─0r#A<space><space><esc>40A─<esc>d79<bar>
nnoremap <silent> <leader>ty :right 70<cr>3hv0lr─0r#A<space><space><esc>40A─<esc>d79<bar>0YpVr─0r#A<esc>Ykkp0
nnoremap <silent> <leader>tu g$dF x0df x
nnoremap <silent> <leader>tb :%s/^\(#\<bar>"\<bar>;\)$/\1──────────────────────────────────────────────────────────────────────────────/g<CR>

" visual: sort, column
vmap <silent> <leader>ss :'<,'>sort<CR>
vmap <silent> <leader>cc :'<,'>!column -t -o " "<CR>

" delete double+ blank lines: 
nnoremap <leader>ds :%s/^\(\s\+\)\?$\n^\(\s\+\)\?$//g<CR><C-o>

" delete blank lines: all
nnoremap <leader>dS :%s/^\(\s\+\)\?$\n//g<CR><C-o>

" find/replace all (from line #1)
nnoremap <leader>r :%s///gc<left><left><left>
" find/replace all (from current line to last)
nnoremap <leader>R :.,$s///gc<left><left><left>

" search literally
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" clear highlighted matches
nnoremap <leader>/ :nohlsearch<CR>

" replay last macro
nnoremap , @
nnoremap ,, @@
nnoremap <leader>, @@

" convert link to markdown
nnoremap <leader>l   0Di[]()^[P^[F]i^[

"───────────────────────────────────────────────────  markdown preview  ───────

nmap <leader>mp <Plug>MarkdownPreviewToggle

"──────────────────────────────────────────────────────────────  files  ───────

" (w)rite (w)indow as sudo
fun! SudoW()
  silent write !sudo tee % > /dev/null
  edit!
  echo "sudo: written"
endfun

nnoremap <leader>ww :call SudoW()<CR>
"nnoremap <silent> <leader>ww :silent execute ':w !sudo tee % > /dev/null' \| :edit!<CR>

" reload vimrc config
nnoremap <silent> <leader>` :source ~/.vimrc \| echo "vimrc: reloaded"<CR>

" (r)eload (w)indow (document)
nnoremap <silent> <leader>wr :e!<CR>

" expand (e)rror (m)essages
nnoremap <silent> <leader>mm :messages<CR>

" (q)uit current (w)indow
nnoremap <silent> <leader>wq :close<CR>

" vertical (s)plit > explore
nnoremap <silent> <leader>ws :Vexplore<CR>

nnoremap <silent> <leader>ss :Vsplit<CR>

" vertical (s)plit
" horizontal (S)plit > explore
nnoremap <silent> <leader>WS :Split<CR>

" horizontal (S)plit
nnoremap <silent> <leader>SS :Split<CR>

"────────────────────────────────────────────────────────────────  coc  ───────

" update CoC
nnoremap <leader>cu :CocUpdate<CR>

" show marketplace
nnoremap <leader>ci :CocList marketplace<CR>

nmap <silent> <leader>K <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>J <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>cr <Plug>(coc-references)
nmap <silent> <leader>co :<C-u>CocListResume<CR>

" "────────────────────────────────────────────────────────────────  GIT   ──────
" 
" " git diff split
" nnoremap <silent> <leader>gd :Gdiffsplit<CR>
" 
" " git status
" " nnoremap <silent> <leader>gs :Gstatus<CR>
" 
" " open vimagit pane (git status)
" nnoremap <silent> <leader>gs :Magit<CR>
" 
" " allow magit to del untracked files
" " let g:magit_discard_untracked_do_delete=1
" 
" " highlight changed lines
nnoremap <silent> <leader>gg :GitGutterLineHighlightsToggle<CR>
" 
" " navigate next/prev git hunk
nmap <silent> <Leader>j <Plug>(GitGutterNextHunk)
nmap <silent> <Leader>k <Plug>(GitGutterPrevHunk)
" 
" " git push  remote
" nnoremap <leader>gP :! git push<CR>
" 
" " show commits for all source lines
" nnoremap <Leader>gb :gq<CR>
" 
" " open current line in the browser
" nnoremap <Leader>gb :.Gbrowse<CR>
" 
" " open visual selection in the browser
" vnoremap <Leader>gb :Gbrowse<CR>
" 
" " add the entire file to the staging area
" nnoremap <Leader>gaf :Gw<CR>

"─────────────────────────────────────────────────────────────  VISUAL    ─────

" retain visual block after issuing command
nmap Y y$
vmap < <gv
vmap > >gv

"────────────────────────────────────────────────────────  STOCK REMAP  ──────"

" remove shift requirement for issuing cmds
map     ;     :
noremap ;;    ;
noremap H     ^
noremap L     $

" logical replacement; copy from cursor > end of line
map Y y$

"────────────────────────────────────────────────────────────  VS CODE  ──────"

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

"───────────────────────────────────────────────────  SYSTEM CLIPBOARD  ──────"

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

"────────────────────────────────────────────────  TOGGLE VE=BLOCK|ALL  ──────"

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

"─────────────────────────────────────────────────────────  WHITESPACE  ──────"

" Removes trailing spaces
 function TrimWhiteSpace()
   %s/\s*$//
   ''
 endfunction

"autocmd FileWritePre * call TrimWhiteSpace()
"autocmd FileAppendPre * call TrimWhiteSpace()
"autocmd FilterWritePre * call TrimWhiteSpace()
"autocmd BufWritePre * call TrimWhiteSpace()

map <F2> <silent> :call TrimWhiteSpace()<CR>
map! <F2> <silent> :call TrimWhiteSpace()<CR>

noremap <F3> :set list!<CR>
inoremap <F3> <C-o>:set list!<CR>
cnoremap <F3> <C-c>:set list!<CR>

"─────────────────────────────────────────────────────────  CHEATSHEET  ──────"

" normal mode         nmap
" insert              imap
" visual & select     vmap
" visual only         xmap
" command-line        cmap
" operator-pending    omap
" terminal            tmap
" <silent>            hide command in statusline

