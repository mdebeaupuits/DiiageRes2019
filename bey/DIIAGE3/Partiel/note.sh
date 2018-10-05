#!/bin/bash
#note.sh
#Utilitaire de saisie de notes


function calc () {
#operations begin
if [[ $choice -le 2 ]]
then
	echo "Bad"
	return 0
elif [[ $choice -le 4 ]]
then
	echo "Not Good"
	return 0
elif [[ $choice -eq 5 ]]
then
	echo "Not Good Not Bad"
elif [[ $choice -eq 5,6 ]]
then
	echo "Not Bad"
	return 0
elif [[ $choice -eq 7 ]]
then
	echo "Good"
	return 0
elif [[ $choice -eq 7,8 ]]
then
	echo "Good"
	return 0
elif [[ $choice -eq 9 ]]
then
	echo "Perfect"
	return 0
elif [[ $choice -eq 9,10 ]]
then
	echo "Perfect"
	return 0
elif [[ $choice -gt 10 ]]
then
	echo "Your score is not in the rage 0 to 10 !"
	return 1
fi
}

if [[ $# -gt 0 ]]
then
	# if parameters
	for i in $*
	do
		choice=${i}
		calc
	done
else
	#Request to user
	echo "What is your score ?"
	read choice
	calc
fi
