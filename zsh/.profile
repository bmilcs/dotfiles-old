#───────────────────────────────────────────────────────────
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 BASH'S .PROFILE [./.profile]

#    1) read by all shells, not bash specifically
#       ie: environment variables, PATH & friends
#    2) anything that should be available to:
#       gui apps, sh or bash invoked as sh

# dotfile rc file debugging
. "${HOME}/bin/sys/dotfile_logger"
dotlog '+ ~/.profile'

#───────────────────────────────────────────────────────────  dotfiles  ───────

# dotfile
export D=$HOME/bm
export BM=$HOME/bm
export BMP=$HOME/bmP
export BAK=$HOME/.backup

[ -f "$HOME/bin/_distro" ] && . "$HOME/bin/_distro"

#──────────────────────────────────────────────────────────────  $path  ───────

# path: add ~/bin + subdirs
[ -d "$HOME/bin" ] && [ -z "$(echo $PATH | grep -o "$HOME/bin")" ] \
  && export PATH=$PATH$(find $HOME/bin/ -type d -printf ":%p")

# path: add ~/.local/bin/
[ -d "$HOME/.local/bin" ] \
  && [ -z "$(echo $PATH | grep -o "$HOME/.local/bin")" ] \
  && export PATH=$PATH:"$HOME/.local/bin"

# go path (i3keys)
[ -d "$HOME/.config/go" ] && [ -z "$(echo "$PATH" \
  | grep -o "$HOME/.config/go")" ] && export GOPATH="$HOME/.config/go" \
  && export PATH=$PATH:$GOPATH/bin

#────────────────────────────────────────────────────────  clean $home  ───────

# mv gtk files
export GTK2_RC_FILES=~/.config/gtk-2.0/gtkrc-2.0
export __GL_SHADER_DISK_CACHE_PATH=~/.cache/.nv

# gpg
export GNUPGHOME="${BMP}/gpg"
# export GNUPGHOME="${XDG_CONFIG_HOME:-~/.config}/gpg"

# password store
export PASSWORD_STORE_DIR="${BMP}/pw"
# export GNUPGHOME="${XDG_CONFIG_HOME:-~/.config}/password"

#────────────────────────────────────────────────────────────  ansible  ───────

export ANSIBLE_CONFIG=~/ans/ansible.cfg
export ANSIBLE_HOME=~/ans
[ -d "$ANSIBLE_HOME/bin" ] \
  && export PATH=$PATH:$ANSIBLE_HOME/bin

#───────────────────────────────────────────────────────────  software  ───────

# terminal/text
export EDITOR=nvim
export VISUAL=nvim
export TERM=xterm-256color
export COLORTERM="truecolor"

# bmpc/bmtp
[[ $HOST == bm* ]] \
  && export TERMINAL=alacritty

# firefox [webrender compositor test]
export MOZ_WEBRENDER=1

# bat
export BAT_THEME='Nord'

# forgit
export FORGIT_COPY_CMD='xclip -selection clipboard'

#─────────────────────────────────────────────────────────────  locale  ───────

LANG="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"

#LC_PAPER="en_US.UTF-8"
#LC_NAME="en_US.UTF-8"
#LC_ADDRESS="en_US.UTF-8"
#LC_TELEPHONE="en_US.UTF-8"
#LC_MEASUREMENT="en_US.UTF-8"
#LC_IDENTIFICATION="en_US.UTF-8"

#────────────────────────────────────────────────────────────────  fzf  ───────

#--preview '(bat --color=always {} || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_DEFAULT_OPTS="
  --preview '(highlight -O ansi -l {} 2> /dev/null || bat {} \
    || tree -C {}) 2> /dev/null | head -200'

  --keep-right
  --preview-window=right:sharp
  --height 97%
  --reverse
  --info=hidden
  --margin=0
  --padding=0
  --marker='#'
  --pointer='-'

  --color fg:#81a1c1
  --color fg+:#88c0d0
  --color hl:#d8dee9
  --color hl+:#eceff4
  --color preview-fg:#d8dee9
  --color info:#4c566a
  --color header:#81a1c1

  --color bg:#2e3440
  --color bg+:#2e3440
  --color preview-bg:#3b4252
  --color border:#81a1c1
  --color gutter:#2e3440

  --color prompt:#5e81ac
  --color pointer:#eceff4
  --color marker:#ebcb8b
  --color spinner:#b48ead
  "

# commands
export FZF_DEFAULT_COMMAND="fd -H -E '{.git,*cache*,*Cache*}' . "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -H -E .git -E .cache -t d . $HOME"

# export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --glob '!*/{.git,node_modules}/**'"
# export FZF_CTRL_T_COMMAND="rg --files --no-ignore-vcs --glob '!*/{.git,node_modules}/**'"
# export FZF_ALT_C_COMMAND="fd --type d --no-ignore-vcs --exclude node_modules --exclude .git"

# files & dirs (vim **<tab>)
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
# dirs only (cd **<tab>)
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

#──────────────────────────────────────────────────────────  color var  ───────

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

#export TIME="$(date '+%I:%M %P')" # TODO fix to update everytime
#export DATE="$(date '+%Y-%m-%d')"
#export MONTH="$(date '+%B')"
#export DAY="$(date '+%d')"
#export DAYOFWEEK="$(date '+%A')"

#────────────────────────────────────────────────────────  system mods  ───────

if [[ $DISTRO == arch* ]]; then

  # multi-core build
  export MAKEFLAGS="-j$(nproc)"

  # build dir to ram
  export BUILDDIR=/tmp/makepkg makepkg

fi
