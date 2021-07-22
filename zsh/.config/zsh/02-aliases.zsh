#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 ZSH: ALIASES [./02-aliases.zsh]

#   TODO

#         split up into separate .zsh files
#         add working savedir alias > select

# dotfile rc file debugging
. "${HOME}/bin/sys/dotfile_logger"
dotlog '+ $ZDOTDIR/02-aliases.zsh'

#───────────────────────────────────────────────────  disable built-in  ───────

unalias gi 
unalias ga

#───────────────────────────────────────────────────────────────  misc  ───────

# homebrew switch
alias nin='./fusee-launcher.py hekate-5.1.1.bin'

# cloudflare
alias cfdc='sh ~/.ssh/cloudflare/nginx'
alias cfadd='sh ~/.ssh/cloudflare/add'
alias cfdel='sh ~/.ssh/cloudflare/del'
alias cfinfo='sh ~/.ssh/cloudflare/info'

# generate pw hash
alias pwhash='openssl passwd -6 '

alias fdd='fd -H -E /all -E /vault '

#───────────────────────────────────────────────────────────────  text  ───────

# text editors
alias nano='nvim'                 ; compdef nano='nvim'
alias vim='nvim'                  ; compdef vim='nvim'
alias svim='s vim'                ; compdef svim='nvim'
#alias svim='sudoedit'             ; compdef svim='nvim'
alias vmf='nvim $(fzf --exit-0)'  ; compdef vmf='nvim'

# dotfiles repo
alias bmi='cd $BM && ./install.sh'
alias bmPi='cd $BMP && ./install.sh'
alias bme='vim $BM/install.sh'
alias bmPe='vim $BMP/install.sh'

# scratchpad
alias pad='vim $D/txt/txt/pad.md'
alias apad='vim ~/ans/readme.md'
alias regex='vim $D/txt/txt/regex.md'

# cd path
alias cf='cd ~/.config/ ; c ; l'

# dotfiles
alias bm='cd $D' # only while root
alias ali='vim "$ZDOTDIR/02-aliases.zsh"'
alias fun='vim "$ZDOTDIR/03-functions.zsh"'
alias txs='c ; tail -f ~/.xsession-errors'
alias readme='vim ~/bm/readme.md'
alias txt='nvim -c VimwikiIndex'
alias wiki='txt'
#alias txt='cd ~/txt && nvim $(fzf)'

# configuration files
alias bsp='vim $D/opt/bspwm/.config/bspwm/bspwmrc'
alias gaps='vim $D/opt/i3/.config/i3/config'
alias i3keys='command i3keys web 8080 & ;\
              firefox -new-tab http://localhost:8080'
alias keys='vim $D/opt/sxhkd/.config/sxhkd/sxhkdrc'
alias picomrc='vim $D/opt/picom/.config/picom/config'
alias termrc='vim $D/opt/alacritty/.config/alacritty/alacritty.yml'

# restarting
alias trc='tmux source ~/.tmux.conf'
alias zr='source '$ZDOTDIR'/.zshrc'
alias polyr='. ~/.config/polybar/launch.sh'
alias picomr='killall -9 picom ; picom -bc --experimental-backends --show-all-xerrors --config ~/.config/picom/config'
alias mpdr='[ ! -s ~/.config/mpd/pid ] && plog mpd && mpd &>> "$log"_mpd &'

# rm auto-update status
alias rmup='rm -rf ~/.config/up/'
alias upp='rmup && . $ZDOTDIR/05-update.sh'

# zsh print registered commands
alias zall='zle -al | fzf'

# nocorrect [zsh autocorrect > sudo] -E [respect orig env]
alias sudo='nocorrect sudo -E ';compdef sudo='sudo'
#──────────────────────────────────────────────────────────  ARCHLINUX  ───────

