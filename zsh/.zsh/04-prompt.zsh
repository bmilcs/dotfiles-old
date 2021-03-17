#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 ZSH PROMPT [./04-prompt.zsh]
#────────────────────────────────────────────────────────────
# original
# PROMPT="%B%K{blue}%F{black}   %M   %b%K{black}%F{blue}   %n   %k%b%F{blue}  %~   %W   %@  [%?] ${cyan}# %b%f%k"
#────────────────────────────────────────────────────────────

 precmd() {
   LEFT="The time is"
   RIGHT="$(date) "
   RIGHTWIDTH=$(($COLUMNS-${#LEFT}))
   print $LEFT${(l:$RIGHTWIDTH::.:)RIGHT}
 }
# PS1="%B%K{red}foo > "
# RPS1="%B%K{red}bar"

if [ -n "$SSH_CLIENT" ]; then
  PROMPT="%B%K{red}%F{black}   %M   "
else
  PROMPT="%B%K{blue}%F{black}   %M   "
fi

RPROMPT+="%b%K{black}%F{blue}%n"
PROMPT+="%k%b%F{blue}%~ [%?] "
# "$'\n'"


PROMPT+=$'\n%b%k'
PROMPT+="%F{cyan}# %b%f%k"

