#!/bin/bash
# autostart.sh -bmilcs

# audio
pulseaudio --k &
pulseaudio --start &
# compositor
picom --config ~/.config/picom/config &
# wallpaper
$HOME/.fehbg &
# polybar
/home/bmilcs/.config/polybar/bspwm.sh &    


# network  
# nm-applet &
# kde-connect
#/usr/lib/kdeconnectd &
#kdeconnect-indicator &

