#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#              ZSH FUNCTIONS
#────────────────────────────────────────────────────────────

# dotfile rc file debugging
. "${HOME}/bin/sys/dotfile_logger"
dotlog '+ $ZDOTDIR/03-functions.zsh'


compdef vm="where"

# GIT
#────────────────────────────────────────────────────────────

# commit changes
function gc() {
  [[ $(git rev-parse --is-inside-work-tree) ]] || cd "$D"
  git commit -m "$*"
  }

# git reset hard
function grh() {
  source $D/bin/bin/_bm
  [[ $(git rev-parse --is-inside-work-tree) ]] || cd "$D"
  _t git reset hard
  _w WILL BE LOST:
  _a git status
  git status -s
  _a git diff
  git diff
  echo
  _ask "do you really want to reset --hard? (all changes will be lost" && git reset --hard && git clean -fdx
  }

# add & commit all: lazy mode
function gacall() {
  source $D/bin/bin/_bm
  _ask "mass git {add,commit,push} - are you sure?" \
  && _t dotfile repo commit \
  && _a add missing files \& commit \
  && ga . \
  && gc "$@" \
  && _s done.
  }

# SHELL
#────────────────────────────────────────────────────────────
# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  [ $# -eq 0 ] && echo "arg needed." && return 1
  rg --files-with-matches --no-messages "$1" \
    | fzf --preview "highlight -O ansi -l {} 2> /dev/null \
    | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' \
    || rg --ignore-case --pretty --context 10 '$1' {}" \
    | xargs nvim
}
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}


# SHELL
#────────────────────────────────────────────────────────────

# create dir & cd into it
function mdir() {
  mkdir -p "$@" && cd "$@";
  }

# SYSTEM SERVICES
#────────────────────────────────────────────────────────────

# start service
function svon() {
  sudo service $@ start
  }

# stop service
function svoff() {
  sudo service $@ stop
  }

# restart service
function svre() {
  sudo service $@ restart
  }

# get service status
function svst() {
  sudo service $@ status
  }

# COLORS
#────────────────────────────────────────────────────────────

# color print out 
function colorr() {
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

#────────────────────────────────────────────────────────────
# NETWORKING
#────────────────────────────────────────────────────────────

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

#────────────────────────────────────────────────────────────
# DOCKER
#────────────────────────────────────────────────────────────

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

#────────────────────────────────────────────────────────────
# COMMAND ENHANCEMENT
#────────────────────────────────────────────────────────────

function man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
    }
  
#────────────────────────────────────────────────────────────
#────────────────────────────────────────────────────────────
# GRAVEYARD
#────────────────────────────────────────────────────────────
#────────────────────────────────────────────────────────────

# GITHUB
#────────────────────────────────────────────────────────────

# # add dir w/ basedir prefix to repo
# # TODO fix w/ stow format
# function bmad() {
#   mkdir -p ~/bm/`basename "$PWD"`
#   cp -r $@ ~/bm/`basename "$PWD"`/$@ 
#   }
# # add file to base dir of repo
# # TODO fix w/ stow format
# function bma() {
#   bm add $@
#   bm commit -m "Added $@"
#   }
# # DOTFILES GITHUB OLD
# function gita() {
#     gitt add $@
#     gitt commit -m "Added $@"
#     }
# DOCKER
#────────────────────────────────────────────────────────────
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
#────────────────────────────────────────────────────────────
#────────────────────────────────────────────────────────────
# nvim all-in-one sudo-fier wombo-combo
# vim() {
#   if [ $# -eq 0 ]; then   # no argument, launch nvim
#     nvim
#   elif [ $# -gt 1 ]; then  # multiple arguments, skip function
#     nvim $*
#   elif [ -d "$@" ]; then  # if argument = a directory, error
#     echo "error: \"$@\" is a DIRECTORY. Denied."
#   elif [ -w $@ ]; then    # if exists and writeable. nvim TIME!"
#     command nvim "$@" 
#   elif [ -e $@ ]; then    # if exists, not writeable, auto SUDO 
#     sudo nvim "$@"
#   else                    # if arg doesn't exist...
#       if touch $@; then     # if user has permission, create & launch nvim:
#         command nvim "$@"
#       else                  # elevate to sudo & create/launch nvim: 
#         sudo nvim \"$@\"
#       fi
#     fi
#     }
