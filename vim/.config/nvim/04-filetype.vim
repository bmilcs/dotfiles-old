"  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
"  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
"  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
"  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
"  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
"                 VIM FILETYPE SETTINGS [./04-filetype.vim]
"────────────────────────────────────────────────────────────
"
filetype off
syntax on
augroup filetypedetect

  " config files
  au BufRead,BufNewFile *.conf set filetype=dosini
  au BufRead,BufNewFile *rc set filetype=dosini

  " notes
  au BufRead,BufNewFile */txt/* set filetype=markdown
  au BufRead,BufNewFile */txt/* set syntax=markdown

  " scripts
  au BufRead,BufNewFile */bin/* set filetype=sh
  au BufRead,BufNewFile */bin/* set syntax=sh

  " i3 config
  au BufRead,BufNewFile */.config/i3/config set filetype=i3config
  au BufRead,BufNewFile */.config/i3/config set syntax=i3config

augroup END
filetype on

