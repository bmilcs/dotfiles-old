#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   ──────────────────────
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#────────────────────────────────────────────────────────────
#   ZSH CORE
#────────────────────────────────────────────────────────────

[[ -d $HOME/.zplugin ]] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

#
# HISTORY
#

HISTFILE=~/.config/zsh/.zhistory
HISTSIZE=5000
SAVEHIST=5000
setopt SHARE_HISTORY          # share history between all sessions.
setopt APPEND_HISTORY         # add to history file, across sessions, not replace
setopt EXTENDED_HISTORY       # write the history file in the ':start:elapsed;command' format.
setopt HIST_IGNORE_DUPS       # do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS      # do not display a previously found event.
setopt HIST_SAVE_NO_DUPS      # do not write a duplicate event to the history file.
setopt HIST_EXPIRE_DUPS_FIRST # expire a duplicate event first when trimming history.
unsetopt HIST_VERIFY          # history expansion, execute the line directly
unsetopt HIST_VERIFY          # after history expansion, execute the line directly

#
# DIR_COLORS
#

[ -f "$D/zsh/.zsh/.dir_colors" ] && eval $($D/zsh/.zsh/.dir_colors)

#
# PLUGINS
# 

source ~/.zplugin/bin/zplugin.zsh
zplugin light zsh-users/zsh-completions 
zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting

#
# OPTIONS
#

set nocompatible
bindkey -v                    # vim mode
setopt autocd                 #
setopt beep                   #
setopt extendedglob           #
setopt nomatch                #
setopt interactivecomments    # allow comment in interactive mode
setopt combining_chars

#
# CORRECTIONS
#

CORRECT_ALL="true"
ENABLE_CORRECTION="true"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5E81AC,italic"

# fuzzy match mistypes
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'  # increase the number of errors based on the length of the typed word # but make sure to cap (at 7) the max-errors to avoid hanging.
# NEW END

#
# AUTOCOMPLETE
#

CASE_SENSITIVE="false"
setopt COMPLETE_ALIASES # auto complete aliases
zstyle ':completion:*' list-colors “${(s.:.)LS_COLORS}”
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case insensitive completions
zstyle ':completion:*' menu select # menu style, tab
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion::complete:*' gain-privileges 1 # elevate as needed
zstyle ':completion:*:matches' group yes
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
zstyle ':completion:*:messages' format '%F{purple}%d%f'
zstyle ':completion:*:warnings' format '%F{red}nothing%f'
zstyle ':completion:*' format '[%F{yellow}%B%d]'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:*:gtc:*' script ~/.zsh/completion/git-completion.bash
fpath=(~/.zsh/completion $fpath)


# NEW END


#
# AUTOLOADS
#

autoload -Uz promptinit compinit bashcompinit
autoload -Uz colors && colors # autoload colors
autoload -U up-line-or-beginning-search down-line-or-beginning-search

compinit -d /home/bmilcs/.config/zsh/.zcompdump
_comp_options+=(globdots)       # autocomplete .dotfiles
promptinit                      # 
bashcompinit

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

#
# PROMPT, COLORS, ETC. 
#

NL=$'\n'
PROMPT="%B%K{blue}%F{black}   %M   %b%K{black}%F{blue}   %n   %k%b%F{blue}  %~   %W   %@  [%?] ${NL}${cyan}# %b%f%k"

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
bindkey '^l' autosuggest-accept 
bindkey '^j' up-line-or-beginning-search
bindkey '^k' down-line-or-beginning-search
bindkey '^H' backward-kill-word # ctrl backspace delete word
bindkey '^[[3;5~' kill-word



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
# UNDER CONSTRUCTION
#



# 
# REFERENCES
#

# https://github.com/mimame/.dotfiles/blob/master/zsh/.zshrc
