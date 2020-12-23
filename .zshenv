# zsh env -bmilcs
#   executed on all shell invocations

# path =+ ~/bin & ~/.c/bspwm/
export PATH=$PATH:/home/bmilcs/.config/bspwm:/home/bmilcs/bin

# add $PATH to path array 
typeset -U PATH path
path=("$HOME/.local/bin" /other/things/in/path "$path[@]")
export PATH

