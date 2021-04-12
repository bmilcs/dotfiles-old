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

# dotfile rc file debugging
. "${HOME}/bin/sys/dotfile_logger"
dotlog '+ $ZDOTDIR/02-aliases.zsh'

#────────────────────────────────────────────────────────────
# TEXT
#────────────────────────────────────────────────────────────

# scratchpad
alias pad='vim $D/txt/txt/pad.md'
alias regex='vim $D/txt/txt/regex.md'

# cd path
alias cf='cd ~/.config/ ; c ; l'

# dotfiles
alias bm='cd $D' # only while root
alias ali='vim "$ZDOTDIR/02-aliases.zsh"'
alias fun='vim "$ZDOTDIR/03-functions.zsh"'
alias txs='c ; tail -f ~/.xsession-errors'
alias readme='vim ~/bm/readme.md'

# configuration files
alias bsp='vim $D/opt/bspwm/.config/bspwm/bspwmrc'
alias gaps='vim $D/opt/i3/.config/i3/config'
alias keys='vim $D/opt/sxhkd/.config/sxhkd/sxhkdrc'
alias picomrc='vim $D/opt/picom/.config/picom/config'
alias termrc='vim $D/opt/alacritty/.config/alacritty/alacritty.yml'

# restarting
alias trc="tmux source ~/.tmux.conf"
alias zr='source "$ZDOTDIR"/.zshrc'
alias polyr=". ~/.config/polybar/launch.sh"

#────────────────────────────────────────────────────────────
# DISTRO SPECIFIC
#────────────────────────────────────────────────────────────

alias rmup="rm -rf ~/.config/up/"

if [[ $DISTRO = "arch"* ]]; then # ARCH
  # aur | yay
  alias pacman='sudo pacman';compdef pacman='pacman'
  alias pm='pacman';compdef pm='pacman'
  alias pms='pacman -S';compdef pms='pacman'
  alias pmls='pacman -Qe|yay';compdef pmls='pacman'
  alias pmg='pacman -Qe|grep';compdef pmg='pacman'
  alias pmgg='pacman -Q|grep';compdef pmgg='pacman'
  alias yays='yay -S';compdef yays='yay'
  alias yayls='yay -Qe | fzf';compdef yayls='yay'
  alias yayl='yayls';compdef yayl='yay'
  alias yayll='yay -Q | fzf';compdef yayll='yay'
  alias yayg='yay -Q | grep';compdef yayg='yay'
  alias yaygg='yay -Qe | grep';compdef yaygg='yay'
  alias yayc='yay -Sc --aur';compdef yaygg='yay'
  # arch specific
  alias rnet="sudo systemctl restart {systemd-networkd.service,systemd-resolved.service,iwd.service}"
  alias cdns="sudo systemd-resolve --flush-caches"
  alias xc='xclip -selection clipboard'
  alias xp='xclip -selection clipboard -o'
  alias xcc='xclip -selection primary'
  alias xpp='xclip -selection primary -o'
  alias cat="bat";compdef cat="bat"
  alias g6='go-mtpfs ~/.android & ; cd ~/.android/Internal shared storage/DCIM'

else # DEBIAN
  # syslog
  alias syslogg="sudo cat /var/log/syslog | grep "
  alias syslogls="sudo cat /var/log/syslog"
  alias apti='sudo apt-get install -y'
  alias aptr='sudo apt-get purge -y'
  alias aptg='dpkg --get-selections | grep'
  alias aptls='sudo apt list --installed'
fi

#────────────────────────────────────────────────────────────
# APPS
#────────────────────────────────────────────────────────────

# rsync
alias rscp='rsync -zahv --progress --partial'
alias rsmv='rscp --remove-source-files'
alias rsdirstructure='rsync -av -f"+ */" -f"- *"'

# ranger
alias ranger='ranger --choosedir=$HOME/.config/ranger/sdir; \
  LASTDIR=`cat $HOME/.config/ranger/sdir`; cd "$LASTDIR"'
