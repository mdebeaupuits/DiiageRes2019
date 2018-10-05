#!/bin/bash

function readScore()		#Function to get the user number in variable
{
echo "What is your score ?"
read score
}


function checkRange()		#Function to verify if the number is between 0 and 10
{
	if [ $1 -lt 0 ] || [ $1 -gt 10 ]
	then
	echo "[Error] Your score is not in the rage 0 to 10 !"
	fi
}


function checkScore()		#Function to check the score and write message in result
{
	if [ $1 -lt 3 ]
	then
		echo "bad"
	elif [ $1 -lt 5 ]
	then
		echo "Not Good"
	elif [ $1 -le 7 ]
	then
	echo "Not bad"
	elif [ $1 -le 8 ]
	then
		echo "Not Good"
	elif [ $1 -le 10 ]
	then
		echo "Perfect"
	fi
}

readScore
checkRange $score
checkScore $score

#while (($#)) ; do
#function readScore2()		#Function to get the user numbers in variable
#{
#read score
#}

#shift				#Rotation parameter
#done				#End of the while

