#!/bin/bash

# Script qui demande a l'utilisateur de saisir une note, et qui affiche un message en fonction de cette note

#set -x

function ReadNote() {
	echo "What is your score ?"
	read -r mark

	if [ "$mark" -gt 10 ]
  	then
    		echo "[Error] Your score is not in the rage of 0 to 10!"
		ReadNote
  	elif [ "$mark" -ge 9 ]
    	then
    		echo "Perfect"
    	elif [ "$mark" -ge 7 ]
      	then
        	echo "Good"
      	elif [ "$mark" -ge 5 ]
        then
              	echo "Not bad"
        elif [ "$mark" -ge 2.5 ]
        then
             	echo "Not good"
        elif [ "$mark" -ge 0 ]
        then
		echo "Bad"
	fi
}

ReadNote

#Bonus:

if [[ -z $1 ]]
then
	echo "Insert something please"
else
	while [[ $# -ne 0 ]]
	do
		ReadNote $1
		shift
	done
fi

