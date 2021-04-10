"
" colon_operator.vim: Select ranges and run colon commands on them, rather
" like the ! operator but for colon commands like :sort.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_colon_operator') || &compatible
  finish
endif
if v:version < 700
  finish
endif
let g:loaded_colon_operator = 1

" Set up mapping
nnoremap <expr> <silent> <unique>
      \ <Plug>(ColonOperator)
      \ colon_operator#Map()
