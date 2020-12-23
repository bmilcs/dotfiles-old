# zsh env -bmilcs

# dotfiles, dir_colors
[ -f "$HOME/.aliases" ] && source $HOME/.aliases
[ -f "$HOME/.functions" ] && source $HOME/.functions
[ -f "$HOME/.dir_colors" ] && eval $(dircolors ~/.dir_colors)
[ -f "$HOME/.env" ] && eval $(dircolors ~/.env)

