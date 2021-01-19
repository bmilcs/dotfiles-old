#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#────────────────────────────────────────────────────────────
#   bashrc
#────────────────────────────────────────────────────────────

#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#────────────────────────────────────────────────────────────
#   BASH RC
#────────────────────────────────────────────────────────────
# TODO
#   complete cross-platform functionality with
#     - zsh aliases
#     - zsh functions
#     - zsh scripts
#────────────────────────────────────────────────────────────
# INTERACTION CHECK 
#────────────────────────────────────────────────────────────

# if running non-interactively, end script
case $- in
    *i*)        ;;
      *) return ;;
esac

#────────────────────────────────────────────────────────────
# HISTORY
#────────────────────────────────────────────────────────────

# length & size
HISTSIZE=1000
HISTFILESIZE=2000

# ignore duplicates/lines beginning with a space
HISTCONTROL=ignoreboth

# append, don't overwrite
shopt -s histappend

# check window size after each command, update LINES/COLUMNS
shopt -s checkwinsize

# improve less for non-text input files (lesspipe)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#────────────────────────────────────────────────────────────
#   INPUT & KEYBIND TWEAKS
#────────────────────────────────────────────────────────────

# vim mode
set editing-mode vi


bind 'set show-all-if-ambiguous on'

# menu completion
bind 'TAB:menu-complete'

# "**" pathname expansion: matches all files/dir/subdir
shopt -s globstar

# colored GCC warnings and errors
# TODO research GCC # export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# autocompletion 
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


#────────────────────────────────────────────────────────────
#  ADDITIVES
#────────────────────────────────────────────────────────────

# dotfiles
for bmfile in ~/.bm_*
do
	source "$bmfile"
done

# dir colors
eval "$(dircolors ~/.dir_colors)"

# ls: group dotfiles together
export LC_COLLATE="C"

# fzf
if [[ ! "$PATH" == */home/bmilcs/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/bmilcs/.fzf/bin"
fi
[[ $- == *i* ]] && source "/home/bmilcs/.fzf/shell/completion.bash" 2> /dev/null
source "/home/bmilcs/.fzf/shell/key-bindings.bash"

#────────────────────────────────────────────────────────────
# AESTHETICS
#────────────────────────────────────────────────────────────

#
# TITLE
#

case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1" ;;
  *) ;;
esac

#
# COLOR SUPPORT 
#

if [ -x /usr/bin/dircolors ]; then
eval "$(dircolors ~/.dir_colors)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

#
# PROMPT
#

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  if [ $(id -u) -eq 0 ]; then # ROOT
    PS1="\[\e[1;30;41m\]    \[\e[1m\]\H  \[\e[m\]\[\e[0;31;40m\]  \u      \[\e[m\]\[\e[1;30m\] \d | \@ | \# | \[\e[34m\]\w\[\e[1;30m\] | \[\e[30m\] \[\e[m\]\n\[\e[1;31m\]$\[\e[m\] "
  else 
    PS1="\[\e[1;30;44m\]    \[\e[1m\]\H  \[\e[m\]\[\e[0;34;40m\]  \u      \[\e[m\]\[\e[1;30m\] \d | \@ | \# | \[\e[34m\]\w\[\e[1;30m\] | \[\e[30m\] \[\e[m\]\n\[\e[1;34m\]#\[\e[m\] "
  fi 
else
  PS1="\u@\H [\w] $ "
fi

