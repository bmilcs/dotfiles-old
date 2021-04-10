"
" cmdwin_ctrlc.vim: Arrange for Ctrl-C to close the command window and put the
" current line on a new command line of the appropriate type, with the cursor
" at the end.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_cmdwin_ctrlc') || &compatible
  finish
endif
if !has('autocmd') || v:version < 700
  finish
endif
let g:loaded_cmdwin_ctrlc = 1

" Map Ctrl-C to close the command window and put the current line on a new
" command line of the appropriate type, with the cursor at the end.
function! s:Map(mode) abort
  let b:cmdwin_ctrlc_mode = a:mode
  nnoremap <buffer> <expr> <C-C> ":quit\<CR>:redraw\<CR>"
        \.b:cmdwin_ctrlc_mode.getline('.')
endfunction

" Set up hooks
augroup cmdwin_ctrlc
  autocmd!
  autocmd CmdWinEnter :,/,\?
        \ call s:Map(expand('<afile>'))
augroup END
