#!/bin/bash

#function notation which deserve a judgement depending on the user input
function notation {
	#if input < 2.5
	if [[ $1 -lt 2 ]]
	then
		echo "Bad"
	else
		#if input < 5
		if [[ $1 -lt 5 ]]
		then
			echo "Not good"
		else
			#if input = 5
			if [[ $1 -eq 5 ]]
			then
				echo "Not Good Not Bad"
			else
				#if input <= 6
				if [[ $1 -le 6 ]]
				then
					echo "Not Bad"
				else
					#if input <= 8
					if [[ $1 -le 8 ]]
					then
						echo "Good"
					else
						#if input <= 10
						if [[ $1 -le 10 ]]
						then
							echo "Perfect"
						else
							echo "[ERROR] Your score is not on the range of 0 to 10"
						fi
					fi
				fi
			fi
		fi
	fi
}

#Input
#echo "What is your score ?"
#read note

#Checking if input is null
#if [[ -z ${note} ]]
#then
#	echo "[ERROR] Please insert an input"
#else
#	notation ${note}
#fi

#Bonus
if [[ -z $1 ]]
then
	echo "[ERROR] Please insert an input"
else
	while [[ $# -ne 0 ]]
	do
		notation $1
		shift
	done
fi
