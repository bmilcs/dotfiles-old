#/bin/bash
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


_t [bmilcs] bootstrap initiated
_o stowing everything includes system configuration files, such as: networkd, iwctl, pacman.conf, etc.

izsh() {
  if [[ ! -f ~/.zsh/completion/_git ]] || [[ ! -f ~/.zsh/completion/git-completion.bash ]] || [[ ! -d ~/.zplugin ]] || [[ ! -d ~/.zsh/completion ]] || [[ ! -d ~/.config/zsh ]] || [[ ! -d ~/.zsh/completion ]];then 
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
_a locating distro

if [ -f "/etc/arch-release" ]; then
  DISTRO='arch'; else DISTRO='debian'; fi

_i distro: $DISTRO 
#────────────────────────────────────────────────────────────
# INSTALL REQUIRED PACKAGES
#────────────────────────────────────────────────────────────

_a package requirements

# required software
reqs=("curl" "wget" "zsh" "neovim" "git" "stow")

# distro-based installation
if [[ ${DISTRO} == "arch" ]]; then
  pacman -Qi "${reqs[@]}" >/dev/null 2>&1 || ( sudo pacman -Syyy ${reqs[@]} && _s installed ${reqs[@]})
else
  dpkg -s "${reqs[@]}" >/dev/null 2>&1 || ( sudo apt-get install ${reqs[@]} && _s installed ${reqs[@]})
fi

_i all packages present

#────────────────────────────────────────────────────────────
# ARCHLINUX
#────────────────────────────────────────────────────────────

if [[ ${DISTRO} == "arch" ]]; then

  _ask stow EVERYTHING?

  # if yes:
  if [[ $? == 0 ]]; then

    _w \(re\)symlinking entire configuration

    # stow /root
    _a ${B}system-wide
    _o stowing: root ${B}/
    sudo stow -t / -R root
    _s 

    _a ${B}home-user
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
  _a zsh
  izsh
  _a vim
  ivim

# end of arch
else

#────────────────────────────────────────────────────────────
# DEB-BASED
#────────────────────────────────────────────────────────────

  # stow
  _a stowing necessary files
  stowee=("bin" "zsh" "vim" "git" "txt")
  stow -R "${stowee[@]}" && _s ${stowee[@]} symlinked

  # set repo url
  git remote set-url origin git@github.com:bmilcs/dotfiles.git 

  # configure vim/zsh
  izsh
  ivim

  # change shell
  _ask swap to ZSH now?
  if [[ $? == 0 ]]; then
    chsh -s /usr/bin/zsh
  else
    _i ZSH skipped for now
  fi

# end of deb-based install
fi

_t bootstrap complete

# exit successfully, despite not having checked lol
exit 0
