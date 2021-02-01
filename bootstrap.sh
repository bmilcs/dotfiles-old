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
D=$HOME/bm

#────────────────────────────────────────────────────────────
# FUNCTIONS
#────────────────────────────────────────────────────────────

izsh() {
  if [[ ! -f ~/.zsh/completion/_git ]] || [[ ! -f ~/.zsh/completion/git-completion.bash ]] || [[ ! -d ~/.zplugin ]] || [[ ! -d ~/.zsh/completion ]] || [[ ! -d ~/.config/zsh ]] || [[ ! -d ~/.zsh/completion ]];then 
     _a zsh setup required
     # create directories
     mkdir -p ~/.zplugin ~/.config/zsh/ ~/.zsh/completion
     # install zplugin
     git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin 
     # install zsh git completion
     curl -o ~/.zsh/completion/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
     curl -o ~/.zsh/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
     _s completed zsh plugin setup
  fi
}

ivim() {
  if [[ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]]; then
    _a vim-plug setup started 
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' 
    _s completed vim-plug setup
  fi
}


# DISTRO CHECK
if [ -f "/etc/arch-release" ]; then
  DISTRO='arch'; else DISTRO='debian'; fi
  _t bmilcs/bootstrap initiated for $DISTRO

# BASE PACKAGES
_a checking for missing packages
reqs=("curl" "wget" "zsh" "neovim" "git" "stow")

if [[ ${DISTRO} == "arch" ]]; then
  pacman -Qi "${reqs[@]}" >/dev/null 2>&1 || ( sudo pacman -Syyy ${reqs[@]} && _s installed ${reqs[@]})
else
  dpkg -s "${reqs[@]}" >/dev/null 2>&1 || ( sudo apt-get install ${reqs[@]} && _s installed ${reqs[@]})
fi

_s all packages present

#────────────────────────────────────────────────────────────
# ARCHLINUX
#────────────────────────────────────────────────────────────

if [[ ${DISTRO} == "arch" ]]; then

  _ask install everything?
  if [[ $? == 0 ]]; then

    # STOW 
    for dir in $D/*/ ; do
      if [[ $dir = $D/rsnapshot/ ]]; then
        sudo stow -t / -R $(basename $dir)
        _s stowed: rsnapshot
      elif [[ $dir = $D/usr/ ]]; then
        sudo stow -t /usr/ -R $(basename $dir)
        _s stowed usr local bin
      elif [[ ! $dir = *asset* ]]; then 
        stow -R $(basename $dir)
        [[ $? -gt 0 ]] && _e $(basename $dir)
      fi  
    done
  fi
  _a stow completed
  # VIM/ZSH
  izsh
  ivim
  exit 0
fi

#────────────────────────────────────────────────────────────
# DEBIAN
#────────────────────────────────────────────────────────────


  # CONFIGURE VIM/ZSH
  izsh
  ivim
  
  # STOW
  _a stowing necessary files
  stowee=("bin" "zsh" "vim" "git" "txt")
  stow -R "${stowee[@]}" && _s ${stowee[@]} symlinked

  # SET REPO URL
  git remote set-url origin git@github.com:bmilcs/dotfiles.git 

  # CHANGE SHELL
  _ask swap to ZSH now?
  if [[ $? == 0 ]]; then
    chsh -s /usr/bin/zsh
  else
    _i ZSH skipped for now
  fi

_t bmilcs/bootstrap complete

