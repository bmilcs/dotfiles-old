#!/usr/bin/env bash
#────────────────────────────────────────────────────────────
#   DOTFILE REPO BOOTSTRAP / DEPLOYMENT              
#────────────────────────────────────────────────────────────
#   TODO 1. backup existing files
#        2. for cfg in pwd, stow -R $cfg
#────────────────────────────────────────────────────────────

source ./bin/bin/_head
D=$HOME/bm

_t [bmilcs] bootstrap initiated
_o stowing everything includes system configuration files, such as: networkd, iwctl, pacman.conf, etc.

#────────────────────────────────────────────────────────────
# FUNCTIONS
#────────────────────────────────────────────────────────────

izsh() {
  _a zsh
  if [[ ! -f ~/.zsh/completion/_git ]] || [[ ! -f ~/.zsh/completion/git-completion.bash ]] || [[ ! -d ~/.zplugin ]] || [[ ! -d ~/.zsh/completion ]] || [[ ! -d ~/.config/zsh ]] ||  [[ ! -d ~/.zsh/completion ]]; then 
     _o setup required_
     _aa installing: zplugin
     # create directories
     mkdir -p ~/.zplugin ~/.config/zsh/ ~/.zsh/completion
     # install zplugin
     git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin 
     _s
     # install zsh git completion
     curl -o ~/.zsh/completion/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
     curl -o ~/.zsh/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
     _s 
  else
    _o setup not required 
    _s
  fi
  }

ivim() {
  _a vim
  if [[ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]]; then
     _o setup required_
     _aa installing vim-plug
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' 
    _s 
  else
    _o setup not required 
    _s 
  fi
  }

#────────────────────────────────────────────────────────────
# DISTRO CHECK
#────────────────────────────────────────────────────────────

source ./root/usr/local/bin/_distro

_a distro check
_s

#────────────────────────────────────────────────────────────
# INSTALL REQUIRED PACKAGES
#────────────────────────────────────────────────────────────

reqs=("curl" "wget" "zsh" "neovim" "git" "stow")

_a package prerequisites
_o ${reqs[@]}

if [[ ${DISTRO} == Arch* ]]; then
  pacman -Qi "${reqs[@]}" >/dev/null 2>&1 || ( sudo pacman -Syyy "${reqs[@]}" && _o installed "${reqs[@]}")
else
  dpkg -s "${reqs[@]}" >/dev/null 2>&1 || ( sudo apt-get install "${reqs[@]}" && _o installed "${reqs[@]}")
fi

_s all set 
echo

#────────────────────────────────────────────────────────────
# ARCHLINUX
#────────────────────────────────────────────────────────────

if [[ ${DISTRO} == "arch" ]]; then

  _ask stow EVERYTHING?

  # if yes:
  if [[ $? == 0 ]]; then

    _a ${B}symlink: ${GRN}${B}starting${NC}
    _o distro: $DISTRO 

    # stow /root
    _a system-wide
    _o stowing: root ${B}/
    sudo stow -t / -R root
    _s 

    _a home-user
    _o stowing: home ${B}\~
    for dir in $D/*/ ; do
      if [[ ! $dir = $D/asset/ ]] && [[ ! $dir = $D/root/ ]]; then 
        stow -R $(basename $dir)
        # if exit status of last command sucked...
        [[ $? -gt 0 ]] && _e $(basename $dir)
      fi  
    # loop end
    done
  # end of [install everything?]
  _s 
  fi

  # configure shell & vim via functions
  izsh
  ivim

# end of arch
else
#────────────────────────────────────────────────────────────
# DEB-BASED
#────────────────────────────────────────────────────────────

  _a ${B}symlink: ${GRN}${B}starting${NC}
  _o distro: $DISTRO 
  _i minimal install 

  # stow /root
  _a system-wide
  _o stowing: root\/
  _o stowing: vm\/
  sudo stow -t / -R root
  _s 

  _a home-user
  _o stowing: home ${B}\~

  # stow
  stowee=("bin" "zsh" "vim" "git" "txt")
  stow -R "${stowee[@]}" && _s ${stowee[@]} symlinked

  # set repo url
  git remote set-url origin git@github.com:bmilcs/dotfiles.git 

  # configure vim/zsh
  izsh
  ivim

  # check active shell
  if [[ ! $SHELL == *zsh ]]; then
    # shell != zsh, ask to swap
    _ask swap to ZSH now?
    if [[ $? == 0 ]]; then
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
