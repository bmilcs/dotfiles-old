"
" squeeze_repeat_blanks.vim: User command to reduce all groups of blank lines
" to the last line in that group, deleting the others. Good for filtering
" plaintext mail that's been extracted from HTML.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_squeeze_repeat_blanks') || &compatible
  finish
endif
if !has('user_commands') || v:version < 700
  finish
endif
let g:loaded_squeeze_repeat_blanks = 1

" User command for the above
command! -range=% SqueezeRepeatBlanks
      \ call squeeze_repeat_blanks#Squeeze(<line1>, <line2>)