if [[ $DISTRO = "arch"* ]]; then # ARCH

  # pacman
  alias pacman='sudo pacman';compdef pacman='pacman'
  alias pm='pacman';compdef pm='pacman'
  alias pms='pacman -S';compdef pms='pacman'
  alias pmls='pacman -Qe|yay';compdef pmls='pacman'
  alias pmg='pacman -Qe|grep';compdef pmg='pacman'
  alias pmgg='pacman -Q|grep';compdef pmgg='pacman'
  alias pmsize='expac -HM "%m|%n" | sort -h | tail -n 30 | column -s "|" -t -o "___"'

  # yay
  alias yays='yay -S';compdef yays='yay'
  alias yayls='yay -Qe | fzf';compdef yayls='yay'
  alias yayl='yayls';compdef yayl='yay'
  alias yayll='yay -Q | fzf';compdef yayll='yay'
  alias yayg='yay -Q | grep';compdef yayg='yay'
  alias yaygg='yay -Qe | grep';compdef yaygg='yay'
  alias yaycln='yay -Sc --aur';compdef yayc='yay'
  alias pmreport='pacreport --unowned-files'

  alias cdns='sudo systemd-resolve --flush-caches'
  alias rdns='cdns'

  alias xc='xclip -sel clip'
  alias xp='xclip -sel clip -o'
  alias xcc='xclip -sel primary'
  alias xpp='xclip -sel primary -o'

  alias cat='bat';compdef cat='bat'

  # alias g6='go-mtpfs ~/.android & ; cd ~/.android/Internal shared storage/DCIM'

else #─────────────────────────────────────────────────  DEBIAN UBUNTU  ───────

  # ufw
  alias ufw='sudo ufw'; compdef ufw='ufw'

  # syslog
  alias syslogg='sudo cat /var/log/syslog | grep '
  alias syslogls='sudo cat /var/log/syslog'

  # apt
# alias apti='sudo apt-get install -y'
# alias aptr='sudo apt-get purge -y'
# alias aptg='dpkg --get-selections | grep'
# alias aptls='sudo apt list --installed'

fi

#──────────────────────────────────────────────────────  HOST SPECIFIC  ───────

if [[ $HOST == mc ]]; then
  alias mine='/opt/minecraft/tools/mcrcon/mcrcon -H 127.0.0.1 -P 25575 -p <password> -t'
  alias mce='svim /etc/systemd/system/minecraft.service'
  alias mcr='scr minecraft.service'
  alias mcs='scs minecraft.service'
fi

if [[ $HOST == mpd ]]; then

  # beets
  alias beete='vim ~/.config/beets/config.yaml'
  alias beetcd='cd /all/media/audio'
  alias beeti='beet import -ql /all/media/audio/beets/$(date +%m.%d-%H.%M.%S).log '

fi

#───────────────────────────────────────────────────────────────  APPS  ───────

alias rnet='sudo systemctl restart {systemd-networkd.service,systemd-resolved.service,iwd.service} && ip a'

# rsync
alias rscp='rsync -zahv --progress --partial'
alias rsmv='rscp -zahv --progress --remove-source-files'
alias rsdirstructure='rsync -av -f"+ */" -f"- *"'

# ranger
alias ranger='ranger --choosedir=$HOME/.config/ranger/sdir; \
  LASTDIR=`cat $HOME/.config/ranger/sdir`; cd "$LASTDIR"'
alias rr='ranger'

# xev keycodes
alias kc='command xev | grep -o "keycode[^\)]\+"'
alias xev='kc'
alias kcc='xmodmap -pke | fzf'

# tmux
alias t='tmux -u'         ; compdef t='tmux'        # tmux, UTF-8
alias ta='t a -t'         ; compdef ta='tmux'       # attach to target name
alias tn='t new -t'       ; compdef tn='tmux'       # new session, target name
alias tls='t ls'          ; compdef tls='tmux'      # list sessions

# ncdu
alias ncdu='ncdu --exclude /all --exclude /backup --exclude /vault'

