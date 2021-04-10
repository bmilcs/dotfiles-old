"
" insert_cancel.vim: Cancel the current insert operation by undoing the last
" change upon insert exit, if we made a change; intended for remapping
" insert-mode Ctrl-C to do something useful.
"
" This was *way* harder to figure out than it looks.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_insert_cancel') || &compatible
  finish
endif
if v:version < 600
  finish
endif
let g:loaded_insert_cancel = 1

" On leaving insert mode, whether normally or via <Plug>(InsertCancel), check
" if changenr() exceeds the last time we cached it, and flag that a change has
" taken place if it did
function! s:Check()
  if changenr() > b:insert_cancel_changenr
    let b:insert_cancel_changed = 1
  endif
endfunction

" On entering insert mode, reset the changed flag and check for a new round of
" changes since insert mode was opened
function! s:Enter()
  let b:insert_cancel_changed = 0
  call s:Check()
endfunction

" On cancelling insert mode, if we think we made a change, undo it
function! s:Cancel()

  " The flag exists, if it's on, undo
  if exists('b:insert_cancel_changed')
    if b:insert_cancel_changed
      silent undo
    endif

  " The flag didn't exist, fall back to marks; if the line number or column
  " number of the marks for the last changed text aren't exactly equal, that
  " suggests we changed something; undo it
  elseif line("'[") != line("']") || col("'[") != col("']")
    silent undo
  endif

endfunction

" Set up the hooks described for the functions above, if Vim is new enough to
" support all the hooks required
if has('autocmd') && v:version >= 700
  augroup insert_cancel
    autocmd!

    " On buffer edit and cursor move, cache the current change number
    autocmd BufEnter,CursorMoved *
          \ let b:insert_cancel_changenr = changenr()

    " Function wrappers for entering and leaving insert mode
    autocmd InsertEnter * call s:Enter()
    autocmd InsertLeave * call s:Check()

  augroup END
endif

" Mapping that exits insert mode normally and checks for a change to undo
inoremap <silent> <Plug>(InsertCancel)
      \ <Esc>:<C-U>call <SID>Cancel()<CR>
