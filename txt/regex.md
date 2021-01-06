	
	cat /etc/*-release | grep "^ID" | sed 's/.*=\(.*\)/\1/'
