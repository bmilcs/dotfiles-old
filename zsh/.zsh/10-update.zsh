#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 DAILY AUTO-UPDATE [./10-update.zsh]
#────────────────────────────────────────────────────────────
# ZINIT & SYSTEM
#────────────────────────────────────────────────────────────
source _head

today="$(date +"%Y-%m-%d" | cut -d'-' -f 3)"
ustatus="$HOME/.config/up/up.bm"
zstatus="$HOME/.config/up/zsh.bm"
dstatus="$HOME/.config/up/dotfiles.bm"
D=${D:-/home/bmilcs/bm}

[[ -d ~/.config/up ]] || mkdir -p ~/.config/up
[[ -f $ustatus ]] && slast="$(cat "$ustatus")" || slast=00 
[[ -f $zstatus ]] && zlast="$(cat "$zstatus")" || zlast=00
[[ -f $dstatus ]] && dlast="$(cat "$dstatus")" || dlast=00

_t dotfile repo
if [[ "$(git --git-dir="$D"/.git status | grep -q clean)" ]] ;
then
  _a git status
  _o clean repo: issuing git pull
  git --git-dir="$D"/.git pull && _s || _e git pull: something went wrong
else
  _w unclean: skipping sync 
  _o commit changes \& manually git pull
fi

if [[ ! "$today" == "$zlast" ]]; then
  _t "daily update: zsh (zinit)"
  _i "last ran" ; _i "$DAYOFWEEK, $zlast of $MONTH"

  (
  _a "zinit: self update" 
  zinit self-update && _s
  _a "zinit: plugins update"
  zinit update && _s
  ) && echo "$today" > "$zstatus" 
fi

cd $D || \
  {
    _e \$D not set && exit 1
  }

if [[ ! "$today" == "$slast" ]]; then
  _t "daily update: system"
  _i "last ran" ; _i "$DAYOFWEEK, $slast of $MONTH"
  up && echo "$today" > "$ustatus" 
fi

