#  ▄▄▄▄· • ▌ ▄ ·. ▪  ▄▄▌   ▄▄· .▄▄ ·   
#  ▐█ ▀█▪·██ ▐███▪██ ██•  ▐█ ▌▪▐█ ▀.   ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗
#  ▐█▀▀█▄▐█ ▌▐▌▐█·▐█·██ ▪ ██ ▄▄▄▀▀▀█▄   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗
#  ██▄▪▐███ ██▌▐█▌▐█▌▐█▌ ▄▐███▌▐█▄▪▐█  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝
#  ·▀▀▀▀ ▀▀  █▪▀▀▀▀▀▀.▀▀▀ ·▀▀▀  ▀▀▀▀   https://dot.bmilcs.com
#                 ZSH: CORE [./01-core.zsh]

# dotfile rc file debugging
. "${HOME}/bin/sys/dotfile_logger"
dotlog '+ $ZDOTDIR/01-core.zsh'

#────────────────────────────────────────────────────────────  HISTORY  ───────

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$ZDOTDIR/history/history
setopt SHARE_HISTORY          # share history between all sessions.
setopt APPEND_HISTORY         # add to history file, across sessions, not replace
setopt EXTENDED_HISTORY       # write the history file in the ':start:elapsed;command' format.
setopt HIST_IGNORE_DUPS       # do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS      # do not display a previously found event.
setopt HIST_REDUCE_BLANKS     # remove superfluous blanks for each command
setopt HIST_SAVE_NO_DUPS      # do not write a duplicate evT_EXPIRE_DUPS_FIRST # expire a duplicate event first when trimming history.
unsetopt HIST_VERIFY          # history expansion, execute the line directly

#──────────────────────────────────────────────────────────────  ZINIT  ───────

# custom paths
declare -A ZINIT
ZINIT[HOME_DIR]=${HOME}/.config/zinit
ZINIT[BIN_DIR]=${ZINIT[HOME_DIR]}/bin
ZINIT[PLUGINS_DIR]=${ZINIT[HOME_DIR]}/plugins
ZINIT[COMPLETIONS_DIR]=${ZINIT[HOME_DIR]}/completions
ZINIT[SNIPPETS_DIR]=${ZINIT[HOME_DIR]}/snippets
ZINIT[ZCOMPDUMP_PATH]=${ZDOTDIR}/compdump/zcompdump
source ${ZINIT[BIN_DIR]}/zinit.zsh

# plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma/fast-syntax-highlighting
zinit load wfxr/forgit

# dir_colors
[[ -f "$ZDOTDIR/dir_colors" ]] && eval $(dircolors $ZDOTDIR/dir_colors) 

