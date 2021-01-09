#
# FUNCTIONS
# -bmilcs
#

source _head

#
# GITHUB & DOTFILES 
#

# dotfiles: git add new & commit all w/ message
function gtc() {
  _a bmilcs/dotfiles:
  _a add / commit
  gt add $D/. && $(gt commit -a -m "$*") && _s done.

  _a bmilcs/dotfiles push to github
  gtp && _s update complete
  }

#
# SERVICES
#

# start service
function sstart() {
  sudo service $@ start
  }

# stop service
function sstop() {
  sudo service $@ stop
  }

# restart service
function srestart() {
  sudo service $@ restart
  }

# get service status
function sstatus() {
  sudo service $@ status
  }


#
# BASH
#

# create dir & cd into it
function mdir() {
  mkdir -p "$@" && cd "$@";
  }

# debian: install app
function apti() {
  sudo apt-get install $@ -y
  }

# debian: delete & purge app
function aptr() {
  sudo apt-get purge $@ -y
  }

# debian: find app
function aptf() {
  dpkg --get-selections | grep $@
  }

# debian: get app status
function apts() {	
  systemctl status $@; 
  }


#
# COLORS
#

# color print out 
function colors() {
  # part1
  for x in {0..8}; do for i in {30..37}; do for a in {40..47}; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo ""
  # part2
  T='bmilcs'   # The test text
  echo -e "\n                 40m     41m     42m     43m\
     44m     45m     46m     47m";
  for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
            '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
            '  36m' '1;36m' '  37m' '1;37m';
     do FG=${FGs// /}
     echo -en " $FGs \033[$FG  $T  "
     for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
         do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
     done
     echo;
  done
  echo
  }

#
# NETWORKING
#

# ssh key generate & upload& upload& upload& upload& upload& upload& upload
function sshgen() {
  echo '> ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_$@ -N ""'
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_$@ -N ""
  echo "> ssh-copy-id -i ~/.ssh/id_$@ bmilcs@$@"
  ssh-copy-id -f -i ~/.ssh/id_$@ bmilcs@$@
  # echo "> eval `ssh-agent`"
  # eval `ssh-agent`
  # echo "> ssh-add -l"
  # ssh-add -l
  }

# print local ip & wan ip | requires dig
function myip() {
  printf "\n%s" "          host:   "
  echo $HOSTNAME "(.bm.bmilcs.com)"
  ipp="ip a | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
  eval ip=\$\($ipp\)
  printf "%s" "           lan:   " 
  echo $ip 
  eval wan=\$\(dig @1.1.1.1 ch txt whoami.cloudflare +short\)
  wan="${wan%\"}"
  wan="${wan#\"}"
  printf "%s\n\n" "           wan:   $wan " 
  }

#
# DOCKER
#

# docker 
function dexec() { 
  docker exec -ti --priveledged $@ sh
  }

# delete container
function ddel() {
  docker stop $(docker ps -a -q)
  docker rm $(docker ps -a -q)
  }

# tail docker-compose logs
function dlog () {
  docker logs -f $@
  docker-compose -f ~/docker/docker-compose.yaml logs -tf --tail="50" | grep $@
  }

# restart container
function dre() {
  docker restart $@
  docker logs -f $@
  }

#
# COMMAND REPLACEMENT
#

# nvim all-in-one sudo-fier wombo-combo
vim() {
  if [ $# -eq 0 ]; then   # no argument, launch nvim
    nvim
  elif [ -d "$@" ]; then  # if argument = a directory, error
    echo "error: \"$@\" is a DIRECTORY. Denied."
  elif [ -w $@ ]; then    # if exists and writeable. nvim TIME!"
    command nvim "$@" 
  elif [ -e $@ ]; then    # if exists, not writeable, auto SUDO 
    sudo nvim "$@"
  else                    # if arg doesn't exist...
      if touch $@; then     # if user has permission, create & launch nvim:
        command nvim "$@"
      else                  # elevate to sudo & create/launch nvim: 
        sudo nvim \"$@\"
      fi
    fi
    }

# colorize man command
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
    }

#
# GRAVEYARD
#

#
# GITHUB
#

# # add dir w/ basedir prefix to repo
# # TODO fix w/ stow format
# function bmad() {
#   mkdir -p ~/bm/`basename "$PWD"`
#   cp -r $@ ~/bm/`basename "$PWD"`/$@ 
#   }
# 
# # add file to base dir of repo
# # TODO fix w/ stow format
# function bma() {
#   bm add $@
#   bm commit -m "Added $@"
#   }
# 
# 
# # DOTFILES GITHUB OLD
# function gita() {
#     gitt add $@
#     gitt commit -m "Added $@"
#     }

#
# DOCKER
#

# # docker-compose based on host name
# function drun() {
# 	if [ "$HOSTNAME" = docker ]; then
# 		echo && echo "----  docker1: www & doc content  ---------------------------------------------------------------------" && echo && cd /tmp && rm -rf /tmp/docker && git clone git@github.com:bmilcs/docker.git /tmp/docker && cd /tmp/docker && rm -f ~/docker/docker-compose.yaml ~/docker/.env && cp 1docker-compose.yaml .env ~/docker/ && cd ~/dockerl && mv 1docker-compose.yaml docker-compose.yaml && docker-compose up -d --remove-orphans
# 	elif [ "$HOSTNAME" = docker2 ]; then
# 		echo && echo "----  docker2: linux iso  -----------------------------------------------------------------------------" && echo && cd /tmp && rm -rf /tmp/docker && git clone git@github.com:bmilcs/docker.git /tmp/docker && cd /tmp/docker && rm -f ~/docker/docker-compose.yaml ~/docker/.env && cp 1docker-compose.yaml .env ~/docker/ && cd ~/dockerl && mv 1docker-compose.yaml docker-compose.yaml && docker-compose up -d --remove-orphans
# 	else
# 		echo "error: wrong vm dummy!"
# 	fi
# }
