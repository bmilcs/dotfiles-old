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
# PATH VAR
#────────────────────────────────────────────────────────────

if [[ -d $HOME/bin && -z $(echo $PATH | grep -o $HOME/bin) ]]; then
  export PATH=$PATH$(find $HOME/bin/ -type d -printf ":%p")
fi

#────────────────────────────────────────────────────────────
# APPLICATIONS
#────────────────────────────────────────────────────────────

pgrep -f pulseaudio || pulseaudio --start &


# This snippet is indended to be paseted in `.xinitrc'. Then D-Bus Daemon
# can be started on startup and all sub-processes the windows manager can
# communicate with the daemon.
#
# `.bashrc' also can source the file `/tmp/dbus-session$UID' to restore the
# environment variables

dbus_address=$(echo "$DBUS_SESSION_BUS_ADDRESS" |\
              awk 's/^.*unix:abstract=\([^,]*\),.*$/\1/')
if [ -S "$dbus_address" ] && netstat -nlpx 2> /dev/null |\
                             awk '{print $NF}' |\
                             grep -qF "$dbus_address"; then
   echo "export DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS" > /tmp/dbus-session$UID
   if [ -n "$DBUS_SESSION_BUS_PID" ]; then
       echo "export DBUS_SESSION_BUS_PID=$DBUS_SESSION_BUS_PID" >> /tmp/dbus-session$UID
   fi
else
   process=
   [ -f /tmp/dbus-session$UID ] && source /tmp/dbus-session$UID > /dev/null
   if [ -n "$DBUS_SESSION_BUS_PID" ]; then
       process=$(ps -p "$DBUS_SESSION_BUS_PID" -o comm= 2> /dev/null)
   fi
   if [ "$process" != "dbus-daemon" ]; then
       dbus-launch --sh-syntax --exit-with-session > /tmp/dbus-session$UID
       source /tmp/dbus-session$UID
       export DBUS_SESSION_BUS_ADDRESS DBUS_SESSION_BUS_PID
   fi
fi

(sleep 0.1 && "$HOME"/bin/bootstrap) &

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
