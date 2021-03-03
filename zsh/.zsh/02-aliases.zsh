#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 ZSH: ALIASES [./02-aliases.zsh]
#   TODO
#         split up into separate .zsh files
#         add working savedir alias > select

#────────────────────────────────────────────────────────────
# DOCUMENTS
#────────────────────────────────────────────────────────────

# scratchpad
alias pad='vim $D/txt/txt/pad.md'
alias regex='vim $D/txt/txt/regex.md'

# cd path
alias txt='cd $D/txt/txt ; c ; l'
alias cf='cd ~/.config/ ; c ; l'

# dotfiles
alias bm='cd $D' # only while root
alias ali='vim $D/zsh/.zsh/02-aliases.zsh'
alias fun='vim $D/zsh/.zsh/03-functions.zsh'
alias txs='c ; tail -f ~/.xsession-errors'
alias readme='vim ~/bm/readme.md'

# configuration files
alias bsp='vim $D/opt/bspwm/.config/bspwm/bspwmrc'
alias gaps='vim $D/opt/i3/.config/i3/config'
alias keys='vim $D/opt/sxhkd/.config/sxhkd/sxhkdrc'
alias picomrc='vim $D/opt/picom/.config/picom/config'
alias termrc='vim $D/opt/alacritty/.config/alacritty/alacritty.yml'

# restarting
alias tr="tmux source ~/.tmux.conf"
alias zr="source ~/.zshrc"
alias polyr=". ~/.config/polybar/launch.sh" 
# tail -f ~/.config/polybar/log"

alias sdir='echo $PWD >> $D/txt/txt/dir_list.md'
alias odir='vim $D/txt/txt/dir_list.md'

#────────────────────────────────────────────────────────────
# DISTRO SPECIFIC
#────────────────────────────────────────────────────────────

if [[ $DISTRO = arch ]]; then # ARCH
  # aur | yay
  alias pacman='sudo pacman' ; compdef pacman='pacman'
  alias pm='pacman' ; compdef pm='pacman'
  alias pms='pacman -S';compdef pms='pacman'
  alias pmls='pacman -Qe|less';compdef pmls='pacman'
  alias pmg='pacman -Qe|grep';compdef pmg='pacman'
  alias pmgg='pacman -Q|grep';compdef pmgg='pacman'
  alias yays='yay -S';compdef yays='yay'
  alias yayls='yay -Qe | less';compdef yayls='yay'
  alias yayl='yayls';compdef yayl='yay'
  alias yayll='yay -Q | less';compdef yayll='yay'
  alias yayg='yay -Q | grep';compdef yayg='yay'
  alias yaygg='yay -Qe | grep';compdef yaygg='yay'
  alias netr='sudo systemctl restart \ 
    {systemd-networkd.service,systemd-resolved.service,iwd.service}'
else # DEBIAN
  # syslog
  alias syslogg="sudo cat /var/log/syslog | grep "
  alias syslogls="sudo cat /var/log/syslog"
fi

#────────────────────────────────────────────────────────────
# APPS
#────────────────────────────────────────────────────────────

# tmux
alias t='tmux -u'         ; compdef t='tmux'
alias ta='t a -t'         ; compdef ta='tmux'
alias tn='t new -t'       ; compdef tn='tmux'
alias tls='t ls'          ; compdef tls='tmux'

# ncdu
alias ncdu='ncdu --exclude /all --exclude /backup '

# wallpaper
alias nitrogen='nitrogen ~/wall'
alias fehbg='feh -g 640x480 -d -S filename ~/wall'

# email
alias mutt='neomutt'
alias em='neomutt'

# dotfiles
alias bmi='cd $D && ./install.sh'
alias bme='vim $D/install.sh'

# git
alias gs='$(git rev-parse) || cd $D && git status -s'
alias gss='$(git rev-parse) || cd $D && git status'
#alias g='$(git rev-parse) || cd $D && git '
#alias gd='$(git rev-parse) || cd $D && git diff'
#alias ga='$(git rev-parse) || cd $D && git add'
#alias gps='$(git rev-parse) || cd $D && git push'
#alias gpl='$(git rev-parse) || {cd $D && git submodule update --remote --merge} && git pull'

#────────────────────────────────────────────────────────────
# LS
#────────────────────────────────────────────────────────────

alias l='ls' ; compdef l="ls" 
alias ls='LC_ALL=C ls -AlhF \
  --color=auto --group-directories-first --time-style='+%D %H:%M''
  compdef ls="ls"
alias ll='LC_ALL=C command ls -AC \
  --color=auto --group-directories-first --time-style='+%D %H:%M''
  compdef lll="ls"
alias lll='command ls -l \
  --color=auto --group-directories-first --time-style='+%D %H:%M'' 
    compdef ll="ls"
alias llll='command ls -C \
  --color=auto --group-directories-first --time-style='+%D %H:%M'' 
  compdef llll="ls"
alias lst='command ls \
  --color=auto --group-directories-first --time-style='+%D %H:%M''
  compdef lst="ls"

alias lsg="ll | grep"          # search in dir
alias lsd="ll -d */"           # ls: dirs only

