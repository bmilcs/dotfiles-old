#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 ZSH: ALIASES [./02-aliases.zsh]

#         split up into separate .zsh files
#         add working savedir alias > select

# dotfile rc file debugging
. "${HOME}/bin/sys/dotfile_logger" && dotlog '+ $ZDOTDIR/02-aliases.zsh'

#───────────────────────────────────────────────────  disable built-in  ───────

unalias gi 
unalias ga

#───────────────────────────────────────────────────────────────  misc  ───────

# homebrew switch
alias nin='./fusee-launcher.py hekate-5.1.1.bin'

# cloudflare
export CFLARED=~/bmP/bin/cloudflared/
alias cfdc='cd "$CFLARED" && sh "$CFLARED"/nginx'
alias cfadd='cd "$CFLARED" && sh "$CFLARED"/add'
alias cfdel='cd "$CFLARED" && sh "$CFLARED"/del'
alias cfinfo='cd "$CFLARED" && sh "$CFLARED"/info'

# generate pw hash
alias pwhash='openssl passwd -6 '

# fd w/ exclusions
alias fdd='fd -H -E /a '

#───────────────────────────────────────────────────────────────  text  ───────

# text editor
alias nano='nvim'                 ; compdef nano='nvim'
alias vim='nvim'                  ; compdef vim='nvim'
alias vmf='nvim $(fzf --exit-0)'  ; compdef vmf='nvim'
alias svim='s vim'                ; compdef svim='nvim'
#alias svim='sudoedit'            ; compdef svim='nvim'

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

# configuration files
alias bsp='vim $D/opt/bspwm/.config/bspwm/bspwmrc'
alias gaps='vim $D/opt/i3/.config/i3/global'
alias gapspc='vim $D/opt/i3/.config/i3/bmPC'
alias gapstp='vim $D/opt/i3/.config/i3/bmTP'
alias i3keys='command i3keys web 8080 & ;\
              firefox -new-tab http://localhost:8080'
alias keys='vim $D/opt/sxhkd/.config/sxhkd/sxhkdrc'
alias picomrc='vim $D/opt/picom/.config/picom/config'
alias termrc='vim $D/opt/alacritty/.config/alacritty/alacritty.yml'

#───────────────────────────────────────────────────────────────  misc  ───────

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

#─────────────────────────────────────────────────  networking ssh etc  ───────

alias doc='ssh docker'
alias plx='ssh plex'

alias esxidl='
  scp -r  esxi:/bm         ~/dev/esxi
  scp     esxi:/.profile  ~/dev/esxi/.profile'
alias esxiul='
  scp -r  ~/dev/esxi/bm        esxi:/
  scp     ~/dev/esxi/.profile  esxi:/.profile'

alias rnet='sudo systemctl restart \
  {systemd-networkd.service,systemd-resolved.service,iwd.service} && ip a'

#───────────────────────────────────────────────────────────────  apps  ───────

# rsync
alias rscp='rsync -zahv --progress --partial'
alias rsmv='rscp -zahv --progress --remove-source-files'
alias rsdirstructure='rsync -av -f"+ */" -f"- *"'

# ranger
alias ranger='ranger --choosedir=$HOME/.config/ranger/sdir; \
              LASTDIR=`cat $HOME/.config/ranger/sdir`; cd "$LASTDIR"'
alias rr='ranger'

# i3 xev keycodes
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

#────────────────────────────────────────────────────────  file system  ───────

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

#───────────────────────────────────────────────────────  system power  ───────

# reboot, shutdown, etc.
alias rex='sudo systemctl restart display-manager'
alias rb='sudo systemctl reboot'
alias winrb='sudo grub-reboot 2 ; reboot'
alias reboot='sudo systemctl reboot'
alias halt='sudo systemctl halt'
alias shutdown='sudo systemctl poweroff'

#────────────────────────────────────────────────────────────  systemd  ───────

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

alias alii="alias | sed 's/=.*//'"
alias funn="declare -f | grep '^[a-z].* ()' | sed 's/{$//'"
alias pathh='echo -e ${PATH//:/\\n}'
alias hn='echo $HOST'

# audio sinks
alias sinko='pacmd list-sinks | grep -e "name:" -e "index:"'
alias sinki='pacmd list-sources | grep -e "index:" -e device.string -e "name:"'

# pid
alias pid='cat /etc/passwd | sort | column -t -s ":" -o " "'

################################################################################
############################### distro specific ################################
################################################################################

#──────────────────────────────────────────────────────────  archlinux  ───────

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

#──────────────────────────────────────────────────────  debian ubuntu   ──────
#
else 

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

################################################################################
################################ host specific #################################
################################################################################

#───────────────────────────────────────────────  nginx stack function  ───────

