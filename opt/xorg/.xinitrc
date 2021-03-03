#!/bin/sh
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#────────────────────────────────────────────────────────────
#   xinitrc
#────────────────────────────────────────────────────────────

# define config files
userresources=~/.Xresources
usermodmap=~/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
[ -f $sysresources ] && xrdb -merge $sysresources
[ -f $sysmodmap ] && xmodmap $sysmodmap
[ -f "$userresources" ] && xrdb -merge "$userresources"
[ -f "$usermodmap" ] && xmodmap "$usermodmap"

# start xinit extras
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#────────────────────────────────────────────────────────────
# BMILCS CUSTOMIZATIONS
#────────────────────────────────────────────────────────────

# clean up $HOME
export GTK2_RC_FILES=~/.config/gtk-2.0/gtkrc-2.0
export __GL_SHADER_DISK_CACHE_PATH=~/.cache/.nv

# path var: add ~/bin & all subdir's
[[ -d $HOME/bin && -z $(echo $PATH | grep -o $HOME/bin) ]] \
  && export PATH=$PATH$(find $HOME/bin/ -type d -printf ":%p")

#────────────────────────────────────────────────────────────
# ESSENTIALS
#────────────────────────────────────────────────────────────

~/bin/bootstrap &

#────────────────────────────────────────────────────────────
# WM
#────────────────────────────────────────────────────────────

session=${1:-bspwm}

case $session in
  i3 | i3wm) exec i3 ;;
  bsp | bspwm) exec bspwm ;;
  *) exec $1 ;;
esac

#────────────────────────────────────────────────────────────
# EXTRAS
#────────────────────────────────────────────────────────────

# disable beep sound
set bell-style none
