#───────────────────────────────────────────────────────────
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
dotlog '+ ~/.profile'

#────────────────────────────────────────────────────────────
# $PATH
#────────────────────────────────────────────────────────────

# path: add ~/bin + subdirs
[ -d "$HOME/bin" ] && [ -z "$(echo $PATH | grep -o "$HOME/bin")" ] \
  && export PATH=$PATH$(find $HOME/bin/ -type d -printf ":%p")

# path: add ~/.local/bin/
[ -d "$HOME/.local/bin" ] \
  && [ -z "$(echo $PATH | grep -o "$HOME/.local/bin")" ] \
  && export PATH=$PATH:"$HOME/.local/bin"
#────────────────────────────────────────────────────────────
# CLEAN $HOME
#────────────────────────────────────────────────────────────

# mv gtk files
export GTK2_RC_FILES=~/.config/gtk-2.0/gtkrc-2.0
export __GL_SHADER_DISK_CACHE_PATH=~/.cache/.nv

#────────────────────────────────────────────────────────────
# DOTFILE
#────────────────────────────────────────────────────────────

export D=$HOME/bm
export BAK=$HOME/.backup

. "$HOME/bin/_distro"

#────────────────────────────────────────────────────────────
# FZF
#────────────────────────────────────────────────────────────
#   fg             Text
#   fg+             Text (current line)
#   hl             Highlighted substrings
#   hl+             Highlighted substrings (current line)
#   preview-fg             Preview window text
#   info             Info
#   header             Header

#   bg             Background
#   bg+             Background (current line)
#   preview-bg             Preview window background
#   gutter             Gutter on the left (defaults to bg+)

#   border             Border of the preview window and horizontal separators (--border)
#   prompt             Prompt
#   pointer             Pointer to the current line
#   marker             Multi-select marker
#   spinner             Streaming input indicator

# options
#export FZF_DEFAULT_OPTS='--color=dark --height 90% --layout reverse --border --info=inline'
export FZF_DEFAULT_OPTS="
  --height 90%
  --layout reverse
  --border
  --info=inline

  --color fg:#5e81ac
  --color fg+:#81a1c1
  --color hl:#d8dee9
  --color hl+:#eceff4
  --color preview-fg:#2e3440
  --color info:#4c566a
  --color header:#81a1c1

  --color bg:#2e3440
  --color bg+:#2e3440
  --color preview-bg:#2e3440
  --color border:#3b4252
  --color gutter:#2e3440

  --color prompt:#5e81ac

  --color pointer:#eceff4
  --color marker:#88c0d0
  --color spinner:#b48ead
  "

#export FZF_DEFAULT_OPTS='
#  --color=bg+:#073642,bg:#002b36,spinner:#719e07,hl:#586e75
#  --color=fg:#839496,header:#586e75,info:#cb4b16,pointer:#719e07
#  --color=marker:#719e07,fg+:#839496,prompt:#719e07,hl+:#719e07'

# commands
export FZF_DEFAULT_COMMAND="fd -H . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -H -E .git -E .cache -t d . $HOME"
# export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --glob '!*/{.git,node_modules}/**'"
# export FZF_CTRL_T_COMMAND="rg --files --no-ignore-vcs --glob '!*/{.git,node_modules}/**'"
# export FZF_ALT_C_COMMAND="fd --type d --no-ignore-vcs --exclude node_modules --exclude .git"

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}

#────────────────────────────────────────────────────────────
# SOFTWARE
#────────────────────────────────────────────────────────────

# terminal/text
export EDITOR=nvim
export VISUAL=nvim
export TERM=xterm-256color
if [[ $HOST == bm* ]]; then
  export TERMINAL=alacritty
fi

# bat
export BAT_THEME='Nord'

# gnupg
export GNUPGHOME='.gpg'

# forgit
export FORGIT_COPY_CMD='xclip -selection clipboard'

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
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
#LC_PAPER="en_US.UTF-8"
#LC_NAME="en_US.UTF-8"
#LC_ADDRESS="en_US.UTF-8"
#LC_TELEPHONE="en_US.UTF-8"
#LC_MEASUREMENT="en_US.UTF-8"
#LC_IDENTIFICATION="en_US.UTF-8"

#────────────────────────────────────────────────────────────
# SYSTEM MODS
#────────────────────────────────────────────────────────────

# multi-core build
export MAKEFLAGS="-j$(nproc)"

# build dir to ram
export BUILDDIR=/tmp/makepkg makepkg

