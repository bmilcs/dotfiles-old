"
" VIM BOOTSTRAP
" -bmilcs
"

for rcfile in split(globpath("~/.vim/rc", "*.vim"), '\n') 
    execute('source '.rcfile)
endfor

" for cfg (~/.vim/*.vim); do execute 'source' $cfg; done

"	for name in *
"	  let cfg = expand("~/.vim/".name.".vim")
"	  if filereadable(cfg)
"	    execute 'source' cfg
"	  endif
"	endfor
