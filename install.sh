#!/usr/bin/env bash
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 DOTFILE INSTALLATION [./install.sh]

source ./bin/bin/_bm

#─────────────────────────────────────────────────────────────  header  ───────

_t [bmilcs] dotfile installer && echo

_w disclaimer: this script can be destructive! \\n

_o i attempt to preserve existing configuration files \\n \
  within "${B}"\'~/.backup\'"${NC}" but procede with caution. \\n 

_op installation type is determined by your distro:\\n

_i "${CYN}${B}archlinux${NC}"\\n \
  --  "${B}"my workstation setup"${NC}" \\n \
  --  installs: everything \\n \
  --  home \& sys configs, networkd, iwctl, etc. \\n

_i "${CYN}${B}debian/ubuntu users${NC}" \\n \
  --  "${B}my virtual machine setup ${NC}" \\n \
  --  installs: minimal setup: \\n \
  --  defined by \$deb in the variable section. \\n

_i "${CYN}${B}centos users${NC}" \\n \
  --  "${B}web host setup${NC}" \\n \
  --  installs: minimal setup \\n \
  --  defined by \$centos in the variable section.

#──────────────────────────────────────────────────────────  variables  ──────#

# global path exceptions
exceptions=("img" "opt" "rsnapshot" "backup")

# minimal: [debian/raspbian/ubuntu]
deb=("bin" "git" "txt" "vim" "zsh" "bash") 

# packages
pkgs=("curl" "wget" "zsh" "neovim" "git" "stow")
apt=("fd-find" "npm" "colordiff") # "bat" mia
pacman=("fd" "unzip" "colordiff" "xdotool")
yum=("") # missing: fd, bat, colordiff

# repo related
D=$HOME/bm
BM=$D
BMP=$HOME/bmP
BAK=$HOME/.backup/dotfiles/

################################################################################
################################## functions   #################################
################################################################################

#─────────────────────────────────────────────────────  cleanup/backup  ───────
cleanup() { 

  _a clean-up time
  _w "content will be moved to $BAK"

  mkdir -p "$BAK"
  mkdir -p "${BMP}"

  _f "backup: ~/.dotfiles"
  mv ~/{_bmilcs,.bm*,.inputrc*,.dir_color*,.aliases,.functions,.profile,.bash*,.zcompdump} "$BAK" 2> /dev/null

  _f "backup: old up & upp scripts"
  sudo mv /usr/local/bin/{up,upp} "$BAK" 2> /dev/null

  _f "backup: git config"
  rm -rf "$BAK/git"
  mv ~/{.config/git,.gitconfig} "$BAK/git" 2> /dev/null

  _f "deleting: old zsh configs"
  rm -rf ~/{.zsh,.zinit,.zplugin} 2> /dev/null

  _f "broken symlink removal: ${B}\$HOME"
  find ~ -xtype l 2> /dev/null | while read -r line; do
    if [[ ! $line == "$HOME/bm/"* ]] && [[ ! $line == "$HOME/.backup/"* ]] \
      && [[ ! $line == "$HOME/plex/"* ]]
    then
    _fb removing: "$line" && sudo rm "$line"
    fi
  done

  _f "broken symlink removal: ${B}/etc"
  sudo find /etc -xtype l 2> /dev/null | while read -r line; do
    _fb removing: "$line" && sudo rm "$line"
  done

  _f "changing /etc/banner"
  [[ -f "/etc/banner" ]] \
    && me=$(sudo cat "/etc/hostname") \
    && echo "${me^^}: welcomes you" | sudo tee /etc/banner

  _s complete

} 

#──────────────────────────────────────────────────  fzf: fuzzy finder  ───────
ifzf() { 

  _a fzf

  if [[ ! -f ~/.config/fzf/bin/fzf ]]; then

    _o setup required
    _a fzf: installation

    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.config/fzf
    ~/.config/fzf/install --xdg --no-update-rc --completion --key-bindings

  else
    _s 
  fi

} 

#─────────────────────────────────────────────────────────  zsh: shell  ───────

izsh() {

  _a zsh
  export ZDOTDIR=~/.config/zsh
  ZINITDIR=~/.config/zinit

  if [[ ! -d ~/.config/zinit ]] \
    || [[ ! -d $ZDOTDIR ]] \
    || [[ ! -d $ZDOTDIR/compdump ]] \
    || [[ ! -d $ZDOTDIR/history ]] \
    || [[ ! -d $ZDOTDIR/completion ]] \
    || [[ ! -f $ZDOTDIR/completion/_git ]] \
    || [[ ! -f $ZDOTDIR/completion/git-completion.bash ]]
  then

    # create directories
    mkdir -p $ZINITDIR $ZDOTDIR/{completion,compdump,history}

    # install zinit
    _o zsh: zinit plugin manager
    git clone https://github.com/zdharma/zinit.git ~/.config/zinit/bin

    # install zsh git completion
    _o zsh: git autocompletion
    curl -o ~/.config/zsh/completion/git-completion.bash \
      https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    curl -o ~/.config/zsh/completion/_git \
      https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

    if $(which docker-compose); then
      _o zsh: docker-compose autocompletion
      curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/zsh/_docker-compose \
        > ~/.zsh/completion/_docker-compose
      curl -o ~/.config/zsh/completion/_docker-compose \
        https://raw.githubusercontent.com/docker/compose/1.28.5/contrib/completion/zsh/_docker-compose
    fi
  fi

  _s
}

