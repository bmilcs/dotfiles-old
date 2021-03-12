#────────────────────────────────────────────────────────────
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 BASH'S .PROFILE [./.profile]
#────────────────────────────────────────────────────────────
#    1) read by all shells, not bash specifically
#       ie: environment variables, PATH & friends
#    2) anything that should be available to:
#       gui apps, sh or bash invoked as sh
#────────────────────────────────────────────────────────────

# dotfile rc file debugging
. "${HOME}/bin/sys/dotfile_logger"
dotlog 'launched: /home/bmilcs/.profile'

# path var: add ~/bin & all of it's subdirs
[ -d "$HOME/bin" ] && [ -z "$(echo $PATH | grep -o "$HOME/bin")" ] \
  && export PATH=$PATH$(find $HOME/bin/ -type d -printf ":%p")

# clean up $HOME
export GTK2_RC_FILES=~/.config/gtk-2.0/gtkrc-2.0
export __GL_SHADER_DISK_CACHE_PATH=~/.cache/.nv

#────────────────────────────────────────────────────────────
# DOTFILE RELATED
#────────────────────────────────────────────────────────────

export D=$HOME/bm
export BAK=$HOME/.backup

if [ -f "/etc/arch-release" ]; then
  export DISTRO='arch'; else export DISTRO='debian'; fi

#────────────────────────────────────────────────────────────
# SOFTWARE
#────────────────────────────────────────────────────────────

# terminal/text
export EDITOR=nvim
export VISUAL=nvim
export TERM=xterm-256color
export TERMINAL=alacritty

# bat
export BAT_THEME='Nord'

# gnupg
export GNUPGHOME='.gpg'

# forgit
export FORGIT_COPY_CMD='xclip -selection clipboard'

# fzf
export FZF_DEFAULT_OPTS="--color=dark --height 80% --layout reverse"
#export FZF_DEFAULT_COMMAND="fd . $HOME"
#export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --glob '!*/{.git,node_modules}/**'"
export FZF_CTRL_T_COMMAND="rg --files --no-ignore-vcs --glob '!*/{.git,node_modules}/**'"
export FZF_ALT_C_COMMAND="fd --type d --no-ignore-vcs --exclude node_modules --exclude .git"
#────────────────────────────────────────────────────────────
# COLOR VAR
#────────────────────────────────────────────────────────────
export NC='\033[0m'
export B='\033[1m'
export DIM='\033[2m'
export ITAL='\033[3m'
export UL='\033[4m'
export BLINK='\033[5m'
export INV='\033[7m'
export BLK=${NC}'\033[30m'
export RED=${NC}'\033[31m'
export GRN=${NC}'\033[32m'
export YLW=${NC}'\033[33m'
export BLU=${NC}'\033[34m'
export PUR=${NC}'\033[35m'
export CYN=${NC}'\033[36m'
export WHT=${NC}'\033[37m'
export TIME="$(date '+%I:%M %P')" # TODO fix to update everytime
export DATE="$(date '+%Y-%m-%d')"
export MONTH="$(date '+%B')"
export DAY="$(date '+%d')"
export DAYOFWEEK="$(date '+%A')"

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

#────────────────────────────────────────────────────────────
# SYSTEM MODS
#────────────────────────────────────────────────────────────

# multi-core build
export MAKEFLAGS="-j$(nproc)"

# build dir to ram
export BUILDDIR=/tmp/makepkg makepkg

