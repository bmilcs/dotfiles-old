#!/usr/bin/env bash

#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 DAILY AUTO-UPDATE [./10-update.zsh]

# dotfile rc file debugging
. ~/bin/sys/dotfile_logger && dotlog '+ $ZDOTDIR/05-update.sh'

# bmilcs lib
source _bm

#───────────────────────────────────────────────────────────────  vars  ───────

# ansible mode
[[ $# -eq 1 ]] && ansible=1
[[ $# -eq 2 ]] && auto=1

# primary vars
today="$(date +"%Y-%m-%d" | cut -d'-' -f 3)"
shpath="$HOME/.config/up"
dstatus="$shpath/dotfiles.bm"
fstatus="$shpath/fzf.bm"
rstatus="$shpath/repos.bm"
ustatus="$shpath/system.bm"
vstatus="$shpath/vim.bm"
zstatus="$shpath/zsh.bm"
astatus="$shpath/ansible.bm"
lockpid="$shpath/lock.pid"

#───────────────────────────────────────────────────────  process lock  ───────

mkdir -p "$shpath"

exec 9>"$lockpid"
if ! flock -n 9; then
  _w "${B}auto-update${YLW} duplicate prevented"
   exit 1
fi

#──────────────────────────────────────────────────────  history check  ───────

[[ -f $astatus ]] && alast="$(cat "$astatus")" || alast=00
[[ -f $dstatus ]] && dlast="$(cat "$dstatus")" || dlast=00
[[ -f $fstatus ]] && flast="$(cat "$fstatus")" || flast=00
[[ -f $rstatus ]] && rlast="$(cat "$rstatus")" || rlast=00
[[ -f $ustatus ]] && ulast="$(cat "$ustatus")" || ulast=00 
[[ -f $vstatus ]] && vlast="$(cat "$vstatus")" || vlast=00
[[ -f $zstatus ]] && zlast="$(cat "$zstatus")" || zlast=00

#──────────────────────────────────────────────────────────  functions  ───────

upped() {
  echo "today" > "$1"
}

#───────────────────────────────────────────────  dotfiles [bmPC|bmTP]  ───────

if [[ ! "$today" == "$dlast" ]] && [[ "$HOST" == "bm"* ]]; then 
  gp && upped "$dstatus"
fi

#────────────────────────────────────────────────────  package manager  ───────

[[ ! "$today" == "$ulast" ]] \
  && up \
  && upped "$ustatus"

if [[ "$today" == "$ulast" ]] && [[ -n $auto ]]; then
  _a "update: up script"
  _s completed today
fi

#────────────────────────────────────────────────────  repo collection  ───────

if [[ -f /usr/local/bin/upr ]]; then
  if [[ ! "$today" == "$rlast" ]]; then
    upr && upped "$rstatus"
  elif [[ -n $auto ]]; then
    _a "update: repos"
    _s completed today
  fi
else # vm's via ssh 
  upped "$rstatus"
fi

#────────────────────────────────────────────────────────────────  fzf  ───────

[[ ! "$today" == "$flast" ]] \
  && upfzf \
  && upped "$fstatus"


#─────────────────────────────────────────────────  ansible unfriendly  ───────

if [[ -z $ansible ]]; then

#──────────────────────────────────────────────────────────────  zinit  ───────
  [[ ! "$today" == "$zlast" ]] &&\
    upped "$zstatus" &&\
    _a "zinit: self update" && zinit self-update && _s &&\
    _a "zinit: plugins" && zinit update --all && _s 

#────────────────────────────────────────────────────────  vim plugins  ───────

  if [[ ! "$today" == "$vlast" ]] && [[ -z $ansible ]]; then
    upvim && upped "$vstatus"
  fi

fi # end of ansible-friendly updates

#──────────────────────────────────────────────────────────  bmpc only  ───────

if [[ "$HOST" == "bmPC" ]] && [[ ! "$today" == "$alast" ]]; then
  upped "$astatus"
  _a ansible-playbook: update
  apb update.yml \
    && _s "done"
fi

#──────────────────────────────────────────────────────────  vm's only  ───────

if [[ ! "$HOST" == "bm"* ]]; then
  {
    gp &> /dev/null \
    && source ~/.config/zsh/.zshrc \
    && source ~/.profile
  } &
  upped "$dstatus"
fi

