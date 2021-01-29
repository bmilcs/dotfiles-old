#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#────────────────────────────────────────────────────────────
#   POLYBAR LAUNCHER              
#────────────────────────────────────────────────────────────

killall -q polybar

# wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [[ $(pgrep -x "i3") ]]; then 

  # launch polybar, custom conf, forward output to log
  polybar -c ~/.config/polybar/bars.ini -qr i3 2>/home/bmilcs/.config/polybar/i3.log &
  polybar -c ~/.config/polybar/bars.ini -qr dummy 2>/home/bmilcs/.config/polybar/i3.log &

  echo ">>> i3 polybar launched..." >> ~/.config/polybar/log

elif [[ $(pgrep -x "bspwm") ]]; then

  # launch polybar, custom conf, forward output to log
  polybar -qr -c ~/.config/polybar/bars.ini bspwm 2>/home/bmilcs/.config/polybar/bspwm.log &

  echo ">>> bspwm polybar launched..." >> ~/.config/polybar/log

else

  echo ">>> ERROR: NO DESKTOP_SESSION MATCHED" >> ~/.config/polybar/log

  exit 1

fi
