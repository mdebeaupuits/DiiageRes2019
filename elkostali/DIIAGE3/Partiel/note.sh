#!/bin/bash
if [ $# -eq 0 ]
then
	read -p "What is your score ? " note
fi
if [ $# -eq 1 ]
then
	note=$1
fi

while [  "$note" -gt 10 ]; do
	read -p "What is your score ? " note
done
if [ "$note" -ge 9 ]; then 
    echo "Perfect" 
elif [ "$note" -ge 7 ]; then 
    echo "Good" 
elif [ "$note" -ge 5 ]; then 
    echo "Not bad" 
elif [[ "$note" -ge 2 ]]; then 
    echo "Not good" 
elif [ "$note" -le 2 ]; then
    echo "Bad" 
fi
