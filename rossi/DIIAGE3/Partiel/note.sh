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

#Test if $note >=9
	if [ $note -ge 9 ]
	then
		echo "Perfect"
	fi

#Test if $note >=7
	if [ $note -ge 7 ]
	then
		echo "Good"
	fi

#Test if $note >=5
	if [ $note -ge 5 ]
	then
		echo "Not bad"
	fi

#Test if $note >=2 : Je n'arrive pas a mettre la decimale
	if [ $note -ge 2 ]
	then
		echo "Not good"
	fi

#Test if $note <2 : Je n'arrive pas a mettre la decimale
	if [ $note -lt 2 ]
	then
		echo "Bad"
	fi
