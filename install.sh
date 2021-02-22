#!/usr/bin/env bash
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 DOTFILE INSTALLATION [./install.sh]
#────────────────────────────────────────────────────────────
#   TODO 1. backup existing files
#        2. for cfg in pwd, stow -R $cfg
#────────────────────────────────────────────────────────────
source ./bin/bin/_head

# minimum installation
mini=("bin" "git" "txt" "vim" "zsh")

# mass installation exceptions
exceptions=("img" "opt" "root")

# required packages
reqs=("curl" "wget" "zsh" "neovim" "git" "stow" "colordiff")

# repo's base path
D=$HOME/bm

# title
_t [bmilcs] bootstrap initiated
_o stowing everything includes system configuration files, such as: networkd, iwctl, pacman.conf, etc.

# FUNCTIONS

# removal of old dotfile content
cleanup() {
  _a removing old dotfile content
  _w "content will be moved to ~/.backup/dotfiles"
  mkdir -p ~/.backup/dotfiles
  mv ~/{.bm*,.inputrc*,.dir_color*,.aliases,.functions} ~/.backup/dotfiles 2> /dev/null
  mv ~/.zsh/{completion/,}{_git,git-completion.bash} ~/.backup/dotfiles 2> /dev/null
  sudo mv /usr/local/bin/{up,upp} ~/.backup/dotfiles 2> /dev/null
  _a deleting broken symlinks in "${B}"~
  find ~ -xtype l -exec rm {} \; 2> /dev/null
  _a deleting broken symlinks "${B}"/etc]
  sudo find ~ -xtype l -exec rm {} \; 2> /dev/null
  _s
}

izsh() {
  _a zsh
  if [[ ! -f ~/.zsh/completion/_git ]] || [[ ! -f ~/.zsh/completion/git-completion.bash ]] || [[ ! -d ~/.zinit ]] || [[ ! -d ~/.zsh/completion ]] || [[ ! -d ~/.config/zsh ]]; then
    _o setup required_
    # create directories
    mkdir -p ~/.zinit ~/.config/zsh/ ~/.zsh/completion
    # install zsh git completion
    _a zsh: git autocompletion
    curl -o ~/.zsh/completion/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    curl -o ~/.zsh/completion/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
    _s
    # install zinit
    _a zsh: zinit plugin manager
    git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
    _s
  else
    _o setup not required
    _s
  fi
}

ivim() {
  _a vim
  if [[ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]]; then
    _o setup required
    _a vim: vim-plug plugin manager
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    _s
  else
    _o setup not required
    _s
  fi
}

ifzf() {
  if [[ ! -d ~/.fzf ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  fi
}

# DISTRO CHECK

_a distro check
source ./bin/bin/_distro
_s

# INSTALL PACKAGES

_a package prerequisites
_o "${reqs[@]}"

if [[ ${DISTRO} == arch* ]]; then
  pacman -Qi "${reqs[@]}" > /dev/null 2>&1 || (sudo pacman -Syyy "${reqs[@]}" && _o installed "${reqs[@]}")
elif [[ ${DISTRO} == debian* ]]; then
  dpkg -s "${reqs[@]}" > /dev/null 2>&1 || (sudo apt-get install "${reqs[@]}" && _o installed "${reqs[@]}")
else
  _e distro not setup yet\! update me\! install.sh
  exit 1
fi

_s all set

#────────────────────────────────────────────────────────────
# GET STARTED
#────────────────────────────────────────────────────────────

# ARCH LINUX
if [[ ${DISTRO} == arch* ]]; then

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

      [[ $(stow -t "$HOME" -R "$(basename "$dir")") -gt 0 ]] && _e "$(basename "$dir")"

    done # end of repo directory loop

    _s

  fi # end of [install everything]

else # DEBIAN

  # zsh
  izsh

  # vim
  ivim

  #fzf
  ifzf

  _a "${B}"symlink: "${GRN}""${B}"starting"${NC}"
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
