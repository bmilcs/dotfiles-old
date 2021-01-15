#!/bin/bash
#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#────────────────────────────────────────────────────────────
#   dotfile repo bootstrap / deployment              
#────────────────────────────────────────────────────────────
#     TODO 1. backup existing files
#          2. for cfg in pwd, stow -R $cfg

source ./bin/bin/_head

if [ -f "/etc/arch-release" ]; then
  DISTRO='arch'; else DISTRO='debian'; fi
  _t bmilcs/bootstrap initiated for $DISTRO

#
# ARCHLINUX
#

if [[ ${DISTRO} == "arch" ]]; then
  for dir in ~/bm/*/ ; do
    if [[ ! $dir == *txt* ]] && [[ ! $dir == *asset* ]]; then
      _i bootstraping $(basename $dir)...
      stow -R $(basename $dir)
      _s
    fi  
  done
  _t bmilcs/bootstrap complete

else

#
# DEB-BASED
#

_a checking for missing packages

  reqs=("curl" "zsh" "neovim" "git")
  dpkg -s "${reqs[@]}" >/dev/null 2>&1 || ( sudo apt-get install ${reqs[@]} && _s installed ${reqs[@]})

  _s all packages present

  # zplugins
  [[ -d ~/.zplugin ]] || ( _a zsh plugin setup started ; mkdir -p ~/.zplugin && git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin && _s completed zsh plugin setup )
mkdir -p ~/.config/zsh
  # vim-plug
  [[ -f ~/.local/share/nvim/site/autoload/plug.vim ]] || (_a vim-plug setup started && sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' && _s completed vim-plug setup)

  _a stowing necessary files
  [[ -d ~/.zsh ]] || stow -R zsh && _s stowed zsh
  [[ -d ~/.vim ]] || stow -R vim && _s stowed vim
  stow -R git bin && _s stowed git, bin
fi


