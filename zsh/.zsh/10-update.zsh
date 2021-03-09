#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 DAILY AUTO-UPDATE [./10-update.zsh]
#────────────────────────────────────────────────────────────

# dotfile rc file debugging
. "${HOME}/bin/sys/dotfile_logger"
dotlog 'launched: /home/bmilcs/bm/zsh/.zsh/10-update.zsh'

#────────────────────────────────────────────────────────────
# ZINIT & SYSTEM
#────────────────────────────────────────────────────────────
source _head

today="$(date +"%Y-%m-%d" | cut -d'-' -f 3)"
ustatus="$HOME/.config/up/system.bm"
zstatus="$HOME/.config/up/zsh.bm"
dstatus="$HOME/.config/up/dotfiles.bm"
D="${D:-/home/bmilcs/bm}"

[[ -d ~/.config/up ]] || mkdir -p ~/.config/up
[[ -f $ustatus ]] && slast="$(cat "$ustatus")" || slast=00 
[[ -f $zstatus ]] && zlast="$(cat "$zstatus")" || zlast=00
[[ -f $dstatus ]] && dlast="$(cat "$dstatus")" || dlast=00

# zinit
if [[ ! "$today" == "$zlast" ]]; then
  _t "daily update: zsh (zinit)"
  _i "last ran: $MONTH/$zlast"

  (
  _a "zinit: self update" 
  zinit self-update && _s
  _a "zinit: plugins update"
  zinit update && _s
  ) && echo "$today" > "$zstatus" 
fi

# system
if [[ ! "$today" == "$slast" ]]; then
  _t "daily update: system"
  _i "last ran: $MONTH/$zlast"
  up && echo "$today" > "$ustatus" 
fi

# dotfiles
if [[ ! "$today" == "$dlast" ]]; then
  gp
fi

