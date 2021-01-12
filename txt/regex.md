	pwd | sed 's/\/home\/.*\/\(.*\)/\1/' | xargs mkdir -p
	cat /etc/*-release | grep "^ID" | sed 's/.*=\(.*\)/\1/'
