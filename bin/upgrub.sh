#!/bin/bash

now=`date +"%Y-%m-%d"`
sudo cp /boot/grub/grub.cfg ~/.config/backup/grub.cfg-$now && sudo grub-mkconfig -o /boot/grub/grub.cfg