# wallpaper
alias nitro='nitrogen ~/wall'
alias fehbg='feh -g 640x480 -d -S filename ~/wall'

# email
alias mutt='neomutt'
alias em='neomutt'

#────────────────────────────────────────────────────────────────  git  ───────

alias grevp='git rev-parse > /dev/null 2>&1'
alias gcl='git clone --depth=1'
alias g='grevp         || git' ; compdef g='git'
#alias ga='$(grevp)     || cd $D && forgit::add'
alias gs='$(grevp)     || cd $D && git status -s'
alias gss='$($grevp)   || cd $D && git status'
alias greb='$($grevp)  || cd $D && git rebase && gp'
alias grebc='$($grevp) || cd $D && git rebase --continue && gp'
alias gcc='$($grevp)   || cd $D && git commend --amend --no-edit'
alias gca='gcc'
alias glog='glo'
alias gps='$($grevp)   || cd $D && git push'
alias gpl='$($grevp)   || {cd $D && git submodule update --remote --merge} && git pull'
alias gd='$($grevp)    || cd $D && forgit::diff --staged'
alias gdd='$($grevp)    || cd $D && forgit::diff'
alias guser='git config user.name bmilcs \
             && git config user.email bmilcs@yahoo.com \
             && git config color.ui auto'

#─────────────────────────────────────────────────────────────────  ls  ───────

alias ls='LC_ALL=C ls -AlhF --color=auto --group-directories-first \
  --time-style='+%D %H:%M'' ; compdef ls='ls'

alias l='ls' ; compdef l='ls'
alias ll='LC_ALL=C command ls -AC --color=auto --group-directories-first \
  --time-style='+%D %H:%M'' ; compdef ll='ls'
alias lll='command ls -l --color=auto --group-directories-first \
  --time-style='+%D %H:%M'' ; compdef lll='ls'
alias llll='command ls -C --color=auto --group-directories-first \
  --time-style='+%D %H:%M'' ; compdef llll='ls'

alias lst='l -tr'             # modified, reverse
alias lsg='l | grep'          # grep ls output
alias lsd='l -d */'           # ls only dirs 

#─────────────────────────────────────────────────  stock enhancements  ───────

# rm -rf verbose
alias rM='rm -rfv'

# colorize
alias ip='ip -color=auto'         ; compdef ip='ip'
alias grep='grep --color=auto'    ; compdef grep='grep'

# autoresume
alias wget='wget -c'              ; compdef wget='wget'

# confirmations
alias ln='ln -i'
alias mv='mv -v'
alias cp='cp -v'

# shortcuts
alias c='clear'
alias ..='cd ..&& c && l'
alias ...='cd ../.. && c && l'
alias s='sudo';compdef s='sudo'

# fzf
# alias -g zz='fzf -m'

#────────────────────────────────────────────────────────  FILE SYSTEM  ───────

# mount | umount
alias nfsls='echo "\n\nnfs shares: ${GRN}${B}mounted\n${BLU}$ mount -l | grep nfs\n" &&\
  sudo mount -l | grep nfs'
alias umountnfs='sudo umount -t nfs -t nfs4 -av &&\
  echo "\n\nnfs shares: ${RED}${B}unmounted\n${BLU}$ mount -l | grep nfs\n" &&\
  mount -l | grep nfs'
alias smnt='sudo mount -av'
alias sumnt='sudo umount'

# fstab
alias fstab='svim /etc/fstab'
dpkg -s 'findmnt' > /dev/null 2>&1 && (
  alias fstabt='sudo findmnt --verify --verbose' ; compdef fstabt='findmnt')

# nfs shares
alias nfs='svim /etc/exports'
alias nfsr='sudo systemctl restart nfs-kernel-server'

# smb
alias smb='svim /etc/samba/smb.conf'

#─────────────────────────────────────────────────────────────  SYSTEM  ───────

