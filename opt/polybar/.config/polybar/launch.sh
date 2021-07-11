#!/usr/bin/env bash
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 POLYBAR: LAUNCH SCRIPT [./launch.sh]
#────────────────────────────────────────────────────────────
# KILL PREVIOUS INSTANCES
#────────────────────────────────────────────────────────────

LOG() { echo "$*" >> ~/.config/polybar/log; }

LOG -----------------------------------------------
LOG polybar script initiated
LOG -----------------------------------------------

[ -z $HOST ] \
  && HOST=$(cat /etc/hostname)

LOG killing polybar

#polybar-msg cmd quit > /dev/null 2>&1
killall -q polybar
killall -9 polybar


[ ! -s ~/.config/mpd/pid ] && LOG mpd && mpd &>> "$log"_mpd &

#─────────────────────────────────────────────────────────────────  i3  ───────

if [[ $(pgrep -x "i3") ]]; then

  LOG "> wm:   i3" 
  LOG "> host: $HOST"

  if [[ $HOST == "bmPC" ]]; then

    LOG "> launching desktop pc config"

    polybar -c ~/.config/polybar/bmPC.ini -r i3 2>  ~/.config/polybar/log &

  elif [[ $HOST == "bmTP" ]]; then

    LOG "    launching laptop config"

    polybar -c ~/.config/polybar/bmTP.ini -r i3 2> ~/.config/polybar/log &

  else

    LOG "error: host not recognized"
    LOG "host: $HOST"
    exit 1

  fi

#──────────────────────────────────────────────────────────────  bspwm  ───────

elif [[ $(pgrep -x "bspwm") ]]; then

  polybar -c ~/.config/polybar/bars.ini bspwm 2>/home/bmilcs/.config/polybar/log &

else

  echo ">>> ERROR: NO WINDOW MANAGER FOUND" >> ~/.config/polybar/log

fi

#──────────────────────────────────────────────────────────────  notes  ───────

# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
# polybar -l info -c ~/.config/polybar/bars.ini -r dummy 2> /home/bmilcs/.config/polybar/log &

# polybar debugging: -l info / -l trace 
