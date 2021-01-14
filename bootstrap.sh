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
  exit 0
else

#
# DEB-BASED
#

  reqs=("curl" "zsh" "neovim" "git")
  dpkg -s "${reqs[@]}" >/dev/null 2>&1 || sudo apt-get install ${reqs[@]}

  # zplugins
  [[ -d ~/.zplugin ]] || ( mkdir -p ~/.zplugin && git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin )

  # vim-plug
  [[ -f ~/.local/share/nvim/site/autoload/plug.vim ]] || (echo "plug vim missing" && sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  [[ -d ~/.zsh ]] || stow -R zsh 
  [[ -d ~/.vim ]] || stow -R vim
  stow -R git bin
fi
















