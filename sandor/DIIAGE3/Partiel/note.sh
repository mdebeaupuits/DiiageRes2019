#!/bin/bash
#Exercice 1 note.sh
# create a script that ask the user to enter a grade which will show a message in function of the grade


get_grade () { 


echo "What is your score ?";
read -p "> " grade;


# Checking if the grade is superior to 10

if [[ "${grade}" -gt "10" ]]
then
	echo "[Error] Your score is not in the range 0 to 10 !";
else
	if [[ "${grade}" -gt "8" ]]
	then
		echo "Perfect";
	else
		if [[ "${grade}" -gt "6" ]]
		then
			echo "Good";

		else
			if [[ "${grade}" -gt "4" ]]
			then
				echo "Not bad";
			else
				if [[ "${grade}" -ge 2,5 && "${grade}" -eq 5  ]]
				then
					echo "Not good";
				else

					if [[ "$grade" -lt 2,5 ]]
					then
						echo "Bad";
					fi
				fi
			fi
		fi
	fi
fi
}
get_grade
