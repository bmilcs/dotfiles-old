#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 ESXI ROOT PROFILE [./.profile]
#────────────────────────────────────────────────────────────
# ESXI FUNCTION & ALIASES 
# - bmilcs
#────────────────────────────────────────────────────────────

# esxi paths
alias hd='cd /vmfs/volumes/ESXI && l'
alias hdd='cd /vmfs/volumes/nvme && l'

# esxi scripts
alias bmv='. ~/bm/bmv'
alias bmthin='. ~/bm/bmthin'

#────────────────────────────────────────────────────────────
# ADAPTATIONS
#────────────────────────────────────────────────────────────

# verbose cp/mv
alias rM='rm -rfv'
alias mv='mv -v'
alias cp='cp -v'

# original
alias ali='vi ~/.profile'
alias zr='. ~/.profile'

# ls
alias l='ls'
alias ls='ls -AlhF --color=always '
alias ll='ls -AC'
alias lll='ls -l'
alias llll='ls -C'

alias lst="l -tr" 
alias lss="l -sr" 
alias lsd="l -d */"           # ls: dirs only

#────────────────────────────────────────────────────────────
# STOCK ENHANCEMENTS
#────────────────────────────────────────────────────────────

# text editors
alias nano="vim"
alias vim="vi"

# colorize
alias ip="ip -color=auto"

# autoresume
alias wget="wget -c"

# confirmations
alias ln="ln -i"

# shortcuts
alias c="clear"
alias ..="cd ..&& c && l"
alias ...="cd ../.. && c && l"

# print outs
alias a="alias | sed 's/=.*//'"
alias func="declare -f | grep '^[a-z].* ()' | sed 's/{$//'"
alias paths='echo -e ${PATH//:/\\n}'
alias hn="echo $HOST"

# pid
alias pid="cat /etc/passwd"
