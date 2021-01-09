#
# ALIASES
# -bmilcs
#

# TODO: split up into separate .zsh files

#
# PACKAGE MANAGER 
#

# update
  # TODO conditional update | distro based
alias up="pm -Syyuu ; yay -Syyuu"

# pacman
alias pacman="sudo pacman"
      compdef pacman="pacman"
alias pm="pacman"
      compdef pm="pacman"
alias pmls="pacman -Qe | less"
      compdef pmls="pacman"
alias pmg="pacman -Qe|grep"
      compdef pmg="pacman"

# aur | yay
alias yayls="yay -Qe | less"
      compdef yayls="yay"
alias yayg="yay -Qe | grep"
      compdef yayg="yay"

#
# GITHUB | DOTFILE REPO
#

alias gt="git --git-dir=$D/.git --work-tree $D" 
      compdef gt="git"
alias gtp="gt push "
      compdef gtp="git"
#
# TMUX
#

alias t="tmux"
      compdef t="tmux"
alias ta="t a -t"
      compdef ta="tmux"
alias tls="t ls"
      compdef tls="tmux"
alias tn="t new -t"
      compdef tn="tmux"

#
# TEXT EDITING
#

# nano -> vim
alias nano="vim"
      compdef nano="vim"

# scratchpad
alias pad="vim ~/bm/txt/scratchpad.md"
alias sdir="echo $PWD >> ~/bm/txt/scratchpad.md" # TODO fix > function required?
alias regex="vim ~/bm/txt/regex.md"

# dotfile repo: readme
alias readme="vim ~/bm/readme.md"

# dotfiles
alias bm="cd $D"	# only while root
alias ali="vim ~/.zsh/02-aliases.zsh"
alias fun="vim ~/.zsh/03-functions.zsh"
alias tmuxr="tmux source ~/.tmux.conf"
alias tmuxrc="vim ~/.tmux.conf"
alias vimrc="vim ~/.vim/10-organize-me.vim"
alias zshr="source ~/.zshrc"
alias zshrc="vim ~/.zshrc"

# configuration files
alias bsp="vim ~/.config/bspwm/bspwmrc"
alias gaps="vim ~/.config/i3/config"
alias keys="vim ~/.config/sxhkd/sxhkdrc"
alias picomrc="vim ~/.config/picom/config"
alias poly="vim ~/.config/polybar/bspwm.conf"
alias polysh="vim ~/.config/polybar/bspwm.sh"
alias polyr="polybar -r -c ~/.config/polybar/bspwm.conf bspwm"
alias termrc="vim ~/.config/alacritty/alacritty.yml"

#
# APPLICATIONS
#

# mutt
alias mutt="neomutt -F ~/.config/mutt/muttrc"

# wallpaper
alias nitrogen="nitrogen ~/wall"
alias fehbg="feh -g 640x480 -d -S filename ~/wall"

#
# BASH
#

# ls 
alias ls="ls --color -lhF --group-directories-first --time-style=+\"%Y-%m-%d %H:%M:%S\""
      compdef ls="ls"
alias l="ls -A" # long, all, abc puid
      compdef l="ls"
alias ll="ls -nA" #long, all, # puid
      compdef ll="ls"
alias lll="ls" 
      compdef lll="ls"
alias lsf="ls -A | grep -v '^d'"	#ls files,,
alias lsd="ls -Ald */"   # ls, long, dir
alias lsg="ls -A | grep" #search in dir

# command tweaks
#alias mv="mv -i"    #confirmation
#alias cp="cp -i"    #confirmation
alias ln="ln -i"    #confirmation
alias ip="ip -color=auto"      # color
alias grep="grep --color=auto" # color
alias wget="wget -c"					 # autoresume

# shortcuts
alias c="clear"
alias ..="cd ..&& c && l"
alias ...="cd ../.. && c && l"
alias ....="cd ../../.. && c && l"

# fzf
alias -g zz="fzf -m"

#
# FILE SYSTEM
#

# mount | umount
alias mount="sudo mount"
      compdef mount="mount"
alias umount="sudo umount"
      compdef umount="umount"

# fstab
 alias fstab="sudo vim /etc/fstab"
 alias fstabt="sudo findmnt --verify --verbose"
       compdef fstabt="findmnt"

# nfs shares
alias nfs="sudo vim /etc/exports"
alias nfsr="sudo systemctl restart nfs-kernel-server"

# smb
alias smb='sudo vim /etc/samba/smb.conf'

#
# SYSTEM
#

# reboot, shutdown, etc.
alias rex="sudo systemctl restart display-manager"
alias winrb="sudo grub-reboot 2 ; reboot"
alias rb="sudo systemctl reboot"
alias reboot="sudo systemctl reboot"
alias shutdown="sudo systemctl poweroff"
alias halt="sudo systemctl halt"

# print outs
alias a="alias | sed 's/=.*//'"
alias func="declare -f | grep '^[a-z].* ()' | sed 's/{$//'"
alias paths='echo -e ${PATH//:/\\n}'

# audio sinks
alias sinko="pacmd list-sinks | grep -e 'name:' -e 'index:'"
alias sinki="pacmd list-sources | grep -e 'index:' -e device.string -e 'name:'"

# update grub
alias upgrub=""

# swap users
alias rt="sudo -s"

# syslog
alias syslogg="sudo cat /var/log/syslog | grep "
alias syslogls="sudo cat /var/log/syslog" 