#───────────────────────────────────────────────────────  nvim: editor  ───────

ivim() {
  _a vim

  plugvim=~/.config/nvim/plugged/vim-plug/plug.vim
  plugsym=~/.config/nvim/autoload/plug.vim

  if [[ ! -f $plugvim ]] || [[ ! -L $plugsym ]]; then
    _a vim-plug: plugin manager

    # cleanup previous install method
    rm -rf ~/.local/share/nvim/site/autoload/plug.vim ~/.vim

    # create & deploy paths for autoload/plugged
    mkdir -p ~/.config/nvim/{autoload,cache,plugged,swap,undo}
    git clone https://github.com/junegunn/vim-plug.git \
      ~/.config/nvim/plugged/vim-plug

    # bm - auto-update itself:
    ln -s $plugvim ~/.config/nvim/autoload && _s

    # run upvim to install plugins, etc.
    ./bin/bin/sys/upvim
  else
    _s
  fi
}

nodejs() {
  ver=$(node -v)
  ver=${ver:1:4}
  ver=${ver/./}
  if [[ $ver -le 120 ]] || [[ $ver == "" ]]; then
    sudo apt remove nodejs
    curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
    sudo apt -y install nodejs
  fi
}

#──────────────────────────────────────────  bitwarden cli: pw manager  ───────

btw() {
  _a bw

  tmp="$BMLOGS/bw.zip"
  bwp=/usr/local/bin/bw

  [[ -f "$bwp" ]] && sudo rm "$bwp"

  (sudo curl -L -o "$tmp" \
    'https://vault.bitwarden.com/download/?app=cli&platform=linux' \
    && sudo unzip "$tmp" -d /usr/local/bin) &> /dev/null

  sudo chmod +x "$bwp"

  bw completion --shell zsh > ~/.config/zsh/completion/_bw
  rm -f "$tmp"

  _s
}

################################################################################
################################## dependies  ##################################
################################################################################

source "./bin/bin/_distro"

_a standard dependencies
_o "${pkgs[@]}"

#──────────────────────────────────────────────────────────  archlinux  ───────

if [[ ${DISTRO} == arch* ]]; then

  _t archlinux
  _a archlinux dependencies
  _o "${pacman[@]}"

  sudo rm -rf /tmp/bm-install.sh #2>&1 /dev/null

  if _askn "install necessary packages?"; then

    # universal
    pacman -Qi "${pkgs[@]}" > /dev/null 2>&1 \
      || (sudo pacman -Syu "${pkgs[@]}" | tee /tmp/bm-install.sh \
      && _o installed "${pkgs[@]}")

    # pacman
    pacman -Qi "${pacman[@]}" > /dev/null 2>&1 \
      || (sudo pacman -Syu "${pacman[@]}" | tee -a /tmp/bm-install.sh \
      && _o installed "${pacman[@]}")

  fi

  # --noconfirm 
  # ./bin/bin/sys/pacfix /tmp/bm-install.sh

#───────────────────────────────────────────  debian, raspbian, ubuntu  ───────

elif [[ ${DISTRO} =~ raspbian*|debian*|ubuntu* ]]; then

  _t "${DISTRO}"

  # universal
  dpkg -s "${pkgs[@]}" > /dev/null 2>&1 \
    || (sudo apt-get install -y "${pkgs[@]}" && _o installed "${pkgs[@]}")

  # apt
  dpkg -s "${apt[@]}" > /dev/null 2>&1 \
    || (sudo apt-get install -y "${apt[@]}" && _o installed "${apt[@]}")

  # nodejs (coc.nvim)
  nodejs

  # create path if not exists
  [[ ! -d  ~/.local/bin/ ]] && mkdir -p ~/.local/bin

  # link fdfind to fd
  [[ ! -L ~/.local/bin/fd ]] && ln -s "$(which fdfind)" ~/.local/bin/fd

#─────────────────────────────────────────────────────────────  centos  ───────

elif [[ ${DISTRO} =~ centos ]]; then

  # universal packages
  rpm -q "${pkgs[@]}" > /dev/null 2>&1 \
    || (sudo yum install -y "${pkgs[@]}" && _o installed "${pkgs[@]}")

  # apt specific
  rpm -q "${yum[@]}" > /dev/null 2>&1 \
    || (sudo yum install -y "${apt[@]}" && _o installed "${apt[@]}")

  # create path if not exists
  [[ ! -d  ~/.local/bin/ ]] && mkdir -p ~/.local/bin

  # link fdfind to fd
  #[[ ! -L ~/.local/bin/fd ]] && ln -s "$(which fdfind)" ~/.local/bin/fd

