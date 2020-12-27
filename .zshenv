# zsh env -bmilcs
#   executed on all shell invocations

# add $PATH to path array 
typeset -U PATH path
path=("$HOME/.local/bin"  "$path[@]")
export PATH
