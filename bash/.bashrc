#
# BASHRC
# -bmilcs
#

# W/O INTERACTION > DO NOTHING
[[ $- != *i* ]] && return

# PROMPT
PS1='[\u@\h \W]\$ '

# ALIASES
alias ls='ls --color=auto'

#
# FZF
#

if [[ ! "$PATH" == */home/bmilcs/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/bmilcs/.fzf/bin"
fi
[[ $- == *i* ]] && source "/home/bmilcs/.fzf/shell/completion.bash" 2> /dev/null
source "/home/bmilcs/.fzf/shell/key-bindings.bash"
