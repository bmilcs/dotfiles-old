"
" copy_linebreak.vim: Bind user-defined key sequences to toggle a group of
" options that make text wrapped with 'wrap' copy-paste friendly.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_copy_linebreak') || &compatible
  finish
endif
if !has('linebreak') || v:version < 600
  finish
endif
let g:loaded_copy_linebreak = 1

" Enable copy-friendly linebreak options
function! s:CopyLinebreakEnable()
  setlocal nolinebreak linebreak?
  let s:showbreak_save = &showbreak
  set showbreak=
  if exists('+breakindent')
    setlocal nobreakindent
  endif
endfunction

" Disable copy-friendly linebreak options
function! s:CopyLinebreakDisable()
  setlocal linebreak linebreak?
  if exists('s:showbreak_save')
    let &showbreak = s:showbreak_save
    unlet s:showbreak_save
  endif
  if exists('+breakindent')
    setlocal breakindent<
  endif
endfunction

" Toggle copy-friendly linebreak options, using the current setting for the
" 'linebreak' option as the pivot
function! s:CopyLinebreakToggle()
  if &linebreak
    call s:CopyLinebreakEnable()
  else
    call s:CopyLinebreakDisable()
  endif
endfunction

" Provide mappings to the functions just defined
noremap <silent>
      \ <Plug>(CopyLinebreakEnable)
      \ :<C-U>call <SID>CopyLinebreakEnable()<CR>
noremap <silent>
      \ <Plug>(CopyLinebreakDisable)
      \ :<C-U>call <SID>CopyLinebreakDisable()<CR>
noremap <silent>
      \ <Plug>(CopyLinebreakToggle)
      \ :<C-U>call <SID>CopyLinebreakToggle()<CR>