# reboot, shutdown, etc.
alias rex='sudo systemctl restart display-manager'
alias rb='sudo systemctl reboot'
alias winrb='sudo grub-reboot 2 ; reboot'
alias reboot='sudo systemctl reboot'
alias halt='sudo systemctl halt'
alias shutdown='sudo systemctl poweroff'

# systemctl
alias fzn='fzf --no-preview'

alias sc='sudo systemctl'                               ;compdef sc='systemctl'
alias scu='systemctl --user'                            ;compdef scu='systemctl'

alias scl='sc list-units --type=service --all'          ;compdef scl='systemctl'
alias scul='scu list-units --type=service --all'        ;compdef scul='systemctl'

alias scll='sc list-units --type=service'               ;compdef scll='systemctl'
alias scull='scu list-units --type=service'             ;compdef scull='systemctl'

alias scf='sc list-units --failed'                      ;compdef scf='systemctl'
alias scuf='scu list-units --failed'                    ;compdef scuf='systemctl'

alias scg='sc list-units --type=service --all | grep'   ;compdef scg='systemctl'
alias scug='scu list-units --type=service --all | grep' ;compdef scug='systemctl'

alias scstart='sc start'                                ;compdef scstart='systemctl'
alias scustart='scu start'                              ;compdef scustart='systemctl'

alias scr='sc restart'                                  ;compdef scr='systemctl'
alias scur='scu restart'                                ;compdef scur='systemctl'

alias sci='sc cat'                                      ;compdef sci='systemctl'
alias scui='scu cat'                                    ;compdef scui='systemctl'

alias scs='sc status'                                   ;compdef scs='systemctl'
alias scus='scu status'                                 ;compdef scus='systemctl'

alias scstop='sc stop'                                  ;compdef scstop='systemctl'
alias scustop='scu stop'                                ;compdef scustop='systemctl'

alias sce='sc enable'                                   ;compdef sce='systemctl'
alias scue='scu enable'                                 ;compdef scue='systemctl'

alias scedit='sc edit'                                  ;compdef scedit='systemctl'
alias scuedit='scu edit'                                ;compdef scuedit='systemctl'

alias scd='sc disable'                                  ;compdef scd='systemctl'
alias scud='scu disable'                                ;compdef scud='systemctl'

alias scdr='sc daemon-reload'                           ;compdef scdr='systemctl'
alias scudr='scu daemon-reload'                         ;compdef scudr='systemctl'

alias jc='sudo journalctl '                             ;compdef jc='journalctl'
alias jcx='sudo journalctl -xe'                         ;compdef jcx='journalctl'
alias jcs='sudo journalctl -eu '                      ;compdef jcs='systemctl'
alias jcus='journalctl --user -eu '                          ;compdef jcus='systemctl'

#─────────────────────────────────────────────────────────  PRINT OUTS   ──────

alias aliass="alias | sed 's/=.*//'"
alias func="declare -f | grep '^[a-z].* ()' | sed 's/{$//'"
alias paths='echo -e ${PATH//:/\\n}'
alias hn='echo $HOST'

# audio sinks
alias sinko='pacmd list-sinks | grep -e "name:" -e "index:"'
alias sinki='pacmd list-sources | grep -e "index:" -e device.string -e "name:"'

# pid
alias pid='cat /etc/passwd | sort | column -t -s ":" -o " "'

#────────────────────────────────────────────────────────────────  SSH  ───────

alias doc='ssh docker'
alias plx='ssh plex'
alias esxidl='
scp -r  esxi:/bm         ~/dev/esxi
scp     esxi:/.profile  ~/dev/esxi/.profile
'
alias esxiul='
scp -r  ~/dev/esxi/bm        esxi:/
scp     ~/dev/esxi/.profile  esxi:/.profile 
'

#──────────────────────────────────────────────────────────  bmPC|bmTP  ───────

