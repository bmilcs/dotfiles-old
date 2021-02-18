#!/bin/sh
updates_arch=0
updates_aur=0
updates=0

if ! updates_arch=$(pacman -Sup 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
    updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))

if [ "$updates" -gt 0 ]; then
    echo "$updates"
else
    echo "0"
fi
