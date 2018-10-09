#!/bin/bash
#Function giving an appreciation for the $note
function appreciate() {
	#If the data entered by user is not a real note, return an error message
	if ! [ "$note" -eq "$note" ] 2> /dev/null
	then
		echo "[Error] Not a number, or floating point"
	fi
	#While the note entered by user is not in the good range, ask a score in the prompt
	while [[ $note -gt 10 ]]
		do echo "[Error]Your score is not in the range 0 to 10 !"
		read -p "What is your score ?" note
	done
	#Give the appreciation depending of the score
	if [[ $note -ge 9 ]]
	then
		echo "Perfect"
	elif [[ $note -ge 7 && $note -le 8 ]]
	then
		echo "Good"
	elif [[ $note -ge 5 && $note -le 6 ]]
	then
		echo "Not bad"
	#In Bash, we can't do NATIVELY floating point arithmetic
	elif [[ $note -ge 2 && $note -le 5 ]]
	then
		echo "Not Good"
	else
		echo "Bad"
	fi
	return $?
}
#If no parameters, ask the score
if [ $# -eq 0 ]
then
	read -p "What is your score ?" note
	appreciate
fi
#If one parameter, give the appreciation for it
if [ $# -eq 1 ]
then
	note=$1
	appreciate
fi
#If many parameters, run the function for each of it (with a display of the score)
if [ $# -ge 2 ]
	then
	while [[ $# -ge 1 ]]
		do note=$1
		echo "$note -->"
appreciate
		shift
	done
fi
#End of script
