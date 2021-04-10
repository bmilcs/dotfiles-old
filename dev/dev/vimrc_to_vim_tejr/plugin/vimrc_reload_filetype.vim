"
" vimrc_reload_filetype.vim: Add hook to reload active buffer's filetype when
" vimrc reloaded, so that we don't end up indenting four spaces in an open
" VimL file, etc. Requires Vim 7.1 or 7.0 with patch 187 for SourceCmd.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_vimrc_reload_filetype') || &compatible
  finish
endif
if !has('autocmd') || !exists('##SourceCmd')
  finish
endif
let g:loaded_vimrc_reload_filetype = 1

" Wrapper function reloads .vimrc and filetypes
function! s:Reload() abort
  source <afile>
  if exists('#filetypedetect#BufRead')
    doautocmd filetypedetect BufRead
  endif
  redraw
  echomsg 'Reloaded vimrc: '.expand('<afile>')
endfunction

" This SourceCmd intercepts :source for .vimrc
augroup vimrc_reload_filetype
  autocmd!
  autocmd SourceCmd $MYVIMRC call s:Reload()
augroup END
