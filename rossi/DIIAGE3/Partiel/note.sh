#!/bin/bash

#Script permettant à lutilisateur de saisir une note et d'afficher un message en fonction de celle ci

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
	echo "[ERROR] You score is not in the range 0 to 10 ! Enter a new score :"
	read -r note
done

#Test if $note >=9
	if [ "$note" -ge 9 ]
	then
		echo "Perfect"

#Test if $note >=7
	elif [ "$note" -ge 7 ]
	then
		echo "Good"

#Test if $note >=5
	elif [ "$note" -ge 5 ]
	then
		echo "Not bad"

#Test if $note >=2 : Je n'arrive pas a mettre la decimale
	elif [ "$note" -ge 2 ]
	then
		echo "Not good"

#Test if $note <2 : Je n'arrive pas a mettre la decimale
	elif [ "$note" -lt 2 ]
	then
		echo "Bad"
	fi
