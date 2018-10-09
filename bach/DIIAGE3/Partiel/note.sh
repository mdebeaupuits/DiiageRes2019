#!/bin/bash

function gestion_note (){
	if [[ ${NOTE} -lt 0 || ${NOTE} -gt 10 ]]
	then
		echo "${NOTE} -> [Error] Your score is note in the range 0 to 10 !"
		return 1
	fi
	
	if [[ $(( 5/2 - NOTE)) -ge 0 ]]
	then
		echo "${NOTE} -> Bad"
		return 0
	fi
	if [[ $((5/2 - NOTE)) -lt 0 && ${NOTE} -lt 5 ]]
	then
		echo "${NOTE} -> Not good"
		return 0
	fi
	if [[ ${NOTE} -eq 5 ]]
	then
		echo "${NOTE} -> Not good Not bad"
		return 0
	fi
	if [[ ${NOTE} -gt 5 && ${NOTE} -lt 7 ]]
	then
		echo "${NOTE} -> Not bad"
		return 0
	fi
	if [[ ${NOTE} -ge 7 && ${NOTE} -lt 9 ]]
	then
		echo "${NOTE} -> Good"
		return 0
	fi
	if [[ ${NOTE} -ge 9 && ${NOTE} -le 10 ]]
	then
		echo "${NOTE} -> Perfect"
		return 0
	fi
}
if [[ $# -gt 0 ]]
then
	for i in $*
	do
		NOTE=${i}
		gestion_note
	done
else
	echo "What is your score ?"
	read NOTE
	gestion_note
fi
	

