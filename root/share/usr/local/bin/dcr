#!/bin/bash
NC='\033[0m';B='\033[1m';DIM='\033[2m';ITAL='\033[3m';UL='\033[4m';BLINK='\033[5m';INV='\033[7m'; BLK=${NC}'\033[30m';RED=${NC}'\033[31m';GRN=${NC}'\033[32m';YLW=${NC}'\033[33m';BLU=${NC}'\033[34m';PUR=${NC}'\033[35m';CYN=${NC}'\033[36m';WHT=${NC}'\033[37m';TIME="$(date +"%I:%M %P")"
set -e
echo -e "${PUR}• ${BLU}docker-compose update ${NC}"
(cd ~/docker ; docker-compose up -d --remove-orphans)
(/usr/bin/git --git-dir=$HOME/docker/.git/ --work-tree=$HOME/docker commit -a -m "update" ; /usr/bin/git --git-dir=/home/bmilcs/docker/.git/ --work-tree=/home/bmilcs/docker push)
echo -e "  ${GRN}[√] done.${NC}\n"

# rm -rf /tmp/docker 
# git clone git@github.com:bmilcs/docker.git /tmp/docker
# rm -f ~/docker/docker-compose.yaml ~/docker/.env
# cp /tmp/docker/1docker-compose.yaml /tmp/docker/.env ~/docker/
# cd ~/docker
# mv ~/docker/1docker-compose.yaml ~/docker/docker-compose.yaml