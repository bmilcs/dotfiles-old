#!/bin/bash
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#────────────────────────────────────────────────────────────
#   DOTFILE REPO BOOTSTRAP / DEPLOYMENT              
#────────────────────────────────────────────────────────────
#   TODO 1. backup existing files
#        2. for cfg in pwd, stow -R $cfg
#────────────────────────────────────────────────────────────
source ./bin/bin/_head

# DISTRO CHECK

if [ -f "/etc/arch-release" ]; then
  DISTRO='arch'; else DISTRO='debian'; fi
  _t bmilcs/bootstrap initiated for $DISTRO

#────────────────────────────────────────────────────────────
# ARCHLINUX
#────────────────────────────────────────────────────────────

if [[ ${DISTRO} == "arch" ]]; then

  #
  # STOW 
  #

  for dir in ~/bm/*/ ; do
    if [[ ! $dir == *asset* ]]; then
      _i bootstraping $(basename $dir)...
      stow -R $(basename $dir)
      _s
    fi  
  done

#────────────────────────────────────────────────────────────
# DEBIAN
#────────────────────────────────────────────────────────────

else

  #
  # BASE PACKAGES
  #

  _a checking for missing packages
  reqs=("curl" "zsh" "neovim" "git")
  dpkg -s "${reqs[@]}" >/dev/null 2>&1 || ( sudo apt-get install ${reqs[@]} && _s installed ${reqs[@]})
  _s all packages present

  #
  # ZSH
  #

  if [[ ! -d ~/.zplugin ]]; then 
     _a zsh plugin setup started 
     mkdir -p ~/.zplugin ~/.config/zsh
     git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin 
     _s completed zsh plugin setup
  fi

  #
  # VIM 
  #

  if [[ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]]; then 
    _a vim-plug setup started 
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' 
    _s completed vim-plug setup
  fi

  #
  # STOW
  #

  _a stowing necessary files
  stowee=("bin" "zsh" "vim" "git" "txt")
  stow -R "${stowee[@]}" && _s ${stowee[@]} symlinked

  #
  # CHANGE SHELL
  #

  _ask swap to ZSH now?
  if [[ $? == 0 ]]; then
    chsh -s /usr/bin/zsh
  else
    _i ZSH skipped for now
  fi


fi

_t bmilcs/bootstrap complete

