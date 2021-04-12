autocmd BufNewFile,BufRead *.conf setfiletype dosini
autocmd BufNewFile,BufRead *rc setfiletype dosini

autocmd filetypedetect BufNewFile
  \ ?*/*.conf
  \,?*/*rc
  \,?*/config
  \ setfiletype dosini

" \ ?*/bin/?*
" \,?*/libexec/?*
" \,?*/scripts/?*
" \ if filereadable(expand('<afile>:p:h:h') . '/Makefile.PL')
" \|  setfiletype perl
" \|endif
