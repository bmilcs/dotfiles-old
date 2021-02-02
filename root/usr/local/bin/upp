#!/bin/bash
NC='\033[0m';B='\033[1m';DIM='\033[2m';ITAL='\033[3m';UL='\033[4m';BLINK='\033[5m';INV='\033[7m'; BLK=${NC}'\033[30m';RED=${NC}'\033[31m';GRN=${NC}'\033[32m';YLW=${NC}'\033[33m';BLU=${NC}'\033[34m';PUR=${NC}'\033[35m';CYN=${NC}'\033[36m';WHT=${NC}'\033[37m';TIME="$(date +"%I:%M %P")"
#===  update_repo.sh  =====================================================================#
CHECK_PAC=$(which pacman)
if [[ ! -z $CHECK_PAC ]]; then
	echo 'error: arch-based distro. ignoring bmilcs-linux github.'
else
	set -e
	echo -e "${BLU}[ ${B}github pull ${BLU}]${NC}\n"
	(cd ~ && rm -rf ~/.bm_* ~/.dir_colors ~/.bm ~/.bmilcs ~/_bmilcs && git clone https://github.com/bmilcs/linux.git ~/.bmilcs > /dev/null && chmod -R +x ~/.bmilcs && cd ~/.bmilcs/dotfiles > /dev/null ; ./install.sh > /dev/null && source ~/.bashrc > /dev/null)
	echo -e "  ${GRN}[√] done.${NC}\n"
fi
# echo -e "${BLU}${DIM}----  ${BLU}bmilcs.git update: ${GRN}completed  ${BLU}${DIM}---------------------------------------------------------------\n${NC}"    