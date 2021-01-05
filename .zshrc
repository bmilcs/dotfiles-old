HISTFILE=~/.zhistory
HISTSIZE=5000
SAVEHIST=5000
setopt autocd beep extendedglob nomatch
bindkey -e
# bmilcs ---------------------------------------
# zplugin manager
source ~/.zplugin/bin/zplugin.zsh
zplugin light zsh-users/zsh-completions 
zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting
# zplugin load zdharma/history-search-multi-word
# zplugin load b4b4r07/enhancd
## prompt themes
autoload -Uz promptinit compinit
compinit -d /home/bmilcs/.config/zsh/.zcompdump
promptinit
# prompt
NL=$'\n'
PROMPT="%B%K{blue}%F{black}   %M   %b%K{black}%F{blue}   %n   %k%b%F{blue}  %~   %W   %@  [%?] ${NL}${cyan}# %b%f%k"
# 256color
export TERM=xterm-256color
# auto corrections
CORRECT_ALL="true"
ENABLE_CORRECTION="true"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5E81AC,bold"
# create a zkbd compatible hash; # to add other keys to this hash, see: man 5 terminfo
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


autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# partial command search up/down
#autoload -U up-line-or-beginning-search down-line-or-beginning-search
#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search
# setup key accordingly
#[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-beginning-search
#[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-beginning-search
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete
autoload Uz colors && colors # autoload colors
# ctrl arrows left/right 
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word
# bindkey -> zle -al (show all registered commands)
bindkey '^j' autosuggest-accept 
# ctrl backspace delete word
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word
setopt COMPLETE_ALIASES
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
CASE_SENSITIVE="false"
# case insensitive completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
bindkey -v  # vim mode
# ensure terminal is in application mode, when zle is active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
# fix locale issue : xselfont
LC_ALL=C
export LC_ALL
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


# autostart mpd
[ ! -s ~/.config/mpd/pid ] && mpd
# dotfiles, dir_colors
[ -f "$HOME/.aliases" ] && source $HOME/.aliases
[ -f "$HOME/.functions" ] && source $HOME/.functions
[ -f "$HOME/.dir_colors" ] && eval $(dircolors ~/.dir_colors)
# xcape: map control tap > escape (for vim)
xcape -e 'Control_L=Escape'
