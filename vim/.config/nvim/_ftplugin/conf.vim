autocmd BufNewFile,BufRead *.conf setfiletype dosini
autocmd BufNewFile,BufRead *rc setfiletype dosini

autocmd filetypedetect BufNewFile
  \ ?*/*.conf
  \,?*/*rc
  \,?*/config
  \ setfiletype dosini
