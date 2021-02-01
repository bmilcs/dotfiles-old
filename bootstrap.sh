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

#────────────────────────────────────────────────────────────
# DISTRO CHECK
#────────────────────────────────────────────────────────────

if [ -f "/etc/arch-release" ]; then
  DISTRO='arch'; else DISTRO='debian'; fi

_t bmilcs/bootstrap initiated for $DISTRO

#────────────────────────────────────────────────────────────
# INSTALL REQUIRED PACKAGES
#────────────────────────────────────────────────────────────

_a checking for missing packages

# required software
reqs=("curl" "wget" "zsh" "neovim" "git" "stow")

# distro-based installation
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

  # if yes:
  if [[ $? == 0 ]]; then
    # stow: loop thru repo
    for dir in $D/*/ ; do
      # rsnapshot config > /etc/rsnapshot.conf
      if [[ $dir = $D/rsnapshot/ ]]; then
        sudo stow -t / -R $(basename $dir)
        _s stowed: rsnapshot
      # /usr/local/bin applcations
      elif [[ $dir = $D/usr/ ]]; then
        sudo stow -t /usr/ -R $(basename $dir)
        _s stowed: usr local bin
      # if not in repo /asset folder
      elif [[ ! $dir = $D/asset* ]]; then 
        stow -R $(basename $dir)
        # if exit status of last command sucked...
        [[ $? -gt 0 ]] && _e $(basename $dir)
      fi  
    # loop end
    done
  _s stowed: everything else
  # end of install everything
  _a stow completed
  fi

  # configure shell & vim via functions
  izsh
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

_t bmilcs/bootstrap complete

# exit successfully, despite not having checked lol
exit 0
