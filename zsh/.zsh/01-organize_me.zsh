#
# ZSH
# -bmilcs
#

#
# HISTORY
#

HISTFILE=~/.config/zsh/.zhistory
HISTSIZE=5000
SAVEHIST=2500
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt autocd beep extendedglob nomatch
bindkey -e

#
# PLUGINS
# 

source ~/.zplugin/bin/zplugin.zsh
zplugin light zsh-users/zsh-completions 
zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting


#
# PROMPT, COLORS, ETC. 
#

autoload -Uz promptinit compinit bashcompinit
autoload Uz colors && colors # autoload colors
compinit -d /home/bmilcs/.config/zsh/.zcompdump
promptinit
bashcompinit
NL=$'\n'
PROMPT="%B%K{blue}%F{black}   %M   %b%K{black}%F{blue}   %n   %k%b%F{blue}  %~   %W   %@  [%?] ${NL}${cyan}# %b%f%k"

#
# AUTO CORRECTIONS
#

CORRECT_ALL="true"
ENABLE_CORRECTION="true"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5E81AC,bold"

#
# KEYBINDINGS
#

typeset -g -A key
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"


#
# HISTORY SEARCH 
# TODO: FIX PARTIAL SEARCH
#

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-beginning-search
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-beginning-search
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

# TODO: bindkey -> zle -al (show all registered commands)
# TODO: FIX AUTOSUGGEST-ACCEPT BINDING
bindkey '^j' autosuggest-accept 
bindkey '^H' backward-kill-word # ctrl backspace delete word
bindkey '^[[3;5~' kill-word


#
# AUTOCOMPLETE
#

setopt COMPLETE_ALIASES # auto complete aliases
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case insensitive completions
CASE_SENSITIVE="false"
zstyle ':completion:*' menu select # menu style, tab
zstyle ':completion::complete:*' gain-privileges 1 # elevate as needed

bindkey -v  # vim mode
# ensure terminal is in application mode, when zle is active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# coax into rehashing its own command cache once out of date | needed by /etc/pacman.d/hooks/zsh.hook (arch manual - bmilcs)
zshcache_time="$(date +%s%N)"
autoload -Uz add-zsh-hook
rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}
add-zsh-hook -Uz precmd rehash_precmd


# 
# DIR_COLORS
#
[ -f "$HOME/.dir_colors" ] && eval $(dircolors ~/.dir_colors)

#
# XCAPE CTRL=ESCAPE
#
xcape -e 'Control_L=Escape'





#
# UNDER CONSTRUCTION
#
