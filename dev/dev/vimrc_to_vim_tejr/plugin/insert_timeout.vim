"
" insert_timeout.vim: Leave insert mode automatically if there is no activity
" for a certain number of seconds, with an 'updatetime' hook. This is just a
" plugin packaging of Vim tip #1540.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_insert_timeout') || &compatible
  finish
endif
if !has('autocmd') || v:version < 700
  finish
endif
let g:loaded_insert_timeout = 1

" Initialise 'updatetime' caching variable
let s:updatetime_save = &updatetime

" Set update time to configured variable or default 20 seconds
function! s:SetUpdatetime() abort
  let s:updatetime_save = &updatetime
  let &updatetime = get(g:, 'insert_timeout_duration', 20000)
endfunction

" Restore update time to globally configured variable
function! s:RestoreUpdatetime() abort
  let &updatetime = s:updatetime_save
endfunction

" Set up actions in a group
augroup insert_timeout
  autocmd!
  autocmd InsertEnter * call s:SetUpdatetime()
  autocmd InsertLeave * call s:RestoreUpdatetime()
  autocmd CursorHoldI * stopinsert
augroup END
