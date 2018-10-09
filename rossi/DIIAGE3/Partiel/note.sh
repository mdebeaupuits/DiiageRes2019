#!/bin/bash

#Test parameters =0
if [ $# -eq 0 ]
then
	echo "Please enter your score"
	read -r note
fi

#Test parameters =1
if [ $# -eq 1 ]
then
	note=$1
fi

#Test if $note > 10 ==> Error
while [ "$note" -gt 10 ]
do
	echo "[ERROR] You score is not in the range 0 to 10 !"
	read -r note
done

#If note >9
	if [ $note -ge 9 ]
	then
		echo "Perfect"
	fi

	if [ $note -ge 7 ]
	then
		echo "Good"
	fi

	if [ $note -ge 5 ]
	then
		echo "Not bad"
	fi

	if [ $note -ge 2 ]
	then
		echo "Not good"
	fi

	if [ $note -lt 2 ]
	then
		echo "Bad"
	fi
