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

if [[ $DISTRO = arch ]]; then

  stow -R bash bin bspwm clipit dev gtk-2.0 gtk-3.0 htop i3 mpd ncmpcpp neofetch nitrogen picom polybar rofi sxhkd thunar tmux vim xorg zsh

else

  reqs=("curl" "zsh" "neovim" "git")
  dpkg -s "${reqs[@]}" >/dev/null 2>&1 || sudo apt-get install ${reqs[@]}

  # zplugins
  [[ -d ~/.zplugin ]] || ( mkdir -p ~/.zplugin && git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin )

  # vim-plug
  [[ -f ~/.local/share/nvim/site/autoload/plug.vim ]] || (echo "plug vim missing" && sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')


  [[ -d ~/.zsh ]] || stow -R zsh 
  [[ -d ~/.vim ]] || stow -R zsh vim
  stow -R git bin
fi
















