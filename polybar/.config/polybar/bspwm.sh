#!/bin/bash

#
#   POLYBAR LAUNCH SCRIPT
#       github.com/bmilcs
#

# terminate already running bar instances
killall -q polybar

# wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# launch polybar, custom conf, forward output to log
polybar -qr -c ~/.config/polybar/bspwm.conf bspwm 2>/home/bmilcs/.config/polybar/bspwm.log &


#
# GRAVEYARD
#

#polybar -c ~/.config/polybar/bspwm.conf -rq tray 2>/home/bmilcs/.config/polybar/log &
#polybar -c ~/.config/polybar/bspwm.conf -rq title 2>/home/bmilcs/.config/polybar/log &
