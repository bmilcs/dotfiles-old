#
# ZSHENV 
#- bmilcs
#
# executed on all shell invocations

#
# PATH
#

# add $PATH to path array | source: arch wiki
typeset -U PATH path  
path=("$HOME/bin"  "$path[@]")
export PATH

#
# REPO DIR
#

export D=$HOME/bm
export BAK=$HOME/.backup

#
# ENV VAR
#

export EDITOR=nvim
export VISUAL=nvim