alias rr='ranger'

# xev keycodes
alias kc='xev | grep -o "keycode[^\)]\+"'
alias kcc='xmodmap -pke | fzf'

# tmux
alias t='tmux -u'         ; compdef t='tmux'        # tmux, UTF-8
alias ta='t a -t'         ; compdef ta='tmux'       # attach to target name
alias tn='t new -t'       ; compdef tn='tmux'       # new session, target name
alias tls='t ls'          ; compdef tls='tmux'      # list sessions


# ncdu
alias ncdu='ncdu --exclude /all --exclude /backup '

# wallpaper
alias nitro='nitrogen ~/wall'
alias fehbg='feh -g 640x480 -d -S filename ~/wall'

# email
alias mutt='neomutt'
alias em='neomutt'

# dotfiles
alias bmi='cd $D && ./install.sh'
alias bme='vim $D/install.sh'

# git
alias gs='$(git rev-parse > /dev/null 2>&1) || cd $D && git status -s'
alias gss='$(git rev-parse > /dev/null 2>&1) || cd $D && git status'
alias greb='$(git rev-parse > /dev/null 2>&1) || cd $D && git rebase && gp'
alias grebc='$(git rev-parse > /dev/null 2>&1) || cd $D && git rebase --continue && gp'
alias gcc='$(git rev-parse > /dev/null 2>&1) || cd $D && git commend --amend --no-edit'
alias gca='gcc'
alias glog='glo'
alias gps='$(git rev-parse > /dev/null 2>&1) || cd $D && git push'
alias gpl='$(git rev-parse > /dev/null 2>&1) || {cd $D && git submodule update --remote --merge} && git pull'
alias gd='$(git rev-parse > /dev/null 2>&1) || cd $D && forgit::diff --staged'
#alias gd='$(git rev-parse) || cd $D && git diff'
#alias g='$(git rev-parse) || cd $D && git '
#alias ga='$(git rev-parse) || cd $D && git add'

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

alias lst="l -tr" ; compdef lst="ls"

alias lsg="l | grep"          # search in dir
alias lsd="l -d */"           # ls: dirs only

#────────────────────────────────────────────────────────────
# STOCK ENHANCEMENTS
#────────────────────────────────────────────────────────────

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
# alias -g zz="fzf -m"

#────────────────────────────────────────────────────────────
# FILE SYSTEM
#────────────────────────────────────────────────────────────

# mount | umount
alias mav="sudo mount" ; compdef mount="mount"
alias umav="sudo umount" ; compdef umount="umount"

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
alias sudo="nocorrect sudo -E ";compdef sudo="sudo"
alias s="sudo";compdef s="sudo"

# reboot, shutdown, etc.
alias rex="sudo systemctl restart display-manager"
alias rb="sudo systemctl reboot"
alias winrb="sudo grub-reboot 2 ; reboot"
alias reboot="sudo systemctl reboot"
alias halt="sudo systemctl halt"
alias shutdown="sudo systemctl poweroff"

# systemctl
alias sc="sudo systemctl"                               ;compdef sc="systemctl"
alias scu="systemctl --user"                            ;compdef scu="systemctl"
alias scl="sc list-units --type=service --all"          ;compdef scl="systemctl"
alias scul="scu list-units --type=service --all"        ;compdef scul="systemctl"
alias scll="sc list-units --type=service"               ;compdef scll="systemctl"
alias scull="scu list-units --type=service"             ;compdef scull="systemctl"
alias scg="sc list-units --type=service --all | grep"   ;compdef scg="systemctl"
alias scug="scu list-units --type=service --all | grep" ;compdef scug="systemctl"
alias scon="sc start"                                   ;compdef scup="systemctl"
alias scuon="scu start"                                 ;compdef scuup="systemctl"
alias scr="sc restart"                                  ;compdef scup="systemctl"
alias scur="scu restart"                                ;compdef scuup="systemctl"
alias scs="sc status"                                   ;compdef scs="systemctl"
alias scus="scu status"                                 ;compdef scus="systemctl"
alias scoff="sc stop"                                   ;compdef scd="systemctl"
alias scuoff="scu stop"                                 ;compdef scud="systemctl"
alias sce="sc enable"                                   ;compdef scud="systemctl"
alias scue="scu enable"                                 ;compdef scud="systemctl"
alias scd="sc disable"                                  ;compdef scud="systemctl"
alias scud="scu disable"                                ;compdef scud="systemctl"

