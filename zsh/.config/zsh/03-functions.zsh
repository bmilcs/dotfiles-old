#           ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────        #
#           ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗        #
#           ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗        #
#           ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝        #
#           ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com        #

#                                ZSH FUNCTIONS                                #

# dotfile rc file debugging
. "${HOME}/bin/sys/dotfile_logger"
dotlog '+ $ZDOTDIR/03-functions.zsh'

function d() {
  home=$(echo $HOME | sed -e 's/[\/]/\\\//g')
  cd $(dirs -v | sed 's/^[0-9 \t]*//' | fzf | sed 's/^[^\/]/'$home'/')
}

#────────────────────────────────────────────────────────────  ansible  ───────

# toggle user ssh config on/off
togssh() {
  conf=~/.ssh/config 
  if [[ -f $conf ]]; then
    echo "${RED}${B}DISABLED${NC} ~/.ssh/config_off [DEBUG MODE]"
    mv "$conf"{,_off}
  else
    echo "${GRN}${B}ENABLED${NC} ~/.ssh/config"
    mv "$conf"{_off,}
  fi
}

# ansible ... shortcut
a() {
  cd $HOME/ans && ansible $*
}

# ansible all ... shortcut
aa() {
  [ ! $PWD == "$HOME/ans" ] && cd ~/ans 
  if [ $# == 0 ]; then
    l
  else
    ansible all $*
  fi
}

# ansible playbook ... shortcut
apb() { 
  cd ~/ans || return 1
  if [ -e "$1" ]; then
    ansible-playbook "$1"
  else
    l
  fi
}

apbe() {
  nvim $1
}



zstyle ':completion::complete:apb:*:*files' ignored-patterns '^*.(#i)(yaml|yml)'
zstyle ':completion::complete:apbe:*:*files' ignored-patterns '^*.(#i)(yaml|yml)'
compdef a='ansible'
compdef aa='ansible'
compdef '_files -W ~/ans/' apb
compdef '_files -W ~/ans/' apbe
# complete full paths
# compdef '_files -P ~/ans/ -W ~/ans/ -g "*(.)"' apb
# compdef '_files -P ~/ans/ -W ~/ans/ -g "*(.)"' apbe
#



#────────────────────────────────────────────────────────────────  git  ───────

# commit
function gc() {
  [[ $(git rev-parse --is-inside-work-tree) ]] || cd "$D"
  git commit -m "$*"
  }

# git reset hard
function grs() {
  source _bm
  [[ $(git rev-parse --is-inside-work-tree) ]] || cd "$D"
  _a git reset hard
  _w ALL WILL BE LOST:
  git status -s
  _a git diff
  git diff
  _ask "do you really want to reset --hard? (all changes will be lost)" \
    && git reset --hard \
    && git clean -fdx \
    && gp
  }

# add & commit all: lazy mode
function gacall() {
  source $D/bin/bin/_bm
  _ask "mass git {add,commit,push} - are you sure?" \
  && _t dotfile repo commit \
  && _a add missing files \& commit \
  && ga . && gc "$@" && _s done.
  }

endot()
{
  cd ~/$D
  tar czf encrypted.tar.gz etc/.local/share/misc
  gpg -er abdullah@abdullah.today encrypted.tar.gz
  rm encrypted.tar.gz
}

dedot()
{
  cd ~/$D
  gpg -do encrypted.tar.gz encrypted.tar.gz.gpg
  tar xvf encrypted.tar.gz
  rm encrypted.tar.gz
}

#──────────────────────────────────────────────────────────────  SHELL  ───────

cg() {
  cat "$1" | grep "$2"
}

# CD BIN
cdd() {
  cd $(dirname $(which "$1"))
}

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

# 
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

#─────────────────────────────────────────────────────────  networking  ───────

# print local ip & wan ip | requires dig
#function myip() {
#  printf "\n%s" "          host:   "
#  echo $HOSTNAME "(.bm.bmilcs.com)"
#  ipp="ip a | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
#  eval ip=\$\($ipp\)
#  printf "%s" "           lan:   " 
#  echo $ip 
#  eval wan=\$\(dig @1.1.1.1 ch txt whoami.cloudflare +short\)
#  wan="${wan%\"}"
#  wan="${wan#\"}"
#  printf "%s\n\n" "           wan:   $wan " 
#  }

#─────────────────────────────────────────────────────────────  docker   ──────

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

#────────────────────────────────────────────────────────────────  man  ───────
function man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
    }
  
#─────────────────────────────────────────────────  vm masterpiece lol  ───────

compdef vm="which"

function vm() {
  
  source _bm
  source ~/.profile
  syntax() {_w '${B}syntax${YLW}: vm <bin/sh>'}

  if [ $# -eq 0 ] || [ $# -gt 1 ]; then # arg = 1
    syntax
  else 
    bp="$(which $1 2> /tmp/bm-vm-$1)"
    error=$(cat /tmp/bm-vm-$1 2> /dev/null)
    if [[ -z "$bp" ]]; then   # which = empty
      _e "$1: not found\n" 
      _o "target: ${GRN}$1" 
    elif [[ -w "$bp" ]]; then # is it writeable?
      command nvim "$bp" 
    elif [[ -e "$bp" ]]; then   # is it even a file?
      if [[ "$bp" == "/usr/bin"* ]]; then # inside /usr/bin?
        _o "target:   ${GRN}$1"
        _o "path:     ${RED}$bp"
      else  # exists, outside of /usr/bin
        sudo nvim "$bp"
      fi
    else   #  doesn't exist 
      if [[ $bp == *"aliased to"* ]] && [[ ! $1 == vm ]]; then  # alias?
        _o "assumed: ${B}02-aliases.zsh"
        sleep 1
        ali
      elif [[ $bp == *"()"* ]]; then # function?
        _o "assumed: ${B}03-functions.zsh"
        sleep 1
        fun
      elif [[ $bp == *"not found"* ]]; then
          _ob "${B}$1${RED} not found"
      else
          _w "brain overload lol"
          _ob "${B}error${BLU}: $error"
          _ob "${B}bp${BLU}: $bp"
      fi
    fi
  fi
}

#───────────────────────────────────────────────────────────  ubiquiti  ───────

upunifi() {
    if [[ $# -eq 0 ]]
    then
      echo error: please suppy version #
    else
      curl -o "unifi_$1" "https://dl.ui.com/unifi/$1/unifi_sysvinit_all.deb" \
      && sudo dpkg -i "unifi_$1"
    fi
    }

#──────────────────────────────────────────────────────────────────────────────
#──────────────────────────────────────────────────────────  GRAVEYARD  ───────
#──────────────────────────────────────────────────────────────────────────────

#─────────────────────────────────────────────────────────────  GITHUB  ───────

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
#─────────────────────────────────────────────────────────────  DOCKER  ───────
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
#──────────────────────────────  nvim all-in-one sudo-fier wombo-combo  ───────
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

#────────────────────────────────────────────────────  system services   ──────
# 
# # start service
# function svon() {
#   sudo service $@ start
#   }
# 
# # stop service
# function svoff() {
#   sudo service $@ stop
#   }
# 
# # restart service
# function svre() {
#   sudo service $@ restart
#   }
# 
# # get service status
# function svst() {
#   sudo service $@ status
#   }
