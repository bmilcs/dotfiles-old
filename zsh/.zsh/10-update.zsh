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

unset outdated
for i in $dlast $flast $rlast $slast $vlast $zlast; do
  [[ ! $today == "$i" ]] && outdated=1 && break
done

if [[ -n $outdated ]]; then
  if _askb "run daily update?"; then

    # zsh: plugins w/ manager
    [[ ! "$today" == "$zlast" ]] \
      && _a "zinit" && zinit self-update && _s \
      && _a "plugins" && zinit update --all && _s \
      && echo "$today" > "$zstatus"

    # packages: pacman & aur
    [[ ! "$today" == "$slast" ]] && up && echo "$today" > "$ustatus"

    # fzf
    [[ ! "$today" == "$flast" ]] && upfzf && echo "$today" > "$fstatus"

    # vim plug install & update  / vim +'PlugInstall --sync' +qall &> /dev/null
    [[ ! "$today" == "$vlast" ]] && upvim && echo "$today" > "$vstatus"

    # cloned repos
    if [[ ! "$today" == "$rlast" ]] && [[ -f /usr/local/bin/upr ]]; then
      upr && echo "$today" > "$rstatus"
    else # vm's via ssh 
      echo "$today" > "$rstatus"
    fi

    # dotfiles repo: pc/laptop
    if [[ "$HOST" == "bm"* ]] && [[ ! "$today" == "$dlast" ]]; then 
      gp && echo "$today" > "$dstatus"
    fi
  else
    _sb "skipped for now"
  fi
fi

# dotfiles repo: vm via ssh
[[ ! "$HOST" == "bm"* ]] && gp && echo "$today" > "$dstatus"
