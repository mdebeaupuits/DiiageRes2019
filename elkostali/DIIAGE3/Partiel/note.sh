#!/bin/bash
if [ $# -eq 0 ]
then
	read -p "What is your score ? " note
fi
if [ $# -eq 1 ]
then
	note=$1
fi
if [ $# -gt 1 ]
then
	while [ $# -ne 0 ]; do
	note=$1
		while [[  "$note" -gt 10 || "$note" -lt 0 ]]; do
        		echo "[Error] Your score is not in the range 0 to 10"
        		read -p "What is your score ? " note
		done
		if [ "$note" -ge 9 ]; then
    			echo "$note -> Perfect"
		elif [ "$note" -ge 7 ]; then
    			echo "$note -> Good"
		elif [ "$note" -ge 5 ]; then
    			echo "$note -> Not bad"
		elif [[ "$note" -ge 2 ]]; then
    			echo "$note -> Not good"
		elif [ "$note" -le 2 ]; then
    			echo "$note -> Bad"
		fi
	shift
	done
fi
#while [[  "$note" -gt 10 || "$note" -lt 0 ]]; do
#	echo "[Error] Your score is not in the range 0 to 10"
#	read -p "What is your score ? " note
#done
#if [ "$note" -ge 9 ]; then 
#    echo "Perfect" 
#elif [ "$note" -ge 7 ]; then 
#    echo "Good" 
#elif [ "$note" -ge 5 ]; then 
#    echo "Not bad" 
#elif [[ "$note" -ge 2 ]]; then 
#    echo "Not good" 
#elif [ "$note" -le 2 ]; then
#    echo "Bad" 
#fi