# fzf path
[ -f ${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh" ] \
  && source "$HOME/.config/fzf/fzf.zsh"

#────────────────────────────────────────────────────────────  OPTIONS  ───────

set nocompatible              # not vi-backwards-compatible

# vim

bindkey -v                    # vim mode
export KEYTIMEOUT=1           # vim speed increase
function vi-yank-xclip {      # yank to the system clipboard
    zle vi-yank
    echo "$CUTBUFFER" | xclip -sel clip # -i
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# directory

setopt autocd                 # cd into dir's w/o cd prefix
setopt cdable_vars            # autocd, expand non-/path as ~
[[ $DISTRO == "arch"* ]] \
&& setopt cd_silent              # don't print dir after cd

# history

DIRSTACKSIZE=15               # dir stack limit
setopt autopushd              # cd = pushd (dir stack)
setopt pushdminus             # swaps + and - (dir stack)
setopt pushdsilent            # don't echo each pushd (dir stack)
setopt pushdtohome            # no arg =  ~ (dir stack)
setopt pushd_ignore_dups      # no mulitples (dir stack)
# d() function                # fzf dir stack

# completion

setopt rec_exact              # accept exact commands, no selection menu
setopt always_to_end          # mid-word completions get appended 
setopt auto_list              # list choices on ambiguous completion
setopt hash_list_all 
setopt numeric_glob_sort      # matched numeric filenames get sorted numerically
setopt menu_complete          # ins #1 match immediately & toggle thru them
#setopt glob_complete         # current word glob creates selection menu
#setopt list_ambiguous        # unambiguous prefix to insert w/o menu
#setopt list_packed           # reduce list length
#setopt list_rows_first       # horizontal a/ b/ c/ d.conf
#setopt list_types            # completions show identifying mark as last char

# miscellaneous

setopt nobeep                 # disable beep
setopt nomatch                #
setopt interactivecomments    # allow comment in interactive mode
setopt combining_chars
#setopt extendedglob          # disabled, breaks git reset HEAD^

#────────────────────────────────────────────────────────  AUTOCORRECT  ───────

CORRECT_ALL="true"
ENABLE_CORRECTION="true"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8,italic"

# fuzzy-matching
zstyle ':completion:*' completer _complete _match _approximate _prefix # test: prefix
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 2 numeric
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'  # increase the number of errors based on the length of the typed word # but make sure to cap (at 7) the max-errors to avoid hanging.

#───────────────────────────────────────────────────────  AUTOCOMPLETE  ───────

CASE_SENSITIVE="false"
zstyle ':completion:*' list-prompt   '' # remove warning, 'display all poss..?'
zstyle ':completion:*' select-prompt '' # remove warning, 'display all poss..?'
zstyle ':completion:*' list-colors “${(s.:.)LS_COLORS}” # colorize output
zstyle ':completion:*' matcher-list '' \
  '+m:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' # case insensitive
zstyle ':completion:*' menu select # menu style, tab
zstyle ':completion:*:*:*:*:*' menu select # always use menu select
zstyle ':completion::complete:*' gain-privileges 1 # elevate as needed
zstyle ':completion:*:matches' group yes # group by type
zstyle ':completion:*:options' description yes # show description
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
zstyle ':completion:*:messages' format '%F{magenta}%d%f'
zstyle ':completion:*:warnings' format '%F{red}nothing%f'
zstyle ':completion:*' format '%I%F{green}%d'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:git:*' script $ZDOTDIR/completion/git-completion.bash
fpath=($ZDOTDIR/completion $fpath)

# custom script completion
fpath=(~/bin/completions $fpath)

#────────────────────────────────────  '?' SEARCH THROUGH AUTOCOMPLETE  ───────

#zmodload -i zsh/complist
zmodload zsh/complist 
zstyle ':completion:*' menu yes select
bindkey -M menuselect '?' history-incremental-search-forward
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

#──────────────────────────────────────────────────────────  AUTOLOADS  ───────

# prompt
autoload -Uz promptinit && promptinit

# autocomplete
autoload -Uz compinit && compinit -d $ZDOTDIR/compdump/zcompdump

# bash autocomplete
autoload -Uz bashcompinit && bashcompinit

# autoload up/down w/ search
autoload -U up-line-or-beginning-search down-line-or-beginning-search

# autoload colors
autoload -Uz colors && colors 

# autocomplete .dotfiles
_comp_options+=(globdots)       

# pip completion
if [[ "$DISTRO" == "arch"* ]]; then
  eval "`pip completion --zsh`"
  compctl -K _pip_completion pip3
fi

#────────────────────────────────────────────────────────  KEYBINDINGS  ───────

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
#bindkey '^l' autosuggest-accept 
bindkey '^\n' autosuggest-accept 
bindkey '^j' up-line-or-beginning-search
bindkey '^k' down-line-or-beginning-search
#bindkey '^H' backward-kill-word # ctrl backspace delete word
#bindkey '^[[3;5~' kill-word

# ensure terminal is in application mode, when zle is active. Only then are the values from $terminfo valid.
#if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
#	autoload -Uz add-zle-hook-widget
#	function zle_application_mode_start { echoti smkx }
#	function zle_application_mode_stop { echoti rmkx }
#	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
#	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
#fi
