"
" replace_operator.vim: Replace text selected with a motion with the
" contents of a register in a repeatable way.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_replace_operator') || &compatible
  finish
endif
if v:version < 700
  finish
endif
let g:loaded_replace_operator = 1

" Set up mapping
nnoremap <silent> <unique>
      \ <Plug>(ReplaceOperator)
      \ :<C-U>call replace_operator#MapNormal(v:register)<CR>g@
xnoremap <silent> <unique>
      \ <Plug>(ReplaceOperator)
      \ :<C-U>call replace_operator#MapVisual(v:register, visualmode())<CR>
