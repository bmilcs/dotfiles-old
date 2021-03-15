#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 DAILY AUTO-UPDATE [./10-update.zsh]

# TODO: What else is manually installed?

# dotfile rc file debugging
. "${HOME}/bin/sys/dotfile_logger"
  dotlog 'launched: /home/bmilcs/bm/zsh/.zsh/10-update.zsh'

source _bm

today="$(date +"%Y-%m-%d" | cut -d'-' -f 3)"
dstatus="$HOME/.config/up/dotfiles.bm"
fstatus="$HOME/.config/up/fzf.bm"
rstatus="$HOME/.config/up/repos.bm"
ustatus="$HOME/.config/up/system.bm"
vstatus="$HOME/.config/up/vim.bm"
zstatus="$HOME/.config/up/zsh.bm"

# log path check
[[ -d ~/.config/up ]] || mkdir -p ~/.config/up
[[ -f $dstatus ]] && dlast="$(cat "$dstatus")" || dlast=00
[[ -f $fstatus ]] && flast="$(cat "$fstatus")" || flast=00
[[ -f $rstatus ]] && rlast="$(cat "$rstatus")" || rlast=00
[[ -f $ustatus ]] && slast="$(cat "$ustatus")" || slast=00 
[[ -f $vstatus ]] && vlast="$(cat "$vstatus")" || vlast=00
[[ -f $zstatus ]] && zlast="$(cat "$zstatus")" || zlast=00

# zsh plugins & manager
[[ ! "$today" == "$zlast" ]] \
  && _a "zinit" && zinit self-update && _s \
  && _a "plugins" && zinit update --all && _s \
  && echo "$today" > "$zstatus"

# fzf update
[[ ! "$today" == "$flast" ]] && upfzf && echo "$today" > "$fstatus"

# system (pacman & aur)
[[ ! "$today" == "$slast" ]] && up && echo "$today" > "$ustatus"

# github repo software
if [[ ! "$today" == "$rlast" ]] && [[ -f /usr/local/bin/upr ]]; then
  upr && echo "$today" > "$rstatus"
fi

# dotfiles repo
[[ ! "$today" == "$dlast" ]] && gp && echo "$today" > "$dstatus"

# dotfiles every time (vm's)
[[ ! "$HOST" == "bm"* ]] && gp

# vim plug install & update  / vim +'PlugInstall --sync' +qall &> /dev/null
[[ ! "$today" == "$vlast" ]] && upvim && echo "$today" > "$vstatus"

