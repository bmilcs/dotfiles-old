# bmilcs linux

> I bit the bullet & moved to Archlinux full-time in December of 2020. The migration from Debian-based VM's to a pacman-centric workstation required a fresh start. Come take a look:



### [dot.bmilcs.com](https://dot.bmilcs.com)

---

###### install dotfiles, scripts, etc.

    (sudo apt install git ; rm -rf ~/_bmilcs ~/.bm* ~/.inputr* ; git clone https://github.com/bmilcs/linux.git ~/.bmilcs ; chmod -R +x ~/.bmilcs/* ; /bin/bash ~/.bmilcs/dotfiles/install.sh ; source ~/.bashrc)


todo:
- [ ] varken

# rsync

compare copied data and export missing content to log

      rsync -avun --no-group --no-owner --no-perms --no-times /original/nas/dir/ user@newhost:/new/nas/dir/ >> bmilcs_missing.log

      # save output to a file, as it takes a while with huge amounts of data and if you're like me, you'll forget you ran it.
      >> bmilcs.log

- Make sure /original/nas/dir/ has trailing / (supposedly this is important)
- Here's a breakdown:

rsync - | desc
--|--
n | dry-run (DONT CHANGE SHIT)
a | archive (recursive, preserve everything)
v | verbose (speak up)
u | update (skip any files which exists in destination)
no-group | ignore mismatching groups
no-owner | ignore mismatching owners
no-perms | ignore mismatching perms
no-times | ignore mismatching times


# cron

      crontab -e

pos | time | example
--|--|--
1 |	Minute |	0 to 59, or * (no specific value)
2 |	Hour 	|0 to 23, or * for any value. All times UTC.
3 |	Day of the month 	|1 to 31, or * (no specific value)
4 |	Month |	1 to 12, or * (no specific value)
5 |	Day of the week |	0 to 7 (0 and 7 both represent Sunday), or * (no specific value)

Cron time string 	| Description
--|--
30 * * * *| 	Execute a command at 30 minutes past the hour, every hour.
0 13 * * 1 |	Execute a command at 1:00 p.m. UTC every Monday.
*/5 * * * * |	Execute a command every five minutes.
0 */2 * * * |	Execute a command every second hour, on the hour.




# nfs file sharing

      sudo apt install nfs-kernel-server
      sudo nano /etc/exports

      "/path/to the/dir"	10.1.1.0/24(rw,sync,no_subtree_check)

      sudo systemctl restart nfs-kernel-server

      sudo systemctl status nfs-kernel-server

---
# unifi debian install

      sudo apt install gnupg -y
      wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
      echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
      sudo apt-get update
      sudo apt-get install -y mongodb-org
      sudo apt-get update && sudo apt-get install ca-certificates apt-transport-https
      echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
      sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg
      sudo apt-get update && sudo apt-get install unifi -y

# create samba file share

      sudo apt install samba
      sudo /etc/samba/smb.conf
            workgroup = WORKGROUP
            interfaces = 192.168.1.0/24 eth0
            hosts allow = 127.0.0.1/8 192.168.1.0/24


# increase partition size / expand hard drive of vm
### LVM [ubuntu]

      # list info 
      pvs
      vgs
      lvs

      # fdisk (new partition, space added via esxi)
      fdisk /dev/sda
      n
      default ? <enter>
      ...
      t   type
      8e  linux filesystem
      w   write

      # pvcreate (create physical volume)
      pvcreate /dev/sdaX
      pvs

      # vgextend (extend volume group)
      vgextend <vg-name> /dev/sdaX
      vgs
      
      # resize logical volume
      lvm
      lvm> lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
      lvm> exit

      # resize filesystem
      resize2fs /dev/ubuntu-vg/ubuntu-lv




# NON-LVM (Debian), standard

      root
      fdisk -l
      fdisk /dev/sda
      p     #take note of start cylinder sda1
      d     #delete all
      d
      d
      n     #new
      p     #primary
      1
      enter
      enter
      n     #no, do not remove signature
      a     #bootable
      w     #write changes

      #sudo reboot unncessary?

      sudo resize2fs /dev/sda1

      sudo nano /etc/fstab
      #comment out swap




      use p to list the partitions. Make note of the start cylinder of /dev/sda1
      use d to delete first the swap partition (2) and then the /dev/sda1 partition. This is very scary but is actually harmless as the data is not written to the disk until you write the changes to the disk.
      use n to create a new primary partition. Make sure its start cylinder is exactly the same as the old /dev/sda1 used to have. For the end cylinder agree with the default choice, which is to make the partition to span the whole disk.
      *** "N" - do not remove signature!
      use a to toggle the bootable flag on the new /dev/sda1
      review your changes, make a deep breath and use w to write the new partition table to disk. You'll get a message telling that the kernel couldn't re-read the partition table because the device is busy, but that's ok.
      sudo reboot
      sudo resize2fs /dev/sda1      The next magic command is resize2fs.  this form will default to making the filesystem to take all available space on the partition.
      sudo nano /etc/fstab
      comment out unused swap partition




-

# file permissions
### **reading permissions**

  - **three** types of permission

      read | write | execute
      ---|--|---
      open | add | run file
      read |remove|...
      ls dir| rename |  ...
      ...| move | ...
 - **three** levels of permission

      - owner of file
      - user group
      - public

 - **example**

        drwxrwxrwx  1 bmilcs   140   69 Mar  5 09:44 dl

      - ***drwxrwxrwx*** = file permissions
      - reads as: **d | rwx | rwx | rwx**

           file or dir | user | group  | public
           :-:|:-:|:-:|:-:
           **[d]** *rwxrwxrwx* | *d* [**rwx**] *rwxrwx* | *d* *rwx* [**rwx**] *rwx* | *d* *rwx* *rwx* [**rwx**]


### **changing ownership**
- **chown** command

  - **1 file/folder:**

        chown username file.zip
        chown UID file.zip

  - **everything in current directory**

        chown username *
        chown UID *


  - **everything: current directory & subdirectories** (recursive)

        chown -R username *
        chown -R UID *



### changing permissions
- **chmod** command

      chmod permissions filename    # single file/dir
      chmod permissions *           # everything (current dir)
      chmod -R permissions *        # everything (current dir & subdir)

  - chmod requires **3 permissions**

        chmod 764 file.zip

  - chmod permission arguments

      chmod | rule | ie.
      ---:|:---:|:--
      0	|None	|---
      1	|Execute	|--x
      2	|Write	|-w-
      3	|Write Execute	|-wx
      4	|Read|r--
      5	|Read Execute	|r-x
      6	|Read Write	|rw-
      7	|Read Write Execute |rwx


      results in: **-rwxrw-r--**

      7 | 6 | 4
      :--:|:--:|:--:
      owner   |  group |    all
      rwx | rw- | r--
      read write execute|read write|read


## owner & user groups

### reading user (owner) & user groups
- **ls** command

     - **list user & user group**

            $ ls -lia

            648799826320195755 drwxrwxrwx  1 bmilcs bmgrp   69 Mar  7 15:33 dl
                        284018 drwxr-xr-x 19 bmilcs bmgrp 4096 Mar  7 15:09 docker
                        264505 drwxr-xr-x  9 bmilcs bmgrp 4096 Mar  5 11:49 media

       - **bmilcs** is user (left)
       - **bmgrp** is group (right)

     - **list puid & pguid**

            $ ls -lian        # -n argument
            648799826320195755 drwxrwxrwx  1 1086 1000   69 Mar  7 15:33 dl
                        284018 drwxr-xr-x 19 1086 1000 4096 Mar  7 15:09 docker
                        264505 drwxr-xr-x  9 1086 1000 4096 Mar  5 11:49 media

        - **1086** is user's id (left)
        - **1000** is user group's id (right)






### change user's PGUID / PUID

- **usermod -u** command changes a user's PUID/PID

      usermod -u #PID# bmilcs

- **groupmod -g** command changes user's PGUID/GID

      groupmod -g #GID# bmilcs    #group

   - verify file changes

            ls -l
            ls -ln

### applying new PGUID/PUID to files & directories**

- **/home/user** contents are automatically changed with user/groupmod commands

- **other locations** require manual permission commands

    - substitute **$OLD-GID** with **OLD group id**
    - substitute **$OLD-PID** with **OLD used user id**

          find / -group $OLD-GID -exec chgrp -h bmilcs {} \;
          find / -user $OLD-UID -exec chown -h bmilcs {} \;



    - **verify everything**

          ls -l /home/bmilcs/
          id -u bmilcs
          id -g bmilcs
          grep bmilcs /etc/passwd
          grep bmilcs /etc/group
          find / -user bmilcs -ls
          find / -group sales -ls
<br>
---
<br>
---

# linux OS setup

      **** ROOT ****
      apt update && apt upgrade
      apt install sudo

##### custom ssh login script
      # remove bs from ssh login
      touch /home/bmilcs/.hushlogin

      # add banner location to sshd_config
      if grep -Fxq "#Banner none" /etc/ssh/sshd_config
      then
            echo '> enabled banner option > /etc/banner'
            sed -i '/#Banner/c\Banner /etc/banner' /etc/ssh/sshd_config
      else
            echo '> error: sshd_config already configured.'
      fi

      # import custom banner text
      touch /etc/banner
      echo > /etc/banner
      printf "%s" "-----------------------------------------------------" >> /etc/banner
      printf "\n%s" "  >>>   bmilcs homelab" "   >>   host:   " >> /etc/banner
      echo $HOSTNAME >> /etc/banner
      ipp="ip a | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
      eval ip=\$\($ipp\)
      printf "%s" "    >   ip:     " >> /etc/banner
      echo $ip >> /etc/banner
      printf "%s\n\n" "-----------------------------------------------------" >> /etc/banner
      sudo /etc/init.d/ssh restart




#### 2. configure network ####

      sudo vi /etc/network/interfaces

#### /etc/network/interfaces

      auto lo
      iface lo inet loopback

      auto enp2s0
      iface enp2s0 inet static      ### static ip
      iface eth0 inet dhcp          ### or dhcp
            address 10.1.99.2
            netmask 255.255.255.0
            gateway 10.1.99.254
            dns nameservers 209.222.18.222      ### pia
            dns nameservers 209.222.18.218      ### pia 2
            up route add -net 10.1.1.0 netmask 255.255.255.0 gw 10.1.99.254   ### allow lan access

### sudo user

      usermod -aG sudo bmilcs

### sudo without password

      sudo vi /etc/sudoers
      bmilcs    ALL=NOPASSWD: ALL

### universal ssh: rsa
	**** ROOT ****
	sudo mkdir ~/.ssh
	sudo chmod 0700 ~/.ssh
	sudo touch ~/.ssh/authorized_keys
	sudo chmod 0644 ~/.ssh/authorized_keys
	sudo vi ~/.ssh/authorized_keys
			ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== bmilcs

	sudo vi /etc/ssh/sshd_config
			PermitRootLogin yes
			PubkeyAuthentication yes
			AuthorizedKeysFile %h/.ssh/authorized_keys
	sudo service ssh restart
	OR...
	/etc/rc.d/rc.sshd restart

---

# unraid

## ssh: rsa
	cd /boot/config/ssh/
	sudo vi authorized_keys
			ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== rsa-NAMEHERE
	sudo vi /boot/config/go
			mkdir /root/.ssh
			chmod 700 /root/.ssh
			cp /boot/config/ssh/authorized_keys /root/.ssh/
			chmod 600 /root/.ssh/authorized_keys


## mount share

### vm gui

      <filesystem type='mount' accessmode='passthrough'>
      <source dir='/mnt/user/storage/downloads/vm'/>
      <target dir='share'/>
      </filesystem>
      <filesystem type='mount' accessmode='passthrough'>
      <source dir='/mnt/user/storage/downloads/#torrent/watch'/>
      <target dir='watch'/>
      </filesystem>

### within vm

	sudo mkdir /home/share
	sudo vi /etc/fstab
	share /home/#share       9p      trans=virtio,version=9p2000.L,_netdev,rw        0 0
	share /home/#watch       9p      trans=virtio,version=9p2000.L,_netdev,rw        0 0



---
# unattended upgrades

      apt-get install unattended-upgrades apt-listchanges

      sudo vi /etc/apt/apt.conf.d/20auto-upgrades
            APT::Periodic::Update-Package-Lists "1";
            APT::Periodic::Unattended-Upgrade "1";
            APT::Periodic::Download-Upgradeable-Packages "1";
            APT::Periodic::AutocleanInterval "7";
            APT::Periodic::Verbose "1";


      sudo vi /etc/apt/apt.conf.d/50unattended-upgrades
            "${distro_id}:${distro_codename}-updates";
            Unattended-Upgrade::Mail "bmilcs@yahoo.com";
            Unattended-Upgrade::Remove-Unused-Dependencies "true";
            Unattended-Upgrade::Automatic-Reboot "true";
            Unattended-Upgrade::Automatic-Reboot-Time "02:00";

## FIND ALTERNATIVE TO MAILX

# unattended upgrades *rpi*

        "o=${distro_id},n=${distro_codename}";
        "o=${distro_id},n=${distro_codename}-updates";
        "o=${distro_id},n=${distro_codename}-proposed-updates";
        "o=${distro_id},n=${distro_codename},l=Debian-Security";

# test config

      sudo unattended-upgrades --dry-run --debug



---

# openvpn
      openvpn –config client.ovpn




---
# xrdp

### xrdp.ini

      sudo vi etc/xrdp/xrdp.ini

#### cleanup

      # comment the following:

      #[Xorg]
      #[vnc-any]
      #[sesman-any]
      #[rdp-any]
      #[neutrinordp-any]




### add lan for access

      sudo route add -net 10.1.1.0/24 gw 10.1.99.254


### list installed apts

	apt list --installed | grep vnc


### restart network

	/etc/init.d/networking restart

### debian fix

	sudo vi /run/systemd/resolve/resolv.conf
		search bm.bmilcs.com
		nameservers 1.1.1.1
			10.1.99.254
	gsettings set org.gnome.desktop.interface enable-animations false
	xrdp
	max_bpp 128


# clean up | optimize | misc useful commands


### del apps via string

	sudo apt-get remove libreoffice.*

## debugging

### check linux crash logs

	sudo vi /var/crash

---
## misc

replace whole line found in file
      sed -i '/TEXT_TO_BE_REPLACED/c\This line is removed by the admin.' /tmp/foo


---

## apt-get basics

#### always UPDATE before apt upgrade / dist-upgraded

#### update

	apt-get update
		updates package lists
	apt-get upgrade
		downloads latest versions of installed packages (via apt-get update list)
		* "from the sources enumerated in /etc/apt/sources.list(5)"
	apt-get dist-upgrade
		performs "apt-get upgrade" AND intelligently handles the dependencies
		MAY remove obsolete packages or add new ones
	      > /etc/apt/sources.list(5) = list of locations for package files
		> apt_preferences(5) - overriding the general settings for individual packages.

#### maintenance
      apt-get -f install
            "Fix Broken Packages"
      apt-get autoclean
            removes .deb files no longer installed on system.
      *apt-get autoremove
            removes packages that were installed by other packages and are no longer needed.

#### delete
      apt-get remove X
            removes package
            leaves configuration files intact
      apt-get purge X
            removes package
            removes all config files
      apt-get autoremove X
            deletes package & dependencies

---
# vpn dns

      sudo nano /etc/resolv.conf
      209.222.18.222
      209.222.18.218



# vpn killswitch (current)




      #!/bin/bash
      iptables -F
      iptables -X
      iptables -t nat -F
      iptables -t nat -X
      ip6tables -F
      ip6tables -X
      ip6tables -t nat -F
      ip6tables -t nat -X

      # localhost > accept all
      iptables -A INPUT -i lo -j ACCEPT
      iptables -A OUTPUT -o lo -j ACCEPT
      ip6tables -A INPUT -i lo -j ACCEPT
      ip6tables -A OUTPUT -o lo -j ACCEPT

      # allow ping
      iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

      # lan > accept all
      iptables -A INPUT  -i enp2s0 -s 10.1.1.0/24 -j ACCEPT
      iptables -A OUTPUT -o enp2s0 -d 10.1.1.0/24 -j ACCEPT
      iptables -A INPUT  -i enp2s0 -s 10.1.2.0/24 -j ACCEPT
      iptables -A OUTPUT -o enp2s0 -d 10.1.2.0/24 -j ACCEPT
      iptables -A INPUT  -i enp2s0 -s 10.1.86.0/24 -j ACCEPT
      iptables -A OUTPUT -o enp2s0 -d 10.1.86.0/24 -j ACCEPT
      iptables -A INPUT  -i enp2s0 -s 10.1.99.0/24 -j ACCEPT
      iptables -A OUTPUT -o enp2s0 -d 10.1.99.0/24 -j ACCEPT

      # allow dns
      iptables -A INPUT  -p udp --sport 53 -j ACCEPT
      iptables -A OUTPUT -p udp --dport 53 -j ACCEPT


      # allow vpn traffic
      iptables -A INPUT  -p udp --sport 1194 -j ACCEPT
      iptables -A OUTPUT -p udp --dport 1194 -j ACCEPT
      iptables -A INPUT  -p udp --sport 1198 -j ACCEPT
      iptables -A OUTPUT -p udp --dport 1198 -j ACCEPT

      # xrdp ports
      ip6tables -I INPUT -p tcp --dport 3350 -m state --state NEW,ESTABLISHED -j ACCEPT
      ip6tables -I INPUT -p udp --dport 3389 -m state --state NEW,ESTABLISHED -j ACCEPT
      ip6tables -I INPUT -p tcp --dport 3389 -m state --state NEW,ESTABLISHED -j ACCEPT
      ip6tables -I INPUT -p tcp --dport 5910 -m state --state NEW,ESTABLISHED -j ACCEPT

      # dns: pia
      iptables -A INPUT  -d 209.222.18.222 -j ACCEPT
      iptables -A OUTPUT -d 209.222.18.222 -j ACCEPT
      iptables -A OUTPUT -d 209.222.18.218 -j ACCEPT
      iptables -A OUTPUT -d 209.222.18.218 -j ACCEPT

      # PIA server
      iptables -A INPUT  -p udp -s swiss.privateinternetaccess.comm -j ACCEPT;
      iptables -A OUTPUT -p udp -d swiss.privateinternetaccess.com -j ACCEPT;

      # Accept TUN
      iptables -A INPUT    -i tun+ -j ACCEPT
      iptables -A OUTPUT   -o tun+ -j ACCEPT
      iptables -A FORWARD  -i tun+ -j ACCEPT

      # Drop the rest
      iptables -A INPUT   -j DROP
      iptables -A OUTPUT  -j DROP
      iptables -A FORWARD -j DROP
      ip6tables -A INPUT   -j DROP
      ip6tables -A OUTPUT  -j DROP
      ip6tables -A FORWARD -j DROP

---

# **common fixes | errors**

- #### can't open lock file /var/lib/dpkg/lock-frontend (permission denied)

  ![error](https://i.imgur.com/5Om2naZ.png)

      sudo killall apt apt-get
      sudo rm /var/lib/apt/lists/lock
      sudo rm /var/cache/apt/archives/lock
      sudo rm /var/lib/dpkg/lock*
      sudo dpkg --configure -a
      sudo apt update
