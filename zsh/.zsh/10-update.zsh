#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 DAILY AUTO-UPDATE [./10-update.zsh]
#────────────────────────────────────────────────────────────
# ZINIT & SYSTEM
#────────────────────────────────────────────────────────────
today="$(date +"%Y-%m-%d" | cut -d'-' -f 3)"
ustatus="$HOME/.config/up/up.bm"
zstatus="$HOME/.config/up/zsh.bm"

[[ -f $ustatus ]] && slast="$(cat "$ustatus")" || slast=00 
[[ -f $zstatus ]] && zlast="$(cat "$zstatus")" || zlast=00

if [[ "$slast" == 0 ]] && [[ "$zlast" == 00 ]]; then
  mkdir -p ~/.config/up; 
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

if [[ ! "$today" == "$slast" ]]; then
  _t "daily update: system"
  _i "last ran" ; _i "$DAYOFWEEK, $slast of $MONTH"
  up && echo "$today" > "$ustatus" 
fi
