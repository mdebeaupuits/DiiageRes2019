#!/bin/bash
#If the user type a number of lines required
if [[ $# -eq 1 ]]
	then
		if ! [ "$1" -eq "$1" ] 2> /dev/null
		then
			echo "[Error]Type a number of lines"
		fi 
		#Run the command with the number of lines needed by the user
		lines=$((8+$1-1))
		top -b -n 1 | head -n $lines | grep " S  "
#If the user send more of one parameter
elif [[ $# -gt 1 ]]
	then
		echo "[Error]Give nothing or give a number of process"
		exit
#If no parameters
else
	top -b -n 1 | head -n 8 | grep " S  "
fi
