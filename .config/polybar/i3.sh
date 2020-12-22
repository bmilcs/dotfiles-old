#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done



polybar -c /home/bmilcs/.config/polybar/i3.conf -rq i3 2>/home/bmilcs/.config/polybar/log &
polybar -c /home/bmilcs/.config/polybar/i3.conf  -rq title 2>/home/bmilcs/.config/polybar/log &
polybar -c /home/bmilcs/.config/polybar/i3.conf -rq tray 2>/home/bmilcs/.config/polybar/log &
polybar -c /home/bmilcs/.config/polybar/i3.conf -rq dummy 2>/home/bmilcs/.config/polybar/log &

echo "Polybar launched..."
