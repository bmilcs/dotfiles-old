#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#              zsh environment
#────────────────────────────────────────────────────────────
# PATH
#────────────────────────────────────────────────────────────

# add $PATH to path array | source: arch wiki
if [[ ! $(echo $PATH|grep -q $HOME/bin) ]]; then
  typeset -U PATH path
  path=("$HOME/bin"  "$path[@]")
  export PATH
fi

#────────────────────────────────────────────────────────────
# REPO DIR
#────────────────────────────────────────────────────────────

export D=$HOME/bm
export BAK=$HOME/.backup

if [[ -f "/etc/arch-release" ]]; then
  export DISTRO='arch'; else export DISTRO='debian'; fi

#────────────────────────────────────────────────────────────
# DAILY UPDATE
#────────────────────────────────────────────────────────────

source $HOME/bin/_head
unow="$(date +"%Y-%m-%d" | cut -d'-' -f 3)"
ustatus=$HOME/.config/zsh/.bm-update

if [ -f $ustatus ]; then 
  ulast="$(cat "$ustatus")"
else
  ulast="00"
  echo "$unow" > "$ustatus"
fi

if [[ ! "$unow" == "$ulast" ]]; then
  echo "update: needed! starting now:"
    zinit self-update
  echo "$unow" > "$ustatus"
fi

#────────────────────────────────────────────────────────────
# ENV VAR
#────────────────────────────────────────────────────────────

# multi-core build
export MAKEFLAGS="-j$(nproc)"

# build dir to ram
export BUILDDIR=/tmp/makepkg makepkg
export EDITOR=nvim
export VISUAL=nvim
export TERM=xterm-256color
export TERMINAL=alacritty

#────────────────────────────────────────────────────────────
# FORGIT 
#────────────────────────────────────────────────────────────
FORGIT_COPY_CMD='xclip -selection clipboard'

#────────────────────────────────────────────────────────────
# FZF
#────────────────────────────────────────────────────────────

export FZF_DEFAULT_OPTS="--color=dark --height 70% --layout reverse"
export FZF_DEFAULT_COMMAND='rg --files --hidden -g !.git/'

#────────────────────────────────────────────────────────────
# LOCALE
#────────────────────────────────────────────────────────────

LANG="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
#LC_TIME="nl_NL.utf-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL="en_US"
