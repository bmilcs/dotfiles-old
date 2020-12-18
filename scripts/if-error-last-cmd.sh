#!/bin/bash
# if last command exit status 

	# if/then
	if <command> ; then
		echo good
	else
		echo bad
	fi

	# 1-liner
	command || { echo 'command failed' ; exit 1; }

# exit status
	true
		returns 0
	! true
		returns 1