#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 ZSH PROMPT [./04-prompt.zsh]

# dotfile rc file debugging
. ~/bin/sys/dotfile_logger
  dotlog '+ $ZDOTDIR/04-prompt.zsh'

unset pstatus

# load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'
 
# set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%n in ${PWD/#$HOME/~} ${vcs_info_msg_0_} > '

precmd() {
  # initialize
  PROMPT=""
  RPROMPT=""

  # user-based
  [[ ! $USER == bmilcs ]]    \
    && pstatus=1             \
    && PROMPT+="%F{blue}"    \
    && PROMPT+="%K{black}"   \
    && PROMPT+=" %n@"        # user

  # ssh clients
  [[ -n "$SSH_CLIENT" ]]     \
    && pstatus=1             \
    && PROMPT+="%F{blue}"   \
    && PROMPT+="%K{black}"  \
    && PROMPT+="%B"         \
    && PROMPT+="%M"         \
    && PROMPT+="%b"         \
    && PROMPT+=" "

  # directory
  PROMPT+="%k"

  if [ -r ${PWD} ] && [ -w ${PWD} ]; then
    PROMPT+="%F{blue}"
  else
    PROMPT+="%F{red}"
  fi

  PROMPT+="%B"
  [ -n $pstatus ] && PROMPT+=" "
  PROMPT+="%~"
  PROMPT+='%b%k%f'

  # end
  PROMPT+="%F{cyan}"
  PROMPT+=" ❱ "

  # clear
  PROMPT+="%b%f%k"

  # ▶▷ ▸▹ ►▻
  #❬❭❮❯❨❩❪❫❰❱❲❳❴❵➡

  #────────────────────────────────────────────────────────────
  # RIGHT
  #────────────────────────────────────────────────────────────

  # operating system
  [[ ! "$DISTRO" == "arch"* ]]   \
    &&  RPROMPT+="%F{black}"       \
    &&  RPROMPT+="${DISTRO} "

  # exit status
  RPROMPT+="❬%?❭"
  RPROMPT+="${vcs_info_msg_0_}"
}


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
