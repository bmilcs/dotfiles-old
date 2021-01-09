#
# bmilcs
# ZSH BOOTSTRAP
#

# load configs
for cfg (~/.zsh/*.zsh) source $cfg

# dir_colors
[ -f "~/.zsh/dir_colors" ] && eval $(dircolors ~/.zsh/dir_colors.zsh)
