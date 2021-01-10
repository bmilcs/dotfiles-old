
# Setup fzf
# ---------
if [[ ! "$PATH" == */home/bmilcs/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/bmilcs/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/bmilcs/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/bmilcs/.fzf/shell/key-bindings.zsh"
