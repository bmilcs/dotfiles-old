#!/usr/bin/env bash

#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 DAILY AUTO-UPDATE [./10-update.zsh]

# dotfile rc file debugging
. ~/bin/sys/dotfile_logger
  dotlog '+ $ZDOTDIR/05-update.sh'

source _bm

# ansible mode
[[ $# -eq 1 ]] && ansible=1
[[ $# -eq 2 ]] && auto=1

#──────────────────────────────────────────────────────────────  traps  ───────

clean() { 
  rm -rf "$running" 
  }

ctrlC() {
  echo && _w "${B}now exiting cleanly"
  clean && _s "done\n" && exit 1
  }

trap 'ctrlC' 0 1 2 3 15
trap 'clean' EXIT

#───────────────────────────────────────────────────────────────  vars  ───────

today="$(date +"%Y-%m-%d" | cut -d'-' -f 3)"
dstatus="$HOME/.config/up/dotfiles.bm"
fstatus="$HOME/.config/up/fzf.bm"
rstatus="$HOME/.config/up/repos.bm"
ustatus="$HOME/.config/up/system.bm"
vstatus="$HOME/.config/up/vim.bm"
zstatus="$HOME/.config/up/zsh.bm"
astatus="$HOME/.config/up/ansible.bm"
running="$HOME/.config/up/running.bm"

#──────────────────────────────────────────────────────  history check  ───────

[[ -d ~/.config/up ]] || mkdir -p ~/.config/up
[[ -f $dstatus ]] && dlast="$(cat "$dstatus")" || dlast=00
[[ -f $fstatus ]] && flast="$(cat "$fstatus")" || flast=00
[[ -f $rstatus ]] && rlast="$(cat "$rstatus")" || rlast=00
[[ -f $ustatus ]] && slast="$(cat "$ustatus")" || slast=00 
[[ -f $vstatus ]] && vlast="$(cat "$vstatus")" || vlast=00
[[ -f $zstatus ]] && zlast="$(cat "$zstatus")" || zlast=00
[[ -f $astatus ]] && alast="$(cat "$astatus")" || alast=00

#──────────────────────────────────────────────────────────────  begin  ───────

# force non-workstations to update repo everytime (vm's, etc)
if [[ ! "$HOST" == "bm"* ]]; then
  gp &> /dev/null & 
  echo "$today" > "$dstatus"
fi

# process check
if [[ ! -f "$running" ]]; then

  # create $running
  touch "$running"
  
  # packages
  [[ ! "$today" == "$slast" ]] && up && echo "$today" > "$ustatus"
  if [[ "$today" == "$slast" ]] && [[ -n $auto ]]; then
    _a "update: up script"
    _s completed today
  fi

  # repos
  if [[ -f /usr/local/bin/upr ]]; then
    if [[ ! "$today" == "$rlast" ]]; then
      upr && echo "$today" > "$rstatus"
    elif [[ -n $auto ]]; then
      _a "update: repos"
      _s completed today
    fi
  else # vm's via ssh 
    echo "$today" > "$rstatus"
  fi

  # fzf
  [[ ! "$today" == "$flast" ]] && upfzf && echo "$today" > "$fstatus"

  # ansible-unfriendly updates
  if [[ -z $ansible ]]; then

    # zinit
    [[ ! "$today" == "$zlast" ]] &&\
      echo "$today" > "$zstatus" &&\
      _a "zinit: self update" && zinit self-update && _s &&\
      _a "zinit: plugins" && zinit update --all && _s 

    # vim plugins
    if [[ ! "$today" == "$vlast" ]] && [[ -z $ansible ]]; then
      upvim && echo "$today" > "$vstatus"
    fi

  fi # end of ansible-friendly updates

  # dotfiles repo: pc/laptop
  if [[ ! "$today" == "$dlast" ]] && [[ "$HOST" == "bm"* ]]; then 
    gp && echo "$today" > "$dstatus"
  fi

  # ansible [bmpc] 
  if [[ "$HOST" == "bmPC" ]] && [[ ! "$today" == "$alast" ]]; then
    echo "$today" > "$astatus"
    _a ansible-playbook: update
    apb update.yml \
      && _s "done"
  fi

else # update running already

  _wb "instance of ${B}auto-update${BLU} running in another terminal."

fi

