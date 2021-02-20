#!/usr/bin/env bash
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#────────────────────────────────────────────────────────────
#   POLYBAR LAUNCHER             
#────────────────────────────────────────────────────────────

polybar-msg cmd quit >/dev/null 2>&1
killall -q polybar
wait until the processes have been shut down
#while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# pass polybar-script location as env var
export PBS="$HOME/.config/polybar-scripts/polybar-scripts"

if [[ $(pgrep -x "i3") ]]; then 

  # launch polybar, custom conf, forward output to log
  echo ">>> i3 polybar launched..." >> ~/.config/polybar/log
  polybar -l info -c ~/.config/polybar/bars.ini -r i3 2>/home/bmilcs/.config/polybar/log &
  polybar -l info -c ~/.config/polybar/bars.ini -r dummy 2>/home/bmilcs/.config/polybar/log &

elif [[ $(pgrep -x "bspwm") ]]; then

  # launch polybar, custom conf, forward output to log
  # echo ">>> bspwm polybar launched..." >> ~/.config/polybar/log
  polybar -l trace -c ~/.config/polybar/bars.ini bspwm # 2>/home/bmilcs/.config/polybar/log &


else

  echo ">>> ERROR: NO DESKTOP_SESSION MATCHED" >> ~/.config/polybar/log

fi

set 