# pid
alias pid="cat /etc/passwd"

# services
alias svls="sudo systemctl list-units --type=service --all"
alias svlsa="sudo systemctl list-units --type=service"
alias svg="sudo systemctl list-units --type=service --all | grep"
alias svstart="sudo systemctl start"
alias svr="sudo systemctl status"
alias svstop="sudo systemctl stop"

###################################################
###################################################
# DOTFILES v1.0 CONTENT
#   debian vm's | bmilcs/linux.git
#   TODO clean up > split into functions > rewrite
###################################################
###################################################

#
# DEBIAN CONFIGURE
#

alias ideb="sudo /bin/bash ~/.bmilcs/script/debian.sh"

#
# BACKUP 
#

alias ibak="upp ; sudo /bin/bash ~/.bmilcs/script/backup.sh install $USER ; source ~/.bashrc"
alias ibakls="sudo cat /etc/rsnapshot.conf | grep ^backup"
alias ibakadd="sudo /bin/bash ~/.bmilcs/script/backup.sh add"
alias rsnap="sudo vim /etc/rsnapshot.conf"

# minecraft

alias mine="/opt/minecraft/tools/mcrcon/mcrcon -H 127.0.0.1 -P 25575 -p nFkA_vKG8FTP2v@K9YdPA6utw -t"

# install nfs
# TODO > FUNCTION conversion

alias infs='
	sudo apt install nfs-kernel-server 
	echo && echo "====================================================================================================="
	echo "====  bmilcs: nfs instructions  ====================================================================="  && necho "=====================================================================================================" && echo
	echo "sudo vim /etc/exports"
	echo "#path/to/dir          10.0.0.0/8(ro,sync)\"
	echo "-----------------------------------------------------------------------------------------------------"'

# install smb
# TODO > function conversion

alias ismb='
	sudo apt install samba
	echo && echo "====================================================================================================="
	echo "====  bmilcs: samba instructions  ==================================================================="
	echo "=====================================================================================================" && echo
	echo "sudo vim /etc/samba/smb.conf"
	echo "#       workgroup = BM"
	echo "#       interfaces = 192.168.1.0/24 eth0"
	echo "#       hosts allow = 127.0.0.1/8 192.168.1.0/24"
	echo "# [docker]"
	echo "#         comment = docker vm config files"
	echo "#         path = /home/bmilcs/docker"
	echo "#         browseable = yes"
	echo "#         read only = no"
	echo "#         guest ok = no"
	echo "#         valid users = bmilcs"
	echo "-----------------------------------------------------------------------------------------------------"		'

#
# GITHUB RSA KEY
#

alias gitkeys='
	git config --global user.name bmilcs
	git config --global user.email bmilcs@yahoo.com
	git config --global color.ui auto
	mkdir -m 700 -p ~/.ssh
	curl -s https://github.com/bmilcs.keys >> ~/.ssh/authorized_keys
  chmod 600 ~/.ssh/authorized_keys
	eval "$(ssh-agent -s)"
	echo "> enter github private key as follows:"
	echo "  ssh-add ~/.ssh/id_github"'

#
# DEBIAN NETWORKING
#

alias rnet="sudo /etc/init.d/networking restart"
alias enet="sudo vim /etc/network/interfaces"

#
# DOCKER
#

# remove unused: containers | vol | networks | etc
alias drmu='docker system prune -a'

# remove all containers
alias drmc='docker rm $(docker ps -a -q)'

# remove all images
alias drmi='docker rmi $(docker images -a -q)'

# stop all containres
alias dstop='docker stop $(docker ps -a -q)'

# clean up docker system
alias dcln='docker image prune -a ; docker container prune ; docker volume prune ; docker network prune'

# remove nfs share volumes
alias dvol='
	volz="audiobooks cloud dl movies music plexlog podcasts tv"
	for vz in $volz
	do
		docker volume rm docker_${vz}
	done
	'

# remove: containers | volumes
alias dnew="dstop;drmc;dvol;"

# nuke all
alias dnuke="dstop;drmc;dvol;drmi"

# docker logs
alias dclog='docker-compose -f ~/docker/docker-compose.yaml logs -tf --tail="50"'

# docker-compose
alias dcs="docker-compose stop"
alias dcre="docker-compose restart"
alias dcd="docker-compose down"

# list all dockers
alias dps='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}" | (read -r; printf "%s\n" "$REPLY"; sort -k 2  )'
alias dnet='docker network ls'

# letsencrypt restart
alias le="docker restart swag && docker logs -f swag"
alias swag="docker restart swag && docker logs -f swag"
alias ddf='docker system df'


#################################################################
# GRAVEYARD
#################################################################

#
# DOCKER
#

# alias dcr='cd /tmp && rm -rf /tmp/docker && git clone git@github.com:bmilcs/docker.git /tmp/docker && cd /tmp/docker && rm -f ~/docker/docker-compose.yaml ~/docker/.env && cp 1docker-compose.yaml .env ~/docker/ && cd ~/docker && mv 1docker-compose.yaml docker-compose.yaml &&  docker-compose up -d --remove-orphans'

#
# GIT BARE REPO
#

# alias gitt="/usr/bin/git --git-dir=$HOME/.git/ --work-tree=$HOME"
# alias gitp="gitt commit -a -m 'update' && gitt push"
# compdef gitt="git"
# compdef gitp="git"
