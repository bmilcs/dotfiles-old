#!/usr/bin/env bash
#────────────────────────────────────────────────────────────
#   DOTFILE REPO BOOTSTRAP / DEPLOYMENT              
#────────────────────────────────────────────────────────────
#   TODO 1. backup existing files
#        2. for cfg in pwd, stow -R $cfg
#────────────────────────────────────────────────────────────
source ./bin/bin/_head

# minimum installation
mini=("bin" "zsh" "vim" "git" "txt")

# mass installation exceptions 
exceptions=("asset" "pc" "root" "vm")

# required packages
reqs=("curl" "wget" "zsh" "neovim" "git" "stow")

# repo's base path
D=$HOME/bm

# title
_t [bmilcs] uninstall
_o removal of all symlinks inbound

# FUNCTIONS

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

# DISTRO CHECK

#_a distro check
#source ./root/usr/local/bin/_distro
#_s

# INSTALL PACKAGES

# _a package prerequisites
# _o "${reqs[@]}"
# 
# if [[ ${DISTRO} == arch* ]]; then
#   pacman -Qi "${reqs[@]}" >/dev/null 2>&1 || ( sudo pacman -Syyy "${reqs[@]}" && _o installed "${reqs[@]}")
# elif [[ ${DISTRO} == debian* ]]; then
#   dpkg -s "${reqs[@]}" >/dev/null 2>&1 || ( sudo apt-get install "${reqs[@]}" && _o installed "${reqs[@]}")
# else
#   _e distro not setup yet\! update me\! bootstrap.sh
#   exit 1
# fi
# 
# _s all set 
# echo

# GET STARTED

#if [[ ${DISTRO} == arch* ]]; then

  # ARCH LINUX

    _a ${B}symlink removal: ${GRN}${B}starting${NC}
    _o 

    # stow /root
    _a system-wide

    _o removing root from ${B}/
    sudo stow -t / -D root

    _o removing: pc from ${B}/
    sudo stow -t / -D pc
    _s 

    _a user-specific
    _o removing: everything @ home ${B}\~

    # loop through repo
    for dir in $D/*/ ; do

      match=0

      # if looped dir from above = an exception, match!
      for a in "${exceptions[@]}"; do
        [[ $dir == $D/$a/ ]] && match=1
      done

      # if match is found, skip this iteration
      [[ "$match" == 1 ]] && continue

      # not a match && stow it :)
      stow -D $(basename $dir)
      [[ $? -gt 0 ]] && _e $(basename $dir)

    done # end of repo directory loop

  _s 

  # end of [install everything]

  # shell & vim configs
  uzsh
  uvim

  # check active shell
  if [[ $SHELL == *zsh ]]; then
    # shell != zsh, ask to swap
    _a change shell: bash 
      chsh -s /usr/bin/zsh
  fi

_a uninstallation complete
echo

# exit successfully, despite not having checked lol
exit 0
