#
# SETUP FZF
#

if [[ ! "$PATH" == */home/bmilcs/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/bmilcs/.fzf/bin"
fi

# auto-completion
[[ $- == *i* ]] && source "/home/bmilcs/.fzf/shell/completion.zsh" 2> /dev/null

# key bindings
source "/home/bmilcs/.fzf/shell/key-bindings.zsh"


# exclude .git
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
  }
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
  }