#───────────────────────────────────────────────  unconfigured distros   ──────

else

  _w "distro not configured" 
  _f distro: "$DISTRO"
  exit 1

fi

_s all set

#───────────────────────────────────────────────────────────────  misc  ───────

_a "dotfile logging"
_f "creating ~/.config/bmilcs"
mkdir -p ~/.config/bmilcs && _s 

################################################################################
################################## archlinux  ##################################
################################################################################

if [[ ${DISTRO} == arch* ]]; then

  # permission to procede?
  if  _ask "archlinux: install everything?"; then
    _t archlinux deployment
    _a "${U}"symlink: starting
    _o distro: "$DISTRO"
  else
    _a thank you for coming
    exit 0
  fi

  # function: rm broken symlinks, backup conflicting files, etc.
  cleanup

  # set alacritty to xterm (i3 error, etc.)
  if [[ ! -f /usr/bin/xterm ]] && [[ ! -L /usr/bin/xterm ]]; then
    sudo ln -s /usr/bin/alacritty /usr/bin/xterm
  fi

  # update font cache
  fc-cache


#────────────────────────────────────────────────────────  misc tweaks  ───────

  # make x11 folder [xsession-errors] TODO FIX .xsessions-error, still in ~
  [ -d ~/.config/x11 ] || mkdir -p ~/.config/x11

  # allow dmesg as user [notifications]
  sudo sysctl kernel.dmesg_restrict=0 > /dev/null

#────────────────────────────────────────────────  setup core software  ───────

  izsh
  ivim
  ifzf
  btw 

#───────────────────────────────────────────────────────────────  ROOT  ───────

  # stow root stuff: /
  _a root
  cd "$D"/root/ || (_e unable to cd root/ && exit 1)

  _o "symlink: ./root/share"
  sudo stow -t / -R share && _s

  _o "symlink: ./root/workstation"
  sudo stow -t / -R workstation && _s

#───────────────────────────────────────────────────────────────  HOME  ───────

  # stow home stuff: ~
  cd "$D" || (_e unable to cd base repo dir && exit 1)

  _a home
  _o "symlink: base dir" 

  # repo: / (base dir)
  for dir in "$D"/*/; do

    match=0

    # if dir = an exception, match!
    for a in "${exceptions[@]}"; do
      [[ $dir =~ $D/$a/|$D/root/ ]] && match=1
    done

    # if match, skip this iteration
    [[ "$match" == 1 ]] && continue

    # not a match && stow it :)
    stow -R "$(basename "$dir")" || _e "$(basename "$dir")"

  done && _s # end of repo directory loop

  # repo: opt/
  cd "$D"/opt || (_e unable to cd into opt && exit 1)

  _o "symlink: opt" && _s

  # repo: /opt/
  for dir in "$D"/opt/*/; do

    if [[ $(basename "$dir") == yay ]]; then
      if [[ ${DISTRO} == arch* ]] && [[ ! -L ~/.config/yay/config.json ]]; then 
        _f "rm yay config [resolve conflict for stow]"
        rm -f ~/.config/yay/config.json 
      fi
    fi

    stow -t "$HOME" -R "$(basename "$dir")" || _e "$(basename "$dir")"

  done && _s

else # not archlinux

################################################################################
############################ debian ubuntu raspbian ############################
################################################################################

  # title
  _t apt-based deployment
  _a "${B}symlink: ${GRN}${B}starting${NC}"
  _o distro: "$DISTRO"
  _i minimal install

  # function: rm broken symlinks, backup conflicting files, etc.
  cleanup

#────────────────────────────────────────────────  setup core software  ───────

  izsh
  ivim
  ifzf

#───────────────────────────────────────────────────────────────  root  ───────

  # stow /root
  _a root

  cd "$D"/root/ \
    || (_e unable to cd root/ && exit 1)

  _o symlink: root '/'
  sudo stow -t / -R share

#───────────────────────────────────────────────────────────────  home  ───────

  # stow ~
  _a home

  cd "$D" \
    || (_e unable to cd base repo dir && exit 1)

  _o symlink: home "${B}"\~

  if stow -R "${deb[@]}"; then 
    _i stowed: "${deb[@]}" && _s
  else
    _e error: "${deb[@]}" 
  fi

#───────────────────────────────────────────────────────────────  misc  ───────

  # set repo url
  _a setting origin/main url
  git remote set-url origin git@github.com:bmilcs/dotfiles.git && _s

  # check active shell
  if [[ ! $SHELL == *zsh* ]]; then

      _a directions
      _oy chsh -s /usr/bin/zsh
      _i reboot recommended!

  fi
fi

_t "installation complete"

echo

