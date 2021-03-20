#!/usr/bin/env bash
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 DOTFILE INSTALLATION [./install.sh]
#────────────────────────────────────────────────────────────
source ./bin/bin/_bm

# title
_t [bmilcs] dotfile installation
_o this install script is specifically tailored to my needs.
_iy "${CYN}${B}arch${NC}": stows ALL: home \& sys configs, networkd, iwctl, etc
_iy "${CYN}${B}debian${NC}": stows minimal setup, defined by \$mini

#────────────────────────────────────────────────────────────
# INPUT
#────────────────────────────────────────────────────────────

# debian: install
mini=("bin" "git" "txt" "vim" "zsh" "bash") 

# arch: exceptions
exceptions=("img" "opt" "root")

# all: req packages
pkgs=("curl" "wget" "zsh" "neovim" "git" "stow" "colordiff")
aptpkg=("fd-find" "nodejs" "npm") # "bat"
pacpkg=("fd" "bat")

# backup location
backup=~/.backup/dotfiles

# repo path
D=$HOME/bm

# FUNCTIONS

# removal of old dotfile content
cleanup() {

  _a removing old dotfile content
  _w "content will be moved to $backup"
  mkdir -p "$backup"

  mv ~/{.bm*,.inputrc*,.dir_color*,.aliases,.functions,.profile,.bashrc*} \
    "$backup" 2> /dev/null
  rm -rf "$backup/git"
  mv ~/{.config/git,.gitconfig} "$backup/git" 2> /dev/null
  sudo mv /usr/local/bin/{up,upp} "$backup" 2> /dev/null
  #mv ~/.config/zsh/{_git,git-completion.bash} "$backup" 2> /dev/null

  _o deleting broken symlinks in "${B}"~
  find ~ -xtype l -exec rm {} \; 2> /dev/null && _s

  _o deleting broken symlinks "${B}"/etc
  sudo find ~ -xtype l -exec rm {} \; 2> /dev/null && _s
}

ifzf() {
  _a fzf
  if [[ ! -f ~/.config/fzf/bin/fzf ]]; then
    _o setup required
    _a fzf: installation
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.config/fzf
    ~/.config/fzf/install --xdg --no-update-rc --completion --key-bindings
  else
    _s all set
  fi
}

izsh() {
  _a zsh

  if [[ ! -d ~/.config/zsh ]] \
    || [[ ! -d ~/.config/zsh/completion ]] \
    || [[ ! -f ~/.config/zsh/completion/_git ]] \
    || [[ ! -f ~/.config/zsh/completion/git-completion.bash ]] \
    || [[ ! -f ~/.config/zsh/completion/_docker-compose ]]
  then

    # create directories
    mkdir -p ~/.zinit ~/.config/zsh/ ~/.config/zsh/completion

    # install zsh git completion
    _o installing git autocompletion
    curl -o ~/.config/zsh/completion/git-completion.bash \
      https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    curl -o ~/.config/zsh/completion/_git \
      https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
    curl -o ~/.config/zsh/completion/_docker-compose \
    https://raw.githubusercontent.com/docker/compose/1.28.5/contrib/completion/zsh/_docker-compose
  fi

  if [[ ! -d ~/.zinit ]]; then
    # install zinit
    _o installing zinit plugin manager
    git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
  fi

  _s all set
}

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
    _s all set
  fi
}

# DISTRO CHECK

_a distro check
source "./bin/bin/_distro" && _s

# INSTALL PACKAGES

_a dependencies
_o checking for: "${pkgs[@]}"

if [[ ${DISTRO} == arch* ]]; then
  pacman -Qi "${pkgs[@]}" > /dev/null 2>&1 \
    || (sudo pacman -Syyy "${pkgs[@]}" && _o installed "${pkgs[@]}")
  pacman -Qi "${pacpkg[@]}" > /dev/null 2>&1 \
    || (sudo pacman -Syyy "${pacpkg[@]}" && _o installed "${pacpkg[@]}")
elif [[ ${DISTRO} =~ ^(rasp|deb)ian* ]]; then
  dpkg -s "${pkgs[@]}" > /dev/null 2>&1 \
    || (sudo apt-get install -y "${pkgs[@]}" && _o installed "${pkgs[@]}")
  dpkg -s "${aptpkg[@]}" > /dev/null 2>&1 \
    || (sudo apt-get install -y "${aptpkg[@]}" && _o installed "${aptpkg[@]}")
  [[ ! -d  ~/.local/bin/ ]] && mkdir -p ~/.local/bin
  [[ ! -L ~/.local/bin/fd ]] && ln -s $(which fdfind) ~/.local/bin/fd
