#!/bin/bash

#
# betterdiscordctl -bmilcs
#
# source: https://github.com/rauenzi/BetterDiscordApp
# instructions: https://gist.github.com/ObserverOfTime/d7e60eb9aa7fe837545c8cb77cf31172
#

curl -O https://raw.githubusercontent.com/bb010g/betterdiscordctl/master/betterdiscordctl
chmod +x betterdiscordctl
sudo mv betterdiscordctl /usr/local/bin

#
# glasscord 
#
# source: https://github.com/AryToNeX/Glasscord
# releases: https://github.com/AryToNeX/Glasscord/releases/download/v0.9999.9999/glasscord.asar

yay -Syu asar

sudo mkdir -p /usr/lib/electron/resources/app
cd /usr/lib/electron/resources
sudo asar ef default_app.asar package.json
sudo mv package.json app/package.json
cd app
sudo wget https://github.com/AryToNeX/Glasscord/releases/download/v0.9999.9999/glasscord.asar

https://raw.githubusercontent.com/YottaGitHub/Nord-Glasscord/master/nord-glasscord.theme.css




