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
D="${D:-/home/bmilcs/bm}"

[[ -d ~/.config/up ]] || mkdir -p ~/.config/up
[[ -f $ustatus ]] && slast="$(cat "$ustatus")" || slast=00 
[[ -f $zstatus ]] && zlast="$(cat "$zstatus")" || zlast=00
[[ -f $dstatus ]] && dlast="$(cat "$dstatus")" || dlast=00


alias g="git --git-dir="$D"/.git --work-tree="$D""
if [[ ! "$today" == "$dlast" ]]; then

  _a local health
  _i checking for undocumented changes

  D="${D:-/home/bmilcs/bm}"
  clean="$(g status | grep "clean")"


  if [[ ! -z "$clean" ]] ; then

    _s clean: no action necessary

    _a update check
    _i comparing local vs remote dotfiles
    g remote update > /dev/null 2>&1 # hide this afterward

    if [[ "$(g status -uno)" == *"ahead"* ]]; then
      _w "ahead of origin/main"
      _a pushing changes
      _i updating remote dotfiles repo "\n"
      g push \
      && echo && _s

    elif [[ "$(g status -uno)" == *"behind"* ]]; then
      _w "behind origin/main"
      _a git pull
      _i updating local dotfiles "\n"
      g pull \
      && echo && _s
    else
      _s "up-to-date": no action necessary
    fi
  else
    _e dirty: unable to proceed
    _aa todo
    _i commit local changes "\n"

    g status -s && echo

    _s done "\n"
  fi
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