if [[ $HOST == bm* ]]; then
  alias dcup='
  _a updating docker repo
  dcpath=~/repos/bmilcs-docker
  cd "$dcpath" || return 1
  git pull && _s'
  alias dce='dcup && vim ~/repos/bmilcs-docker/docker-compose.yaml'
  alias dcee='dcup && vim ~/repos/bmilcs-docker/.env'
fi

#──────────────────────────────────────────────────────────────  nginx  ───────

if [[ $HOST == nginx ]]; then
  alias wwwr='
  source _bm
  _a "restarting webserver: ${YLW}nginx | php"
  scr php7.4-fpm nginx
  
  _a "status check"
  scs nginx php7.4-fpm
  '
  alias ngr='s nginx -s reload'
  alias ngt='s nginx -t'
  alias nge='svim /etc/nginx/sites-available/bmilcs'
fi

#──────────────────────────────────────────────────────────────  CLOUD   ──────

if [[ $HOST == "cloud" ]]; then
 
  # reload services
  alias wwwr='
  source _bm
  _a "restarting webserver: ${YLW}nginx | php | redis"
  scr redis-server php7.3-fpm nginx
  
  _a "status check"
  scs nginx php7.3-fpm redis-server
  '

  # cloudflare
  alias nce='svim /usr/share/nginx/nextcloud/config/config.php'
  alias ncc='cd /usr/share/nginx/nextcloud'
  alias ncd='sudo su && cd /usr/share/nginx/nextcloud-data'
  alias logg='sudo su && cd /var/log/nginx'

  alias nginx='sudo nginx '
  alias nginxe='svim /etc/nginx/conf.d/nextcloud.conf'
  alias nginxx='cd /etc/nginx'
  alias nginxxx='cd /usr/share/nginx'
  alias logg='cd /var/log'

  alias phpe='svim /etc/php/7.3/fpm/php.ini'
  alias phpe='cd /etc/php/7.3'

fi

#─────────────────────────────────────────────────────────────  DOCKER  ───────

#if where docker-compose > /dev/null && [ -d ~/docker ]; then
if [[ $HOST =~ docker\|nginx ]]; then
#if [[ $HOST =~ docker ]]; then

  # editor
  alias dc='docker'
  alias wwwe='vim ~/docker/swag/config/nginx/site-confs/bmilcs.conf'
  alias dce='vim ~/docker/docker-compose.yaml'
  alias dcee='vim ~/docker/.env'

  # docker logs
  alias dclog='cd ~/docker && docker-compose \
    -f ~/docker/docker-compose.yaml logs -tf --tail="50"'

  # letsencrypt restart
  alias le='docker restart swag && docker logs -f swag'
  alias wwwr='le'
  alias swag='le'
  alias wwww='~/docker/swag/config/www/'
  alias nginxx='~/docker/swag/config/nginx/'
  alias logss='~/docker/swag/config/log/'

  # docker-compose
  alias dcup='cd ~/docker && docker-compose up -d --remove-orphans' #;compdef dcs='docker'
  alias dcstop='cd ~/docker && docker-compose stop' #;compdef dcstop='docker stop '
  alias dcrestart='cd ~/docker && docker-compose restart' #;compdef dcrestart='docker restart '
  alias dcdown='cd ~/docker && docker-compose down' #;compdef dcdown='docker down'
  alias dcinfo='docker system df'

  # list all dockers
  alias dps='docker ps -a \
    --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}" \
    | (read -r; printf "%s\n" "$REPLY"; sort -k 2  )'
  alias dnet='docker network ls'

  # clean up docker system
  alias dclean='dcleani && dcleane'
  alias dcleani='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'
  alias dcleane='docker rm $(docker ps -qa --no-trunc --filter "status=exited")'

  # stop all containres
  alias dcstopall='docker stop $(docker ps -a -q)'

  # remove unused: containers | vol | networks | etc
  alias dcnukeold='docker system prune -af'
  
  # remove nfs share volumes
  alias dcnukev='docker volume rm $(docker volume ls | grep docker_)'

  # remove all containers
  alias dcnukec='docker rm $(docker ps -a -q)'

  # remove all images
  alias dcnukei='docker rmi $(docker images -a -q)'

  # nuke ALL: containers | volumes | images
  alias dcnukeall='dcstopall ; dcnukec ; dcnukei ; dcnukev'

  # beets
  alias beetsdl='docker exec -u abc -it beets /bin/bash -c "beet import /downloads/usenet/complete/music"'

