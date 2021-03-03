#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 DAILY AUTO-UPDATE [./10-update.zsh]
#────────────────────────────────────────────────────────────
# ZINIT & SYSTEM
#────────────────────────────────────────────────────────────

unow="$(date +"%Y-%m-%d" | cut -d'-' -f 3)"
ustatus="$HOME/.config/up/system_zinit.bm"

if [ -f $ustatus ]; then ulast="$(cat "$ustatus")" ; else
  ulast="00" && echo "$unow" > "$ustatus" ; fi

if [[ ! "$unow" == "$ulast" ]]; then
  source $HOME/bin/_head ; _t bmilcs daily update 
  _a "last ran" ; _i "$DAYOFWEEK, $ulast of $MONTH"
  _t "zinit self-update" && echo && zinit self-update && echo &&_s "\n" 
  up && echo "$unow" > "$ustatus" 
fi