else
  _w "distro not configured" 
  _f distro: "$DISTRO"
  _i "fix: $D/install.sh"
  exit 1
fi

_s all set

#────────────────────────────────────────────────────────────
# GET STARTED
#────────────────────────────────────────────────────────────

# ARCH LINUX
if [[ ${DISTRO} == arch* ]]; then

  # allow dmesg as user
  sudo sysctl kernel.dmesg_restrict=0 > /dev/null

  # remove diff menu (yay)
  yay --editmenu --nodiffmenu --save

  # shell
  izsh

  #vim
  ivim

  #fzf
  ifzf

  _ask "stow EVERYTHING?"
  if [[ $? == 0 ]]; then

    _a "${U}"symlink: starting
    _o distro: "$DISTRO"

    # remove old dotfile stuff
    cleanup

    # stow /root
    _a system-wide
    cd "$D"/root/ || (_e unable to cd root/ && exit 1)

    _o stowing: root/share to "${B}"/
    sudo stow -t / -R share

    _o stowing: root/workstation to "${B}"/
    sudo stow -t / -R workstation
    _s

    cd "$D" || (_e unable to cd base repo dir && exit 1)

    _a user-specific
    _o stowing: essentials [base dir] "${B}"\~

    # repo: base dir stows
    for dir in "$D"/*/; do

      match=0

      # if looped dir from above = an exception, match!
      for a in "${exceptions[@]}"; do
        [[ $dir == $D/$a/ ]] && match=1
      done

      # if match is found, skip this iteration
      [[ "$match" == 1 ]] && continue

      # not a match && stow it :)

      [[ $(stow -R "$(basename "$dir")") -gt 0 ]] && _e "$(basename "$dir")"

    done # end of repo directory loop

    # repo: opt/
    cd "$D"/opt || (_e unable to cd into opt && exit 1)

    _o stowing: opt [rice cfg] "${B}"\~

    # loop through repo
    for dir in "$D"/opt/*/; do

      match=0

      # if looped dir from above = an exception, match!
      for a in "${exceptions[@]}"; do
        [[ $dir == $D/opt/$a/ ]] && match=1
      done

      # if match is found, skip this iteration
      [[ "$match" == 1 ]] && continue

      # not a match && stow it :)

      [[ $(stow -t "$HOME" -R "$(basename "$dir")") -gt 0 ]] \
        && _e "$(basename "$dir")"

    done # end of repo directory loop

    # set alacritty to xterm (i3 error, etc.)
    if [[ ! -f /usr/bin/xterm ]] && [[ ! -L /usr/bin/xterm ]]; then
      sudo ln -s /usr/bin/alacritty /usr/bin/xterm
    fi

    # update font cache
    fc-cache

    _s

  fi # end of [install everything]

else # DEBIAN

  # zsh
  izsh

  # vim
  ivim

  #fzf
  ifzf

  _a "${B}symlink: ${GRN}${B}starting${NC}"
  _o distro: "$DISTRO"
  _i minimal install

  # remove old dotfile stuff
  cleanup

  # stow /root
  _a system-wide

  cd "$D"/root/ || (_e unable to cd root/ && exit 1)

  _o stowing: root'/'
  sudo stow -t / -R share

  # stow /home/user/
  _a user-specific
  cd "$D" || (_e unable to cd base repo dir && exit 1)

  _o stowing: essentials [base dir] "${B}"\~

  _o stowing: home "${B}"\~
  stow -R "${mini[@]}" && _i stowed: "${mini[@]}"

  _s

  # set repo url
  _a setting origin/main url
  git remote set-url origin git@github.com:bmilcs/dotfiles.git
  _s

  # check active shell
  if [[ ! $SHELL == *zsh ]]; then
    # shell != zsh, ask to swap

    if [[ $(_ask swap to ZSH now?) == 0 ]]; then
      chsh -s /usr/bin/zsh
    else
      _i skipping. reboot recommended!
    fi
  fi

# end of debian
fi

_a bootstrap complete
echo

# exit successfully, despite not having checked lol
exit 0
