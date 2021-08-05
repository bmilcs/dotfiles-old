adobe animation
fl studio


userdel bmilcs
groupdel bmilcs
rm -r /home/bmilcs 
echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel
groupadd -g 1190 bmilcs 2> /dev/null
groupadd -g 998 wheel 2> /dev/null
useradd -m -u 1086 -g 1190 -G wheel bmilcs
mkdir -p /home/bmilcs/.ssh
chown bmilcs:bmilcs /home/bmilcs/.ssh
passwd bmilcs
