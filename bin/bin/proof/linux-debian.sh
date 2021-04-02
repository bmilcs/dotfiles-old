#!/bin/bash
# apt-get install sudo -y && cd /tmp && sudo rm -f debian.sh && wget https://raw.githubusercontent.com/bmilcs/linux/master/debian.sh && sudo chmod +x debian.sh && sudo ./debian.sh
# ssh-import-id gh:bmilcs
# set -x #echo on

echo && echo "====================================================================================================="
echo "====  bmilcs debian basic configuration setup  ======================================================" && echo "=====================================================================================================" && echo

# root check
echo '> root check'
if [[ $EUID -ne 0 ]]; then
  echo "ERROR: This script must be run as root" 
  exit 1
else 
	echo '... done.' &&	echo
fi

#user name input
echo "user name?"
read -e -i ${SUDO_USER:-$USER} varUSER

if id "$varUSER" >/dev/null 2>&1; then
        echo && echo "... name checks out :)"
else
        echo "user does not exist"
				exit 1
fi

echo "> configure git user"
bmUID=$(id -u bmilcs) && bmGID=$(id -g bmilcs)
if [ $bmUID == 1086 ] && [ $varUSER == "bmilcs" ] || [ $varUSER != "bmilcs" ]; then
	git config --global user.name bmilcs
	git config --global user.email bmilcs@yahoo.com
	git config --global color.ui auto
fi

# install essentials
echo && echo "----  apt install: sudo | open-vm-tools | nfs-common | dnsutils | ncdu | htop -----------------------------------" && echo
apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y \
	&& apt-get install sudo ncdu htop open-vm-tools nfs-common dnsutils -y \
	&& echo && echo #unattended-upgrades apt-listchanges 

# remove grub pause on boot
echo '> removing grub pause' && echo
sed -i '/GRUB_TIMEOUT=/c\GRUB_TIMEOUT=0.1' /etc/default/grub
sed -i '/GRUB_HIDDEN_TIMEOUT=/c\GRUB_HIDDEN_TIMEOUT=0' /etc/default/grub
update-grub
echo '... done.' && echo

# add to sudoers & remove password requirement
echo '> configuring ' $varUSER ' as sudoer' && echo
usermod -aG sudo $varUSER
grep -qxF "$varUSER ALL=(ALL) NOPASSWD: ALL" /etc/sudoers || echo "$varUSER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo '... done.' && echo

# ssh
echo '> configure ssh & rsa keys'
sudo -u $varUSER mkdir -p /home/$varUSER/.ssh
sudo -u $varUSER chmod 700 /home/$varUSER/.ssh
sudo -u $varUSER touch /home/$varUSER/.ssh/authorized_keys
sudo -u $varUSER chmod 600 /home/$varUSER/.ssh/authorized_keys
grep -qxF 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== $varUSER' /home/$varUSER/.ssh/authorized_keys || echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== $varUSER' >> /home/$varUSER/.ssh/authorized_keys
sed -i '/#PermitRootLogin/c\PermitRootLogin no' /etc/ssh/sshd_config
sed -i '/#PubkeyAuthentication/c\PubkeyAuthentication yes' /etc/ssh/sshd_config
sed -i '/#PasswordAuthentication/c\PasswordAuthentication no' /etc/ssh/sshd_config
sed -i '/#AuthorizedKeysFile/c\AuthorizedKeysFile %h/.ssh/authorized_keys' /etc/ssh/sshd_config
/etc/init.d/ssh restart
echo '... done.' && echo

# crontab auto
#echo '> crontab autoupdate' && echo
#cdsudo -u $varUSER crontab ~/.bmilcs/dotfiles/other/crontab
#grep -Fq "30 1 * * * up" mycron || echo "30 1 * * * up" >> mycron
#grep -Fq "30 1 * * * up" mycron || echo "30 1 * * * up" >> mycrone
#echo '... done.' && echo
# crontab -l | grep -qF '* * up' || (crontab -l >> ~/cronny && echo '30 1 * * * up' >> ~/cronny && crontab ~/cronny && rm ~/cronny)

