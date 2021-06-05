eval "`pip completion --zsh`"
compctl -K _pip_completion pip3

_get_comp_words_by_ref() { :; }
compopt() { :; }
_filedir() { :; }
eval "$(beet completion)"

#────────────────────────────────────────────────────────────  example  ───────

# _i3()
# {
#   _script_commands=$(/path/to/your/script.sh shortlist)
# 
#   local cur
#   COMPREPLY=()
#   cur="${COMP_WORDS[COMP_CWORD]}"
#   COMPREPLY=( $(compgen -W "${_script_commands}" -- ${cur}) )
# 
#   return 0
# }
# complete -o nospace -F _script ./admin.sh
