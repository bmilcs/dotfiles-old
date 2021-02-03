#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#────────────────────────────────────────────────────────────
#   POLYBAR LAUNCHER              
#────────────────────────────────────────────────────────────

killall -q polybar
set -x
# wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [[ $(pgrep -x "i3") ]]; then 

  # launch polybar, custom conf, forward output to log
  polybar -c ~/.config/polybar/bars.ini -r i3 2>/home/bmilcs/.config/polybar/log &
  polybar -c ~/.config/polybar/bars.ini -r dummy 2>/home/bmilcs/.config/polybar/log &

  echo ">>> i3 polybar launched..." >> ~/.config/polybar/log

elif [[ $(pgrep -x "bspwm") ]]; then

  # launch polybar, custom conf, forward output to log
  polybar -r -c ~/.config/polybar/bars.ini bspwm 2>/home/bmilcs/.config/polybar/log &

  echo ">>> bspwm polybar launched..." >> ~/.config/polybar/log

else

  echo ">>> ERROR: NO DESKTOP_SESSION MATCHED" >> ~/.config/polybar/log

  exit 1

fi