#────────────────────────────────────────────────────────────
# STOCK ENHANCEMENTS
#────────────────────────────────────────────────────────────

# rust replacements
alias cat="bat"                   ; compdef cat="bat"

# text editors
alias nano="nvim"                 ; compdef nano="nvim"
alias vim="nvim"                  ; compdef vim="nvim"

# colorize
alias ip="ip -color=auto"         ; compdef ip="ip"
alias grep="grep --color=auto"    ; compdef grep="grep"

# autoresume
alias wget="wget -c"              ; compdef wget="wget"

# confirmations
alias ln="ln -i"
#alias mv="mv -i"
#alias cp="cp -i"

# shortcuts
alias c="clear"
alias ..="cd ..&& c && l"
alias ...="cd ../.. && c && l"

# fzf
alias -g zz="fzf -m"

#────────────────────────────────────────────────────────────
# FILE SYSTEM
#────────────────────────────────────────────────────────────

# mount | umount
alias mount="sudo mount" ; compdef mount="mount"
alias umount="sudo umount" ; compdef umount="umount"

# fstab
alias fstab="sudo vim /etc/fstab"
dpkg -s "findmnt" > /dev/null 2>&1 && (
  alias fstabt="sudo findmnt --verify --verbose" ; compdef fstabt="findmnt")

# nfs shares
alias nfs="sudo vim /etc/exports"
alias nfsr="sudo systemctl restart nfs-kernel-server"

# smb
alias smb='sudo vim /etc/samba/smb.conf'

#────────────────────────────────────────────────────────────
# SYSTEM
#────────────────────────────────────────────────────────────

# nocorrect [zsh autocorrect > sudo] -E [respect orig env]
alias sudo="nocorrect sudo -E "
compdef sudo="sudo"

# reboot, shutdown, etc.
alias rex="sudo systemctl restart display-manager"
alias rb="sudo systemctl reboot"
alias winrb="sudo grub-reboot 2 ; reboot"
alias reboot="sudo systemctl reboot"
alias halt="sudo systemctl halt"
alias shutdown="sudo systemctl poweroff"

# systemctl
alias sc="sudo systemctl"                             ;compdef sc="systemctl"
alias scl="sc list-units --type=service --all"        ;compdef scl="systemctl"
alias scll="sc list-units --type=service"             ;compdef scll="systemctl"
alias scg="sc list-units --type=service --all | grep" ;compdef scg="systemctl"
alias scu="sc start"                                  ;compdef scu="systemctl"
alias scs="sc status"                                 ;compdef scs="systemctl"
alias scd="sc stop"                                   ;compdef scd="systemctl"

# print outs
alias a="alias | sed 's/=.*//'"
alias func="declare -f | grep '^[a-z].* ()' | sed 's/{$//'"
alias paths='echo -e ${PATH//:/\\n}'
alias hn="_a hostname && _o host: $HOST && echo"

# audio sinks
alias sinko="pacmd list-sinks | grep -e 'name:' -e 'index:'"
alias sinki="pacmd list-sources | grep -e 'index:' -e device.string -e 'name:'"

# elevate user
alias rt="sudo su"

# pid
alias pid="cat /etc/passwd"

#############################################################
#────────────────────────────────────────────────────────────
# VERSION 1.0 DOTFILES (VM use only)
#   debian-based | github.com/bmilcs/linux.git
#────────────────────────────────────────────────────────────
#############################################################
#────────────────────────────────────────────────────────────
# DOCKER
#────────────────────────────────────────────────────────────

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

#────────────────────────────────────────────────────────────
# DEBIAN CONFIGURE
#────────────────────────────────────────────────────────────

alias ideb="sudo /bin/bash ~/.bmilcs/script/debian.sh"

#────────────────────────────────────────────────────────────
# BACKUP
#────────────────────────────────────────────────────────────

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

#────────────────────────────────────────────────────────────
# GITHUB RSA KEY
#────────────────────────────────────────────────────────────

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

#────────────────────────────────────────────────────────────
# DEBIAN NETWORKING
#────────────────────────────────────────────────────────────

#alias rnet="sudo /etc/init.d/networking restart"
#alias enet="sudo vim /etc/network/interfaces"


#################################################################
# GRAVEYARD
#################################################################

#────────────────────────────────────────────────────────────
# DOCKER
#────────────────────────────────────────────────────────────

# alias dcr='cd /tmp && rm -rf /tmp/docker && git clone git@github.com:bmilcs/docker.git /tmp/docker && cd /tmp/docker && rm -f ~/docker/docker-compose.yaml ~/docker/.env && cp 1docker-compose.yaml .env ~/docker/ && cd ~/docker && mv 1docker-compose.yaml docker-compose.yaml &&  docker-compose up -d --remove-orphans'

#────────────────────────────────────────────────────────────
# GIT BARE REPO
#────────────────────────────────────────────────────────────

# alias gitt="/usr/bin/git --git-dir=$HOME/.git/ --work-tree=$HOME"
# alias gitp="gitt commit -a -m 'update' && gitt push"
# compdef gitt="git"
# compdef gitp="git"
