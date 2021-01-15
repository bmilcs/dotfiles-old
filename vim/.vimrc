"
" VIM BOOTSTRAP
" -bmilcs
"

for rcfile in split(globpath("~/.vim/rc", "*.vim"), '\n') 
    execute('source '.rcfile)
endfor


