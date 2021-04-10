"
" vertical_region.vim: Mapping targets to move up or down to lines that have
" non-space characters before or in the current column, usually to find lines
" that begin or end blocks in languages where indenting is used to show or
" specify structure.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_vertical_region') || &compatible
  finish
endif
if v:version < 700
  finish
endif
let g:loaded_vertical_region = 1

" Define plugin maps
nnoremap <silent> <Plug>(VerticalRegionUpNormal)
      \ :<C-U>call vertical_region#Map(v:count1, 1, 'n')<CR>
nnoremap <silent> <Plug>(VerticalRegionDownNormal)
      \ :<C-U>call vertical_region#Map(v:count1, 0, 'n')<CR>
onoremap <silent> <Plug>(VerticalRegionUpOperator)
      \ :<C-U>call vertical_region#Map(v:count1, 1, 'o')<CR>
onoremap <silent> <Plug>(VerticalRegionDownOperator)
      \ :<C-U>call vertical_region#Map(v:count1, 0, 'o')<CR>
xnoremap <silent> <Plug>(VerticalRegionUpVisual)
      \ :<C-U>call vertical_region#Map(v:count1, 1, 'x')<CR>
xnoremap <silent> <Plug>(VerticalRegionDownVisual)
      \ :<C-U>call vertical_region#Map(v:count1, 0, 'x')<CR>
