#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#────────────────────────────────────────────────────────────
#   bashrc
#────────────────────────────────────────────────────────────

# W/O INTERACTION > DO NOTHING
[[ $- != *i* ]] && return

# PROMPT
PS1='[\u@\h \W]\$ '

# ALIASES
alias ls='ls --color=auto'

#
# FZF
#

if [[ ! "$PATH" == */home/bmilcs/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/bmilcs/.fzf/bin"
fi
[[ $- == *i* ]] && source "/home/bmilcs/.fzf/shell/completion.bash" 2> /dev/null

source "/home/bmilcs/.fzf/shell/key-bindings.bash"

if [ $(id -u) -eq 0 ];then # ROOT
  PS1="\[\e[1;30;41m\]    \[\e[1m\]\H  \[\e[m\]\[\e[0;31;40m\]  \u      \[\e[m\]\[\e[1;30m\] \d | \@ | \# | \[\e[34m\]\w\[\e[1;30m\] | \[\e[30m\] \[\e[m\]\n\[\e[1;31m\]#\[\e[m\] "
else 
  PS1="\[\e[1;30;44m\]    \[\e[1m\]\H  \[\e[m\]\[\e[0;34;40m\]  \u      \[\e[m\]\[\e[1;30m\] \d | \@ | \# | \[\e[34m\]\w\[\e[1;30m\] | \[\e[30m\] \[\e[m\]\n\[\e[1;34m\]#\[\e[m\] "
fi

#export PS1='\[\e[1;32m\u\]\[\e[0;37m\].\[\e[1;34m\]\h \[\e[0;33m\w\]\[\e[33m\]\[\e[1m\]\[\e[0m\]\n $ '
#export PS1="\[\e[39;41m\]  \[\e[1m\]\H  \[\e[m\] \[\e[30;103m\]  \u  \[\e[m\] \[\e[33m\] \"\w\" \[\e[m\]\n\[\e[31m\]\$\[\e[m\] "
