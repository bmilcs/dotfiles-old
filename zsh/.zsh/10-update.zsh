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

source _head

today="$(date +"%Y-%m-%d" | cut -d'-' -f 3)"
ustatus="$HOME/.config/up/system.bm"
zstatus="$HOME/.config/up/zsh.bm"
dstatus="$HOME/.config/up/dotfiles.bm"
rstatus="$HOME/.config/up/repos.bm"

# logfile check
[[ -d ~/.config/up ]] || mkdir -p ~/.config/up
[[ -f $ustatus ]] && slast="$(cat "$ustatus")" || slast=00 
[[ -f $zstatus ]] && zlast="$(cat "$zstatus")" || zlast=00
[[ -f $dstatus ]] && dlast="$(cat "$dstatus")" || dlast=00
[[ -f $rstatus ]] && rlast="$(cat "$rstatus")" || rlast=00

# zsh plugins & manager
[[ ! "$today" == "$zlast" ]] \
&& _a "zinit" && zinit self-update && _s \
&& _a "plugins" && zinit update --all && _s \
&& echo "$today" > "$zstatus"

# system (pacman & aur)
[[ ! "$today" == "$slast" ]] && up && echo "$today" > "$ustatus"

# github repo software
[[ ! "$today" == "$rlast" ]] && upr && echo "$today" > "$rstatus"

# dotfiles repo
[[ ! "$today" == "$dlast" ]] && gp && echo "$today" > "$dstatus"
