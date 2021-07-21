#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 ZSH PROMPT [./04-prompt.zsh]

# dotfile rc file debugging
. ~/bin/sys/dotfile_logger
  dotlog '+ $ZDOTDIR/04-prompt.zsh'

git_prompt() {

  BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/')
  if [ ! -z $BRANCH ]; then
    echo -n "%F{yellow}$BRANCH"
    [ ! -z "$(git status --short)" ] && echo " %F{red}✗"
  fi

}

# set up the prompt (with git branch name)
setopt PROMPT_SUBST
# PROMPT='%n in ${PWD/#$HOME/~} ${vcs_info_msg_0_} > '

precmd() {
  # initialize
  PROMPT=""
  RPROMPT=""
  pstatus=0

  # user-based
  [[ ! $USER == bmilcs ]]    \
    && pstatus=1             \
    && PROMPT+="%F{blue}"    \
    && PROMPT+="%K{black}"   \
    && PROMPT+=" %n@"        # user

  # ssh clients
  [[ -n "$SSH_CLIENT" ]]      \
    && PROMPT+="%F{blue}"     \
    && PROMPT+="%K{black}"    \
    && PROMPT+="%B"           \
    && if [[ $pstatus == 0 ]] \
    && then PROMPT+=" "; fi   \
    && PROMPT+="%M"           \
    && PROMPT+="%b"           \
    && pstatus=1              \
    && PROMPT+=" "

  # directory
  PROMPT+="%k%b%f"

  if [ -r ${PWD} ] && [ -w ${PWD} ]; then
    PROMPT+="%F{blue}"
  else
    PROMPT+="%F{red}"
  fi

  [[ $pstatus -eq 1 ]] && PROMPT+=" "
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
  RPROMPT+="%F{black}"
  RPROMPT+="❬%?❭"

  # minimalist git 
  RPROMPT+="$(git_prompt)"
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
