#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 ZSH: ENVIRONMENT [./00-env.zsh]
#────────────────────────────────────────────────────────────
# PATHS
#────────────────────────────────────────────────────────────

# add $PATH to path array | source: arch wiki
if [[ ! $(echo $PATH|grep -q $HOME/bin) ]]; then
  # TODO move .xinitrc's path script here
  typeset -U PATH path
  path=("$HOME/bin" "$HOME/.local/bin" "$path[@]")
  export PATH
fi

#────────────────────────────────────────────────────────────
# DOTFILE RELATED
#────────────────────────────────────────────────────────────

export D=$HOME/bm
export BAK=$HOME/.backup

if [[ -f "/etc/arch-release" ]]; then
  export DISTRO='arch'; else export DISTRO='debian'; fi

#────────────────────────────────────────────────────────────
# SOFTWARE
#────────────────────────────────────────────────────────────

# gnupg
export GNUPGHOME='.gpg'

# forgit
export FORGIT_COPY_CMD='xclip -selection clipboard'

# fzf
export FZF_DEFAULT_OPTS="--color=dark --height 70% --layout reverse"
export FZF_DEFAULT_COMMAND='rg --files --hidden -g !.git/'

#────────────────────────────────────────────────────────────
# SYSTEM MODS
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
