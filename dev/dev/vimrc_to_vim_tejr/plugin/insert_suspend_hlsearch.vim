"
" insert_suspend_hlsearch.vim: If 'hlsearch' is enabled, switch it off when
" the user starts an insert mode operation, and back on again when they're
" done.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_insert_suspend_hlsearch') || &compatible
  finish
endif
if !has('autocmd') || !has('extra_search') || v:version < 700
  finish
endif
let g:loaded_insert_suspend_hlsearch = 1

" Initialise option saving variable
let s:hlsearch_save = &hlsearch

" Save the current value of the 'hlsearch' option in a script variable, and
" disable it if enabled. Note that :nohlsearch does not work for this; see
" :help autocmd-searchpat.
function! s:Suspend() abort
  let s:hlsearch_save = &hlsearch
  if &hlsearch
    set nohlsearch
  endif
endfunction

" Restore the value of 'hlsearch' from the last time s:HlsearchSuspend was
" called.
function! s:Restore() abort
  if !&hlsearch && s:hlsearch_save
    set hlsearch
  endif
endfunction

" Clear search highlighting as soon as I enter insert mode, and restore it
" once left
augroup insert_suspend_hlsearch
  autocmd!
  autocmd InsertEnter * call s:Suspend()
  autocmd InsertLeave * call s:Restore()
augroup END
