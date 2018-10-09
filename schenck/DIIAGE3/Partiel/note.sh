#!/bin/bash
set -xv
echo "What is your score:"
read note

if [ "$note" -gt 10 ]
then
	echo "[Error] Your score is not in the range 0 to 10"
elif [ "$note" -ge 9 ]
then
	echo "Perfect"
elif [ "$note" -ge 7 ]
then
	echo "Good"
elif [ "$note" -ge 5 ]
then
	echo "Not bad"
elif [ "$note" -ge 2,5 ]
then
	echo "Not good"
elif [ "$note" -ge 0 ]
then
	echo "Bad"
fi