# custom login notice
echo '> custom ssh login msg'
# remove stock crap
sed -i '/^HUSHLOGIN_FILE \.hushlogins/c\#HUSHLOGIN_FILE .hushlogins' /etc/login.defs
sed -i '/HUSHLOGIN_FILE \//c\HUSHLOGIN_FILE /etc/hushlogins' /etc/login.defs
echo /bin/bash | sudo tee -a /etc/hushlogins
sed -i '/PrintMotd/c\PrintMotd no' /etc/ssh/sshd_config
sed -i '/PrintLastLog/c\PrintLastLog no' /etc/ssh/sshd_config
sed -i '/session    optional     pam_motd.so/c\' /etc/pam.d/sshd
# insert custom
sed -i '/#Banner none/c\Banner /etc/banner' /etc/ssh/sshd_config
touch /etc/banner # create custom banner config
echo > /etc/banner # clear if exists
#printf "%s" "--- welcome to bmilcs homelab -----------------------" >> /etc/banner
#printf "\n%s" "          host:   " >> /etc/banner
#echo $HOSTNAME "(.bm.bmilcs.com)" >> /etc/banner
#ipp="ip a | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
#eval ip=\$\($ipp\)
#printf "%s" "           lan:   " >> /etc/banner
#echo $ip >> /etc/banner
#eval wan=\$\(dig @1.1.1.1 ch txt whoami.cloudflare +short\)
#wan="${wan%\"}"
#wan="${wan#\"}"
#printf "%s" "           wan:   " >> /etc/banner
#echo $wan >> /etc/banner
#printf "%s\n\n" "-----------------------------------------------------" >> /etc/banner
#echo '... done.' && echo 
# configure git user


# change uid & gid if bmilcs
echo "> " $varUSER " uid & gid check"
if [ $bmUID == 1086 ] && [ $varUSER == "bmilcs" ] || [ $varUSER != "bmilcs" ]; then
	echo '... cheers! uid/pid is fine!'
else
	echo '... error! fixing bmilcs uid & gid'
	function checkUser {                                                            
				status=0                                                                
				for u in $(who | awk '{print $1}' | sort | uniq)                        
				do                                                                      
						if [ "$u" == "$1" ]; then                                           
										return 0                                                    
						fi                                                                  
				done                                                                    
				return 1                                                                
	}                                                                               
	checkUser $varUSER                                                         
	ret_val=$?                                                              
	if [ $ret_val -eq 0 ]; then                                                     
		echo "ERROR! "$varUSER " is logged in."
		echo && echo "====================================================================================================="
		echo "====  root login enabled temporarily - ssh back in as root  ========================================="
		echo "=====================================================================================================" && echo
		sed -i '/PermitRootLogin/c\PermitRootLogin yes' /etc/ssh/sshd_config
		sudo /etc/init.d/sshd restart
		exit 0                                                                  
	else                                                                            
		sudo usermod -u 1086 bmilcs
		sudo groupmod -g 1190 bmilcs
		sudo find / -group $bmGID -exec chgrp -h bmilcs {} \;
		sudo find / -user $bmUID -exec chown -h bmilcs {} \;                    
	fi
fi

echo '====================================================================================================='
echo '====  bmilcs debian configuration complete  ========================================================='
echo '====================================================================================================='
echo 
echo '>       open:    putty.exe'
echo '>    address:    bmilcs@'$HOSTNAME
echo
echo '====================================================================================================='



# echo '> configuring unattended-upgrades'
# printf 'APT::Periodic::Update-Package-Lists "1";\nAPT::Periodic::Unattended-Upgrade "1";\nAPT::Periodic::Download-Upgradeable-Packages "1";\nAPT::Periodic::AutocleanInterval "7";\nAPT::Periodic::Verbose "1";' > /etc/apt/apt.conf.d/20auto-upgrades
# sed -i '/"origin=/c\\t' /etc/apt/apt.conf.d/50unattended-upgrades
# sed -i '/new stable)./c\\t"o=*"' /etc/apt/apt.conf.d/50unattended-upgrades
# sed -i '/Unattended-Upgrade::Remove-New-Unused-Dependencies/c\Unattended-Upgrade::Remove-New-Unused-Dependencies "true";' /etc/apt/apt.conf.d/50unattended-upgrades
# sed -i '/Unattended-Upgrade::Remove-Unused-Kernel-Packages/c\Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";' /etc/apt/apt.conf.d/50unattended-upgrades
# sed -i '/Unattended-Upgrade::Remove-Unused-Dependencies "/c\Unattended-Upgrade::Remove-Unused-Dependencies "true";' /etc/apt/apt.conf.d/50unattended-upgrades
# sed -i '/Unattended-Upgrade::Automatic-Reboot-WithUsers "/c\Unattended-Upgrade::Automatic-Reboot-WithUsers "true";' /etc/apt/apt.conf.d/50unattended-upgrades
# sed -i '/Unattended-Upgrade::Automatic-Reboot "/c\Unattended-Upgrade::Automatic-Reboot "true";' /etc/apt/apt.conf.d/50unattended-upgrades
# sed -i '/Unattended-Upgrade::Automatic-Reboot-Time/c\Unattended-Upgrade::Automatic-Reboot-Time "01:00";' /etc/apt/apt.conf.d/50unattended-upgrades
# echo '... done.'

# sudo mkdir -p /root/.ssh
# sudo chmod 700 /root/.ssh
# sudo touch /root/.ssh/authorized_keys
# sudo chmod 600 /root/.ssh/authorized_keys
# sudo grep -qxF 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== bmilcs' /root/.ssh/authorized_keys || echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== bmilcs' >> /root/.ssh/authorized_keys
