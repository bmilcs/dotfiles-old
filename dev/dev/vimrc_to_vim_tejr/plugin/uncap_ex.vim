"
" uncap_ex.vim: Tolerate typos like :Wq, :Q, or :Qa and do what I mean,
" including any arguments or modifiers; I fat-finger these commands a lot
" because I type them so rapidly, and they don't correspond to any other
" commands I use
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_uncap_ex') || &compatible
  finish
endif
if !has('user_commands') || v:version < 600
  finish
endif
let g:loaded_uncap_ex = 1

" Define commands
command -bang -bar -complete=file -nargs=?
      \ E
      \ edit<bang> <args>
command -bang -bar -complete=file -nargs=?
      \ W
      \ write<bang> <args>
command -bang -bar -complete=file -nargs=?
      \ WQ
      \ wq<bang> <args>
command -bang -bar -complete=file -nargs=?
      \ Wq
      \ wq<bang> <args>
command -bang -bar
      \ Q
      \ quit<bang>
command -bang -bar
      \ Qa
      \ qall<bang>
command -bang -bar
      \ QA
      \ qall<bang>
command -bang -bar
      \ Wa
      \ wall<bang>
command -bang -bar
      \ WA
      \ wa<bang>
