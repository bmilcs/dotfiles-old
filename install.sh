#!/usr/bin/env bash
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 DOTFILE INSTALLATION [./install.sh]

source ./bin/bin/_bm

#─────────────────────────────────────────────────────────  disclaimer  ──────#

_t [bmilcs] dotfile installer && echo

_w disclaimer: this script can be destructive! \\n

_o i attempt to preserve existing configuration files \\n \
  within ${B}\'~/.backup\'${NC} but procede with caution. \\n 

_o thoroughly review this script before proceding. \\n 

_oc installation type is determined by your distro:\\n

_i "${CYN}${B}archlinux${NC}"\\n \
  --  ${B}my workstation setup${NC} \\n \
  --  installs: everything \\n \
  --  home \& sys configs, networkd, iwctl, etc. \\n

_i "${CYN}${B}debian/ubuntu users${NC}" \\n \
  --  ${B}my virtual machine setup${NC} \\n \
  --  installs: minimal setup: \\n \
  --  defined by \$mini in the variable section.

#──────────────────────────────────────────────────────────  variables  ──────#

# arch exceptions
exceptions=("img" "opt")

# debian vm's
mini=("bin" "git" "txt" "vim" "zsh" "bash") 

# all: req packages
pkgs=("curl" "wget" "zsh" "neovim" "git" "stow" "colordiff")
aptpkg=("fd-find" "nodejs" "npm") # "bat"
pacpkg=("fd" "bat" "unzip")

# backup location
backup=~/.backup/dotfiles

# repo path
D=$HOME/bm

#──────────────────────────────────────────────────────────  functions   ─────#

#
# cleanup (dotfile remnants, git cfg, broken symlinks, etc)
#

cleanup() { 

  _a clean-up time
  _w "content will be moved to $backup"

  mkdir -p "$backup"

  _f "backup: ~/.dotfiles"
  mv ~/{_bmilcs,.bm*,.inputrc*,.dir_color*,.aliases,.functions,.profile,.bashrc*,.zcompdump} "$backup" 2> /dev/null

  _f "backup: old up & upp scripts"
  sudo mv /usr/local/bin/{up,upp} "$backup" 2> /dev/null

  _f "backup: git config"
  rm -rf "$backup/git"
  mv ~/{.config/git,.gitconfig} "$backup/git" 2> /dev/null

  _f "deleting: old zsh configs"
  rm -rf ~/{.zsh,.zinit,.zplugin} 2> /dev/null

  _f "broken symlink removal: ${B}\$HOME"
  find ~ -xtype l 2> /dev/null | while read -r line; do
    if [[ ! $line == "$HOME/bm/"* ]] && [[ ! $line == "$HOME/.backup/"* ]]
    then
    _fb removing: "$line" && sudo rm "$line"
    fi
  done

  _f "broken symlink removal: ${B}/etc"
  sudo find /etc -xtype l 2> /dev/null | while read -r line; do
    _fb removing: "$line" && sudo rm "$line"
  done

  _f "changing /etc/banner"
  [[ -f "/etc/banner" ]] && echo "welcome to: $HOST" | sudo tee /etc/banner

  _s complete

} # cleanup()

#
# fzf: fuzzy finder
#

ifzf() { 

  _a fzf

  if [[ ! -f ~/.config/fzf/bin/fzf ]]; then

    _o setup required
    _a fzf: installation

    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.config/fzf
    ~/.config/fzf/install --xdg --no-update-rc --completion --key-bindings

  else
    _o all set
  fi

} 

#
# zsh: shell
#

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

  _o all set
}

#
# (n)vim: neovim
#

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
  else
    _o all set
  fi
}

#
# bitwarden (cli)
#

btw() {
  _a bw

  tmp=/tmp/bw.zip
  bwp=/usr/local/bin/bw

  [[ -f "$bwp" ]] && sudo rm "$bwp"

  (sudo curl -L -o "$tmp" \
    'https://vault.bitwarden.com/download/?app=cli&platform=linux' \
    && sudo unzip $tmp -d /usr/local/bin) &> /dev/null

  sudo chmod +x "$bwp"

  bw completion --shell zsh > ~/.config/zsh/completion/_bw

  _o all set
}

#───────────────────────────────────────────────────────  dependencies  ──────#

source "./bin/bin/_distro"

_a dependencies
_o "${pkgs[@]}"

#
# archlinux
#

