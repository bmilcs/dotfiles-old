# archlinux: audio 

- configure archlinux with a scarlet 2i2 audio interface.
- **note**: alsa is not enough for firefox to play audio.

## pulseaudio & alsa
 
``` sh
# install
yay -S pulseaudio pulseaudio-alsa

sudo vim /etc/pulse/client.conf
  # all commented out, aside from:
  autospawn = no

sudo vim /etc/pulse/default.pa
  # add following line, allowing ALSA @ system level to 
  # communicate with PULSEAUDIO @ user level, launched via i3
  load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 
  
# alsa config
sudo vim /usr/share/alsa/alsa.conf
```

**note**: make sure pulseaudio service isn't enabled at root or user level

``` sh
systemctl --user status pulseaudio
systemctl status pulseaudio
```

## acquire sound device info

``` sh
aplay -l
cat /proc/asound/cards
systemctl list-units --type=target
```

  
## pulseaudio

``` sh
# find default INPUT (microphone)
pacmd list-sources | grep -e 'index:' -e device.string -e 'name:'

# find default OUTPUT (speakers)
pacmd list-sinks | grep -e 'name:' -e 'index:'  

# set default devices
sudo vim /etc/pulse/default.pa 

# comment out
#load-module module-device-restore
#load-module module-stream-restore
#load-module module-card-restore

# at bottom:
set-default-sink alsa_output.usb-Focusrite_Scarlett_2i2_USB-00.analog-stereo.monitor
set-default-source alsa_input.usb-Focusrite_Scarlett_2i2_USB-00.analog-stereo
set-card-profile alsa_card.usb-Focusrite_Scarlett_2i2_USB-00 output:analog-stereo+input:analog-stereo
```
