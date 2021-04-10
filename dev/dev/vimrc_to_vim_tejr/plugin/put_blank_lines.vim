"
" put_blank_lines.vim: Provide plugin maps to put blank lines above or below
" the current line.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_put_blank_lines') || &compatible
  finish
endif
if v:version < 700
  finish
endif
let g:loaded_put_blank_lines = 1

" Set up mappings to autoloaded functions
nnoremap <expr> <silent> <unique>
      \ <Plug>(PutBlankLinesBelow)
      \ put_blank_lines#Below()
nnoremap <expr> <silent> <unique>
      \ <Plug>(PutBlankLinesAbove)
      \ put_blank_lines#Above()
