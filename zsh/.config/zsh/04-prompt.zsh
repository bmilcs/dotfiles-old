#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 ZSH PROMPT [./04-prompt.zsh]
#────────────────────────────────────────────────────────────
# dotfile rc file debugging
. ~/bin/sys/dotfile_logger
  dotlog '+ ~/.config/zsh/04-prompt.zsh'
#────────────────────────────────────────────────────────────
# original
# PROMPT="%B%K{blue}%F{black}   %M   %b%K{black}%F{blue}   %n   %k%b%F{blue}  %~   %W   %@  [%?] ${cyan}# %b%f%k"
#────────────────────────────────────────────────────────────
# precmd() {
#   LEFT="The time is"
#   RIGHT="$(date) "
#   RIGHTWIDTH=$(($COLUMNS-${#LEFT}))
#   print $LEFT${(l:$RIGHTWIDTH::.:)RIGHT}
# }
# PS1="%B%K{red}foo > "
# RPS1="%B%K{red}bar"
#────────────────────────────────────────────────────────────
 if [ -n "$SSH_CLIENT" ]; then
   PROMPT="%B%K{red}%F{black}   %M   "
 else
   PROMPT="%B%K{blue}%F{black}   %M   "
 fi
 
 PROMPT+="%k%b %F{blue}%~ [%?] "
 RPROMPT+=" %b%K{black}%F{blue}%n"
 # "$'\n'"
 
 
 PROMPT+=$'\n%b%k'
 PROMPT+="%F{cyan}# %b%f%k"
#────────────────────────────────────────────────────────────
#ERRCOL="%(?:%F{green}:%F{red})"
#() {
#    left="${ERRCOL}[%F%B%D{%H:%M:%S}%b${ERRCOL}]%f "
#    right="%F%D{%Y-%m-%d}%f"
#    local bare_left='[00:00:00] '
#    local bare_right='0000-00-00'
#    local middle_width=$((${COLUMNS}-1-${#bare_left}-${#bare_right}))
#    git_prompt_info=$(git_prompt_info)
#    middle=${(r:$middle_width:: :)git_prompt_info}
#    PROMPT='${left}${middle}${right}'
#    PROMPT+=$'\n : '
#}
