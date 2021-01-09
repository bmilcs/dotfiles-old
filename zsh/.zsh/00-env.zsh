# ZSHENV 
# - bmilcs
# 
# executed on all shell invocations


 


#
# PATH
#

typeset -U PATH path  # add $PATH to path array | source: arch wiki
path=("$HOME/bin"  "$path[@]")
export PATH

#
# REPO DIR
#

export DOT=$HOME/bm
