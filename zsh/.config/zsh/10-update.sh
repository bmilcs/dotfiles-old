#!/usr/bin/env bash
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 DAILY AUTO-UPDATE [./10-update.zsh]

# dotfile rc file debugging
. ~/bin/sys/dotfile_logger
  dotlog '+ $ZDOTDIR/10-update.sh'

source _bm

# clean exit
cexit() {
  echo && _w "${B}dirty exit" && _o "cleaning up"
  rm -rf $running && _s "done\n" && exit 1
  }
trap 'cexit' SIGINT

today="$(date +"%Y-%m-%d" | cut -d'-' -f 3)"
dstatus="$HOME/.config/up/dotfiles.bm"
fstatus="$HOME/.config/up/fzf.bm"
rstatus="$HOME/.config/up/repos.bm"
ustatus="$HOME/.config/up/system.bm"
vstatus="$HOME/.config/up/vim.bm"
zstatus="$HOME/.config/up/zsh.bm"
running="$HOME/.config/up/running.bm"

# log path check
[[ -d ~/.config/up ]] || mkdir -p ~/.config/up
[[ -f $dstatus ]] && dlast="$(cat "$dstatus")" || dlast=00
[[ -f $fstatus ]] && flast="$(cat "$fstatus")" || flast=00
[[ -f $rstatus ]] && rlast="$(cat "$rstatus")" || rlast=00
[[ -f $ustatus ]] && slast="$(cat "$ustatus")" || slast=00 
[[ -f $vstatus ]] && vlast="$(cat "$vstatus")" || vlast=00
[[ -f $zstatus ]] && zlast="$(cat "$zstatus")" || zlast=00

# force non-workstations to update repo everytime (vm's, etc)
[[ ! "$HOST" == "bm"* ]] && gp && echo "$today" > "$dstatus"

# process check
if [[ ! -f "$running" ]]; then

  # create $running
  touch "$running"
  
  # packages
  [[ ! "$today" == "$slast" ]] && up && echo "$today" > "$ustatus"

  # repos
  if [[ ! "$today" == "$rlast" ]] && [[ -f /usr/local/bin/upr ]]; then
    upr && echo "$today" > "$rstatus"
  else # vm's via ssh 
    echo "$today" > "$rstatus"
  fi

  # zinit
  [[ ! "$today" == "$zlast" ]] \
    && _a "zinit: self update" && zinit self-update && _s \
    && _a "zinit: plugins" && zinit update --all && _s \
    && echo "$today" > "$zstatus"

  # fzf
  [[ ! "$today" == "$flast" ]] && upfzf && echo "$today" > "$fstatus"

  # vim plugins
  [[ ! "$today" == "$vlast" ]] && upvim && echo "$today" > "$vstatus"

  # dotfiles repo: pc/laptop
  if [[ ! "$today" == "$dlast" ]] && [[ "$HOST" == "bm"* ]]; then 
    gp && echo "$today" > "$dstatus"
  fi

  # clean finish
  rm -rf "$running"

else # update process already exists

  _wb "instance of ${B}auto-update${BLU} running in another terminal."

fi