# nginx aliases
ali_nginx() {
  alias ngx='sudo nginx '

  alias ngs='scs nginx.service'
  alias ngr='ngx -s reload'
  alias ngt='ngx -t'
  alias nge='svim /etc/nginx/sites-available/bmilcs'
  alias ngee='svim /etc/nginx/nginx.conf'
  alias wwwe='nge'

  alias ngg='cd /etc/nginx'
  alias nggg='cd /usr/share/nginx'
  alias ngla='svim /var/log/ng-access.log'
  alias nglaa='sudo tail -f /var/log/ng-access.log'
  alias ngle='svim /var/log/ng-error.log'
  alias nglee='sudo tail -f /var/log/ng-error.log'
  }

#──────────────────────────────────────────────────────────  minecraft  ───────

if [[ $HOST == mc ]]; then
  alias mine='/opt/minecraft/tools/mcrcon/mcrcon -H 127.0.0.1 -P 25575 -p <password> -t'
  alias mce='svim /etc/systemd/system/minecraft.service'
  alias mcr='scr minecraft.service'
  alias mcs='scs minecraft.service'

elif [[ $HOST == wg ]]; then

  alias qrmoto='sudo qrencode -t ansiutf8 < /etc/wireguard/wg0-bmMoto.conf'
  alias qrtp='sudo qrencode -t ansiutf8 < /etc/wireguard/wg0-bmTP.conf'
  alias wg0='svim /etc/wireguard/wg0.conf'
  alias wgmoto='svim /etc/wireguard/wg0-bmMoto.conf'
  alias wgtp='svim /etc/wireguard/wg0-bmTP.conf'
  alias wgdown='sudo wg-quick down wg0'
  alias wgup='sudo wg-quick up wg0'

#────────────────────────────────────────────────────────────────  mpd  ───────

elif [[ $HOST == mpd ]]; then
  # beets
  alias beete='vim ~/.config/beets/config.yaml'
  alias beetcd='cd /all/media/audio'
  alias beeti='beet import -ql /all/media/audio/beets/$(date +%m.%d-%H.%M.%S).log '

#──────────────────────────────────────────────────────────  bmPC|bmTP  ───────

elif [[ $HOST == bm* ]]; then

  alias dcup='
    _a updating docker repo
    dcpath=~/repos/bmilcs-docker
    cd "$dcpath" || return 1
    git pull && _s'

  alias dce='vim ~/repos/bmilcs-docker/docker-compose.yaml'
  alias dcee='vim ~/repos/bmilcs-docker/.env'
  alias wwwe='vim ~/repos/bmilcs-docker/swag/config/nginx/site-confs/bmilcs.conf'

#──────────────────────────────────────────────────────────────  nginx  ───────

elif [[ $HOST =~ nginx\|wp\|www ]]; then

  alias wwwr='
  source _bm
  _a "restarting webserver: ${YLW}nginx | php | fail2ban"
  scr php7.4-fpm nginx fail2ban
  
  _a "status check"
  scs nginx php7.4-fpm fail2ban
  '

  alias wwws='
  source _bm
  _a "web server status: ${YLW} nginx | php | fail2ban"
  scs php7.4-fpm nginx fail2ban
  '

  # import nginx aliases
  ali_nginx

#──────────────────────────────────────────────────────────────  CLOUD   ──────

elif [[ $HOST == "cloud" ]]; then
 
  alias wwwr='
  source _bm
  _a "restarting webserver: ${YLW}nginx | php | redis"
  scr redis-server php7.3-fpm nginx
  
  _a "status check"
  scs nginx php7.3-fpm redis-server
  '

  # nextcloud
  alias nce='svim /usr/share/nginx/nextcloud/config/config.php'
  alias ncc='cd /usr/share/nginx/nextcloud'
  alias ncd='sudo su && cd /usr/share/nginx/nextcloud-data'

  # import nginx aliases
  ali_nginx
  alias nge='svim /etc/nginx/conf.d/nextcloud.conf'

  alias phpe='svim /etc/php/7.3/fpm/php.ini'
  alias phpp='cd /etc/php/7.3'

#─────────────────────────────────────────────────────────────  DOCKER  ───────

#if where docker-compose > /dev/null && [ -d ~/docker ]; then
elif [[ $HOST =~ docker ]]; then

  # editor
  alias dc='docker'
  alias wwwe='vim ~/docker/swag/config/nginx/site-confs/bmilcs.conf'
  alias nge='wwwe'
  alias dce='vim ~/docker/docker-compose.yaml'
  alias dcee='vim ~/docker/.env'

  # docker logs
  alias dclog='cd ~/docker && docker-compose \
    -f ~/docker/docker-compose.yaml logs -tf --tail="50"'

  # letsencrypt restart
  alias le='docker restart swag && docker logs -f swag'
  alias wwwr='le'
  alias swag='le'
  alias ngr='le'
  alias wwww='~/docker/swag/config/www/'
  alias ngg='~/docker/swag/config/nginx/'
  alias ngla='~/docker/swag/config/log/'
  alias ngle='~/docker/swag/config/log/'

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
  alias dclean='docker system prune --volumes'
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
