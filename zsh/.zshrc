#
# bmilcs:
# ZSH BOOTSTRAP
#


# load configs
for cfg (~/.zsh/**/*.zsh) source $cfg

# dir_colors
[ -f "$DOT/zsh/.zsh/dir_colors.zsh" ] && eval $(dircolors $DOT/zsh/.zsh/dir_colors.zsh)
