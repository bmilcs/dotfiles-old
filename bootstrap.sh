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

#────────────────────────────────────────────────────────────
# FUNCTIONS
#────────────────────────────────────────────────────────────

izsh() {
  if [[ ! -d ~/.zplugin ]] || [[ ! -d ~/.zsh/completion ]] || [[ ! -d ~/.config/zsh ]] || [[ ! -d ~/.zsh/completion ]];then 
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

_t bmilcs/bootstrap initiated for $DISTRO

if [ -f "/etc/arch-release" ]; then
  DISTRO='arch'; else DISTRO='debian'; fi

#────────────────────────────────────────────────────────────
# ARCHLINUX
#────────────────────────────────────────────────────────────

#if [[ ${DISTRO} == "arch" ]]; then

  _ask install everything?
  if [[ $? == 0 ]]; then
    # STOW 
    for dir in ~/bm/*/ ; do
      if [[ $dir == rsnapshot ]]; then
        sudo stow -t / -R $(basename sdir)
      elif [[ ! $dir == *asset* ]]; then 
        stow -R $(basename $dir)
        [[ $? -gt 0 ]] && _e $(basename $dir)
      fi  
    done
    exit 0   
  fi

  # VIM/ZSH
  izsh
  ivim

#else

#────────────────────────────────────────────────────────────
# DEBIAN
#────────────────────────────────────────────────────────────

  # BASE PACKAGES
  _a checking for missing packages
  reqs=("curl" "zsh" "neovim" "git")

  if [[ ${DISTRO} == "arch" ]]; then
    dpkg -s "${reqs[@]}" >/dev/null 2>&1 || ( sudo pacman -S ${reqs[@]} && _s installed ${reqs[@]})
  else
    dpkg -s "${reqs[@]}" >/dev/null 2>&1 || ( sudo apt-get install ${reqs[@]} && _s installed ${reqs[@]})
  fi
  _s all packages present

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

fi
_t bmilcs/bootstrap complete