fi

#────────────────────────────────────────────────────  DEBIAN: ARCHIVE  ───────

if [[ $DISTRO == "debian" ]]; then
  alias ideb='sudo /bin/bash ~/.bmilcs/script/debian.sh'

  alias ibak='upp ; sudo /bin/bash ~/.bmilcs/script/backup.sh install $USER ; source ~/.bashrc'
  alias ibakls='sudo cat /etc/rsnapshot.conf | grep ^backup'
  alias ibakadd='sudo /bin/bash ~/.bmilcs/script/backup.sh add'
  alias rsnap='svim /etc/rsnapshot.conf'

  # minecraft

################################################################################
################################### archive ####################################
################################################################################

#───────────────────────────────────────────────────────  old script  ─────────
#   mkdir -m 700 -p ~/.ssh
#   curl -s https://github.com/bmilcs.keys >> ~/.ssh/authorized_keys
#   chmod 600 ~/.ssh/authorized_keys
#   eval "$(ssh-agent -s)"
#   echo "> enter github private key as follows:"
#   echo "  ssh-add ~/.ssh/id_github"'

  # install nfs
  # TODO > FUNCTION conversion

# alias infs='
#   sudo apt install nfs-kernel-server
#   echo && echo "====================================================================================================="
#   echo "====  bmilcs: nfs instructions  ====================================================================="  && necho "=====================================================================================================" && echo
#   echo "svim /etc/exports"
#   echo "#path/to/dir          10.0.0.0/8(ro,sync)\"
#   echo "-----------------------------------------------------------------------------------------------------"'

# # install smb
# # TODO > function conversion

# alias ismb='
#   sudo apt install samba
#   echo && echo "====================================================================================================="
#   echo "====  bmilcs: samba instructions  ==================================================================="
#   echo "=====================================================================================================" && echo
#   echo "svim /etc/samba/smb.conf"
#   echo "#       workgroup = BM"
#   echo "#       interfaces = 192.168.1.0/24 eth0"
#   echo "#       hosts allow = 127.0.0.1/8 192.168.1.0/24"
#   echo "# [docker]"
#   echo "#         comment = docker vm config files"
#   echo "#         path = /home/bmilcs/docker"
#   echo "#         browseable = yes"
#   echo "#         read only = no"
#   echo "#         guest ok = no"
#   echo "#         valid users = bmilcs"
#   echo "-----------------------------------------------------------------------------------------------------"		'

###############################################################################
#                                 GRAVEYARD
###############################################################################

#──────────────────────────────────────────────────  DEBIAN NETWORKING  ───────

#alias rnet="sudo /etc/init.d/networking restart"
#alias enet="svim /etc/network/interfaces"

#─────────────────────────────────────────────────────────────  DOCKER  ───────

# alias dcr='cd /tmp && rm -rf /tmp/docker && git clone git@github.com:bmilcs/docker.git /tmp/docker && cd /tmp/docker && rm -f ~/docker/docker-compose.yaml ~/docker/.env && cp 1docker-compose.yaml .env ~/docker/ && cd ~/docker && mv 1docker-compose.yaml docker-compose.yaml &&  docker-compose up -d --remove-orphans'

#──────────────────────────────────────────────────────  GIT BARE REPO  ───────

# alias gitt="/usr/bin/git --git-dir=$HOME/.git/ --work-tree=$HOME"
# alias gitp="gitt commit -a -m 'update' && gitt push"
# compdef gitt="git"
# compdef gitp="git"

fi 
