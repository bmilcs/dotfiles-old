#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done


polybar -q -c ~/.config/polybar/bspwm.conf bspwm 2>/home/bmilcs/.config/polybar/bspwm.log &
#polybar -c ~/.config/polybar/bspwm.conf -rq tray 2>/home/bmilcs/.config/polybar/log &
#polybar -c ~/.config/polybar/bspwm.conf -rq title 2>/home/bmilcs/.config/polybar/log &