if [[ ${DISTRO} == arch* ]]; then

  # universal packages
  pacman -Qi "${pkgs[@]}" > /dev/null 2>&1 \
    || (sudo pacman -Syyy "${pkgs[@]}" && _o installed "${pkgs[@]}")

  # pacman specific
  pacman -Qi "${pacpkg[@]}" > /dev/null 2>&1 \
    || (sudo pacman -Syyy "${pacpkg[@]}" && _o installed "${pacpkg[@]}")

#
# debian, raspbian, ubuntu
#

elif [[ ${DISTRO} =~ raspbian*|debian*|ubuntu* ]]; then

  # universal packages
  dpkg -s "${pkgs[@]}" > /dev/null 2>&1 \
    || (sudo apt-get install -y "${pkgs[@]}" && _o installed "${pkgs[@]}")

  # apt specific
  dpkg -s "${aptpkg[@]}" > /dev/null 2>&1 \
    || (sudo apt-get install -y "${aptpkg[@]}" && _o installed "${aptpkg[@]}")

  # create path if not exists
  [[ ! -d  ~/.local/bin/ ]] && mkdir -p ~/.local/bin

  # link fdfind to fd
  [[ ! -L ~/.local/bin/fd ]] && ln -s "$(which fdfind)" ~/.local/bin/fd

#
# unknown distros
#

else

  _w "distro not configured" 
  _f distro: "$DISTRO"
  exit 1

fi

_s all set

#──────────────────────────────────────────────────────────  archlinux  ──────#

if [[ ${DISTRO} == arch* ]]; then

  # ask permission to procede
  if  _ask "archlinux: install everything?"; then
    _a "${U}"symlink: starting
    _o distro: "$DISTRO"
  else
    _a thank you for coming
    exit 0
  fi

  # prep for install
  cleanup

  #
  # tweaks
  #

  # make x11 folder [xsession-errors] TODO FIX .xsessions-error, still in ~
  [ -d ~/.config/x11 ] || mkdir -p ~/.config/x11

  # allow dmesg as user [notifications]
  sudo sysctl kernel.dmesg_restrict=0 > /dev/null

  # remove diff menu [yay]
  yay --editmenu --nodiffmenu --save

  #
  # install core dependencies
  #

  izsh
  ivim
  ifzf
  btw 

  #
  # move repo content into place
  #

  # stow /root
  _a root
  cd "$D"/root/ || (_e unable to cd root/ && exit 1)

  _o symlink: root/share to "${B}"/
  sudo stow -t / -R share

  _o symlink: root/workstation to "${B}"/
  sudo stow -t / -R workstation && _s

  # stow /home
  cd "$D" || (_e unable to cd base repo dir && exit 1)

  _a home
  _o symlink: [base dir] "${B}"\~

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
    [[ $(stow -R "$(basename "$dir")") -gt 0 ]] && _e "$(basename "$dir")"

  done # end of repo directory loop

  # repo: opt/
  cd "$D"/opt || (_e unable to cd into opt && exit 1)

  _o symlink: opt [rice cfg] "${B}"\~

  # repo: /opt/
  for dir in "$D"/opt/*/; do

    [[ $(stow -t "$HOME" -R "$(basename "$dir")") -gt 0 ]] \
      && _e "$(basename "$dir")"

  done 

  # set alacritty to xterm (i3 error, etc.)
  if [[ ! -f /usr/bin/xterm ]] && [[ ! -L /usr/bin/xterm ]]; then
    sudo ln -s /usr/bin/alacritty /usr/bin/xterm
  fi

  # update font cache
  fc-cache

  _s

#─────────────────────────────────────────────────────────────  debian  ──────#

else # not archlinux

  # zsh
  izsh

  # vim
  ivim

  # fzf
  ifzf

  # title
  _a "${B}symlink: ${GRN}${B}starting${NC}"
  _o distro: "$DISTRO"
  _i minimal install

  # remove old dotfile stuff
  cleanup

  # stow /root
  _a root

  cd "$D"/root/ \
    || (_e unable to cd root/ && exit 1)

  _o symlink: root '/'
  sudo stow -t / -R share

  # stow ~
  _a home

  cd "$D" \
    || (_e unable to cd base repo dir && exit 1)

  _o symlink: home "${B}"\~
  stow -R "${mini[@]}" && _i stowed: "${mini[@]}" && _s

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

_s installation complete 
echo

# exit successfully, despite not having checked lol
exit 0
