archlinux notepad [bmilcs]
----------------------------------------------------

TODO
1. setup variable colors
  - https://www.reddit.com/r/unixporn/comments/8giij5/guide_defining_program_colors_through_xresources/

## audio configuration [arch]

how to configure archlinux with a scarlet 2i2 audio interface.

note: alsa is not enough for firefox to play audio.

### alsa & pulseaudio

install & apply customizations:

  yay -S pulseaudio pulseaudio-alsa
 
  sudo vim /etc/pulse/client.conf
  # all commented out, aside from:
  autospawn = no

  sudo vim /etc/pulse/default.pa
  # add following line, allowing ALSA @ system level to communicate with PULSEAUDIO @ user level, launched via i3
  load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 

**note**: make sure pulseaudio service isn't enabled at root or user level

 systemctl --user status pulseaudio
 systemctl status pulseaudio


### acquire sound device info

  aplay -l
  cat /proc/asound/cards
  systemctl list-units --type=target

### alsa config
  
  sudo vim /usr/share/alsa/alsa.conf
  

### pulseaudio

 
  # find default INPUT (microphone)
  pacmd list-sources | grep -e 'index:' -e device.string -e 'name:'

  # find default OUTPUT (speakers)
  pacmd list-sinks | grep -e 'name:' -e 'index:'  

  # set default devices
  sudo vim /etc/pulse/default.pa 
  # at bottom:
  set-default-sink alsa_output.pci-0000_04_01.0.analog-stereo
  set-default-source alsa_output.pci-0000_04_01.0.analog-stereo.monitor

## archive

**removed software**
- rxvt-unicode-pixbuf 9.22-2
- urxvt-perls 2.3-1














# personal reminders
river valley counseling    feb 10, 3:30pm

https://wiki.archlinux.org/index.php/PulseAudio/Examples#Set_default_input_source
