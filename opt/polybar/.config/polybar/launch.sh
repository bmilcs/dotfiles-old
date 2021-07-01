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

polybar-msg cmd quit > /dev/null 2>&1
killall -q polybar

# note: disabled wait until killed
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# i3 config (workstation)
if [[ $(pgrep -x "i3") ]]; then

  # launch polybar, custom conf, forward output to log
  echo ">>> i3 polybar launching..." >> ~/.config/polybar/log
  if [[ $HOST == bmPC ]]; then
    polybar -l info -c ~/.config/polybar/bmPC.ini -r i3 | tee /home/bmilcs/.config/polybar/log &
  elif [[ $HOST == bmTP ]]; then
    polybar -l info -c ~/.config/polybar/bmTP.ini -r i3 | tee /home/bmilcs/.config/polybar/log &
  else
    echo "error"
    exit 1
  fi
      
# polybar -l info -c ~/.config/polybar/bars.ini -r dummy 2> /home/bmilcs/.config/polybar/log &

# bspwm config (laptop)
elif [[ $(pgrep -x "bspwm") ]]; then

  # launch polybar, custom conf, forward output to log
  # echo ">>> bspwm polybar launched..." >> ~/.config/polybar/log
  polybar -l trace -c ~/.config/polybar/bars.ini bspwm # 2>/home/bmilcs/.config/polybar/log &

# future wm's
else

  echo ">>> ERROR: NO DESKTOP_SESSION MATCHED" >> ~/.config/polybar/log

fi
