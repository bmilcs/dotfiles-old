#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 ZSH PROMPT [./04-prompt.zsh]

# dotfile rc file debugging
. ~/bin/sys/dotfile_logger
  dotlog '+ $ZDOTDIR/04-prompt.zsh'
user="yellow"
# initialize
PROMPT=""
RPROMPT=""

# core
#PROMPT+="%K{blue}"
PROMPT+="%F{blue}"
PROMPT+=" %~ "

# user-based 
[[ ! $USER == bmilcs ]]  \
&&  PROMPT+="%n"        \
#&&  PROMPT+="%F{blue}"  \


[[ ! $USER == bmilcs ]] && \
[[ -n "$SSH_CLIENT" ]]     \
&& PROMPT+="@"
#&& PROMPT+="%F{black}"     \

# ssh clients
[[ -n "$SSH_CLIENT" ]]   \
&&  PROMPT+="%M"
#&&  PROMPT+="%B" \
#&&  PROMPT+="%F{blue}" \

# operating system
[[ ! "$DISTRO" == "arch"* ]]   \
&&  RPROMPT+="%F{blue}"        \
&&  RPROMPT+="${DISTRO}"

prompt fade blue

#────────────────────────────────────────────────────────────
# GLOBAL
#────────────────────────────────────────────────────────────
#➡
# clear formatting
PROMPT+='%b%k%f'


# ▶▷ ▸▹ ►▻
#❬❭❮❯❨❩❪❫❰❱❲❳❴❵➡
RPROMPT+="❬%?❭"
PROMPT+="%F{cyan}"
PROMPT+=" ❱ "
PROMPT+="%b%f%k"

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
