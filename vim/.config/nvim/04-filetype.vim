"  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
"  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
"  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
"  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
"  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
"                 VIM FILETYPE SETTINGS [./04-filetype.vim]
"────────────────────────────────────────────────────────────
 
filetype off
syntax on
augroup filetypedetect


  " config files
  au BufRead,BufNewFile *.conf set filetype=config
  au BufRead,BufNewFile *rc set filetype=config

  " au BufRead,BufNewFile *.conf set filetype=dosini
" au BufRead,BufNewFile *rc set filetype=dosini

  " rasi (rofi)
  au BufRead,BufNewFile *.rasi set filetype=config

  " rsnapshot
  au BufRead,BufNewFile rsnapshot.conf set expandtab!     " convert \t to spaces

  " notes
  au BufRead,BufNewFile */txt/* set filetype=markdown
  au BufRead,BufNewFile */txt/* set syntax=markdown

  " scripts
  au BufRead,BufNewFile */bin/* set filetype=sh
  au BufRead,BufNewFile */bin/* set syntax=sh

  " i3 config
  au BufRead,BufNewFile */.config/i3/config set filetype=i3config
  au BufRead,BufNewFile */.config/i3/config set syntax=i3config

  " docker-compose
  au BufRead,BufNewFile *docker-compose* set filetype=docker-compose.yaml
  au BufRead,BufNewFile *.docker set filetype=docker-compose.yaml
  au BufRead,BufNewFile *docker-compose* set syntax=docker-compose.yaml
  au BufRead,BufNewFile *.docker set syntax=docker-compose.yaml

  " nginx
  au BufRead,BufNewFile *nginx* set filetype=nginx
  au BufRead,BufNewFile /etc/nginx/** set filetype=nginx

augroup END
filetype on

""─────────────────────────────────────────────────────────  theme swap  ───────
"
"" gruvbox
"function! Gruvbox() abort
"  colorscheme gruvbox 
"  let g:gruvbox_contrast_dark = 'soft'
"endfunction
"
"" nord 
"function! Nord() abort
"  colorscheme nord
"endfunction
"
"" dracula
"function! Dracula() abort
"  colorscheme dracula
"endfunction
"
"command Gruvbox call Gruvbox()
"command Nord call Nord()
"command Dracula call Dracula()
