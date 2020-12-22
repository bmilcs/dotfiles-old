#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done



polybar -c ~/.config/polybar/bspwm.conf -rq bspwm 2>/home/bmilcs/.config/polybar/log &
#polybar -c ~/.config/polybar/bspwm.conf -rq tray 2>/home/bmilcs/.config/polybar/log &
#polybar -c ~/.config/polybar/bspwm.conf -rq title 2>/home/bmilcs/.config/polybar/log &

#polybar -rq title 2>/home/bmilcs/.config/polybar/log &
#polybar -rq tray 2>/home/bmilcs/.config/polybar/log &
#polybar -rq dummy 2>/home/bmilcs/.config/polybar/log &

echo "Polybar launched..."
