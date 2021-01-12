"
" VIM BOOTSTRAP
" -bmilcs
"

let wild = [ "*" ]
for name in wild
  let cfg = expand("~/.vim/".name.".vim")
  if filereadable(cfg)
    execute 'source' cfg
  endif
endfor
