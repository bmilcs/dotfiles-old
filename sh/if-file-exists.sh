#!/bin/bash
# if file exists

	FILE=/etc/resolv.conf
	if test -f "$FILE"; then
    	echo "$FILE exists."
	fi

# last command = error / failed

	# if then
	if <command> ; then
		echo good
	else
		echo bad
	fi

	# 1 liner
	command || { echo 'command failed' ; exit 1; }
