### pacman/aur

Fixing GPG keyserver receive error... example output:

```sh 
:: PGP keys need importing:
 -> CD0A6E3CBB6768800B0736A8E7677380F54FD8A9, required by: autofs
==> Import? [Y/n] Y
:: Importing keys with gpg...
gpg: keyserver receive failed: No name
problem importing keys
```

**Solution**:

`gpg --keyserver keyserver.ubuntu.com --recv-key CD0A6E3CBB6768800B0736A8E7677380F54FD8A9 `

### thinkpad t14


[Building from files in memory ](https://wiki.archlinux.org/index.php/makepkg#Parallel_compilation)

``` sh
$ BUILDDIR=/tmp/makepkg makepkg
```
/tmp to ram

    tmpfs   /tmp         tmpfs   rw,nodev,nosuid,size=2G          0  0

https://wiki.archlinux.org/index.php/makepkg#Utilizing_multiple_cores_on_compression

    $ lspci -knn|grep -iA2 audio

### archive

**removed software**
- rxvt-unicode-pixbuf 9.22-2
- urxvt-perls 2.3-1

#### zsh & bash dotfiles

Both Bash and Zsh use several startup scripts: profile, bashrc, zlogin, zshrc, etc.

The existence of several startup scripts exists to allow you to apply specific actions for interactive or login shells. For instance, you may want to set up a fancy colour prompt or to enable a powerful completion system for interactive shells only, as it would be pointless to apply it to non-interactive shells (that is, for shell scripts). Or you may want to display a joke and the weather forecast at login, but not each time you spawn a shell by other means.
Common

Both Bash and Zsh first execute a system-wide file, then the corresponding user-specific one. For instance, /etc/profile then ~/.profile. For simplicity I shall only mention the files' base names.
Bash

At startup, depending on the case:

  run as a login shell (or with the option --login), it executes profile (or bash_profile instead if it exists (only user-specific version));
  run as an interactive, non-login shell, it executes bashrc (the system-wide version is called bash.bashrc).

At exit, it executes ~/.bash_logout (the system-wide version is called bash.bash_logout).

Note the funny (read: insane) non-login condition for executing bashrc: it is often worked around by having the profile execute bashrc anyway.
Zsh

Zsh always executes zshenv. Then, depending on the case:

    run as a login shell, it executes zprofile;
    run as an interactive, it executes zshrc;
    run as a login shell, it executes zlogin.

At the end of a login session, it executes zlogout, but in reverse order, the user-specific file first, then the system-wide one, constituting a chiasmus with the zlogin files.
Summary
Bash 	login
yes 	no
interactive	yes	profile	bashrc
no 	profile	-
Zsh 	login
yes 	no
interactive	yes	zshenv zprofile zshrc zlogin	zshenv zshrc
no 	zshenv zprofile zlogin 	zshenv

I personally find the Zsh process much saner. To be honest I should rather say that I find Bash's behaviour insane, with an absurd process (bashrc for interactive, non-login shells…) that needs to be worked around, and an inconsistent naming and search convention (~/.bashrc vs. /etc/bash.bashrc, no system-wide version of bash_logout).

# personal reminders
river valley counseling    feb 10, 3:30pm

https://wiki.archlinux.org/index.php/PulseAudio/Examples#Set_default_input_source


### scratchpad 

https://www.reddit.com/r/unixporn/comments/8giij5/guide_defining_program_colors_through_xresources/
https://www.reddit.com/r/linux/comments/61dbym/managing_dotfiles_a_survey/

#### todo
setup variable colors

#### audio configuration [arch]

how to configure archlinux with a scarlet 2i2 audio interface.

note: alsa is not enough for firefox to play audio.

#### alsa & pulseaudio

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

#### acquire sound device info

    aplay -l
    cat /proc/asound/cards
    systemctl list-units --type=target

#### alsa config
  
    sudo vim /usr/share/alsa/alsa.conf
  
#### pulseaudio
 
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

# thinkpad t14

https://wiki.archlinux.org/index.php/makepkg#Parallel_compilation

Building from files in memory
  Building from files in memory

/tmp to ram

    tmpfs   /tmp         tmpfs   rw,nodev,nosuid,size=2G          0  0

https://wiki.archlinux.org/index.php/makepkg#Utilizing_multiple_cores_on_compression

    $ lspci -knn|grep -iA2 audio

#### archive

**removed software**
- rxvt-unicode-pixbuf 9.22-2
- urxvt-perls 2.3-1

#### zsh & bash dotfiles

Both Bash and Zsh use several startup scripts: profile, bashrc, zlogin, zshrc, etc.

The existence of several startup scripts exists to allow you to apply specific actions for interactive or login shells. For instance, you may want to set up a fancy colour prompt or to enable a powerful completion system for interactive shells only, as it would be pointless to apply it to non-interactive shells (that is, for shell scripts). Or you may want to display a joke and the weather forecast at login, but not each time you spawn a shell by other means.
Common

Both Bash and Zsh first execute a system-wide file, then the corresponding user-specific one. For instance, /etc/profile then ~/.profile. For simplicity I shall only mention the files' base names.
Bash

At startup, depending on the case:

  run as a login shell (or with the option --login), it executes profile (or bash_profile instead if it exists (only user-specific version));
  run as an interactive, non-login shell, it executes bashrc (the system-wide version is called bash.bashrc).

At exit, it executes ~/.bash_logout (the system-wide version is called bash.bash_logout).

Note the funny (read: insane) non-login condition for executing bashrc: it is often worked around by having the profile execute bashrc anyway.
Zsh

Zsh always executes zshenv. Then, depending on the case:

    run as a login shell, it executes zprofile;
    run as an interactive, it executes zshrc;
    run as a login shell, it executes zlogin.

At the end of a login session, it executes zlogout, but in reverse order, the user-specific file first, then the system-wide one, constituting a chiasmus with the zlogin files.
Summary
Bash 	login
yes 	no
interactive	yes	profile	bashrc
no 	profile	-
Zsh 	login
yes 	no
interactive	yes	zshenv zprofile zshrc zlogin	zshenv zshrc
no 	zshenv zprofile zlogin 	zshenv

I personally find the Zsh process much saner. To be honest I should rather say that I find Bash's behaviour insane, with an absurd process (bashrc for interactive, non-login shells…) that needs to be worked around, and an inconsistent naming and search convention (~/.bashrc vs. /etc/bash.bashrc, no system-wide version of bash_logout).

# personal reminders
river valley counseling    feb 10, 3:30pm

https://wiki.archlinux.org/index.php/PulseAudio/Examples#Set_default_input_source
