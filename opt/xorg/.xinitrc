#!/bin/sh
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#   XINITRC

# dotfile rc file debugging
. "${HOME}/bin/sys/dotfile_logger" && dotlog '+ ~/.xinitrc'

# define config files
userresources=~/.Xresources
usermodmap=~/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
[ -f $sysresources ]      && xrdb -merge $sysresources
[ -f $sysmodmap ]         && xmodmap $sysmodmap
[ -f "$userresources" ]   && xrdb -merge "$userresources"
[ -f "$usermodmap" ]      && xmodmap "$usermodmap"

# start xinit extras
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# bootstrap 1: essentials
~/bin/wm/bootstrap1 &> "$BMLOGS/boot.log" &

# makeconf if not exist
[[ ! -e ~/.config/i3/config ]] && . ~/bin/wm/i3makeconf

# window manager
session=${1:-i3}
case $session in
  i3 | i3wm)
    exec i3 -V -d all &> "$HOME/.config/i3/log";;
  bsp | bspwm) exec bspwm ;;
  *) exec $1 ;;
esac
 
# disable beep sound
set bell-style none