# print outs
alias a="alias | sed 's/=.*//'"
alias func="declare -f | grep '^[a-z].* ()' | sed 's/{$//'"
alias paths='echo -e ${PATH//:/\\n}'
alias hn="echo $HOST"

# audio sinks
alias sinko="pacmd list-sinks | grep -e 'name:' -e 'index:'"
alias sinki="pacmd list-sources | grep -e 'index:' -e device.string -e 'name:'"

# pid
alias pid="cat /etc/passwd"

#────────────────────────────────────────────────────────────
# SSH SHORTCUTS
#────────────────────────────────────────────────────────────
alias doc="ssh docker"
alias plx="ssh plex"
alias ans="ssh bmdev@ansible"

#############################################################
#############################################################
#     VERSION 1.0 DOTFILES (early days of linux)
#       debian-based vm's | github.com/bmilcs/linux.git
#       TODO: review & optimize
#############################################################
#############################################################

#────────────────────────────────────────────────────────────
# DOCKER
#────────────────────────────────────────────────────────────

if where docker-compose > /dev/null; then

  # edit bmilcs.com
  alias wwwe='vim ~/docker/swag/config/nginx/site-confs/bmilcs.conf'

  # edit docker-compose
  alias dce='vim ~/docker/docker-compose.yaml'

  # docker logs
  alias dclog='cd ~/docker && docker-compose \
    -f ~/docker/docker-compose.yaml logs -tf --tail="50"'

  # letsencrypt restart
  alias le="docker restart swag && docker logs -f swag"
  alias swag="le"

  # docker-compose
  alias dcup="cd ~/docker && docker-compose up -d" #;compdef dcs='docker'
  alias dcstop="cd ~/docker && docker-compose stop" #;compdef dcstop='docker stop '
  alias dcrestart="cd ~/docker && docker-compose restart" #;compdef dcrestart='docker restart '
  alias dcdown="cd ~/docker && docker-compose down" #;compdef dcdown='docker down'
  alias dcinfo='docker system df'

  # list all dockers
  alias dps='docker ps -a \
    --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}" \
    | (read -r; printf "%s\n" "$REPLY"; sort -k 2  )'
  alias dnet='docker network ls'

  # CLEANING

  # clean up docker system
  alias dclean='dcleani && dcleane'
  alias dcleani='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'
  alias dcleane='docker rm $(docker ps -qa --no-trunc --filter "status=exited")'

  # stop all containres
  alias dcsa='docker stop $(docker ps -a -q)'

  # remove unused: containers | vol | networks | etc
  alias dcnukeold='docker system prune -af'
  
  # remove nfs share volumes
  alias dcnukev='docker volume rm $(docker volume ls | grep docker_)'

  # remove all containers
  alias dcnukec='docker rm $(docker ps -a -q)'

  # remove all images
  alias dcnukei='docker rmi $(docker images -a -q)'

  # nuke ALL: containers | volumes | images
  alias dcnukeall="dcsa && dcnukec && dcnukei && dcnukev"

  # beets
  alias beetsdl="docker exec -u abc -it beets /bin/bash -c 'beet import /downloads/usenet/complete/music'"

fi

#────────────────────────────────────────────────────────────
# DEBIAN CONFIGURE
#────────────────────────────────────────────────────────────

if [[ $DISTRO == "debian" ]]; then
  alias ideb="sudo /bin/bash ~/.bmilcs/script/debian.sh"

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
fi
#────────────────────────────────────────────────────────────
# BACKUP
#────────────────────────────────────────────────────────────

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
