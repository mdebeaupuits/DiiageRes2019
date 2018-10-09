#!/bin/bash
#
# note.sh
#  Ce script à été réaliser pour le partiel de scripting, il permet d'afficher un message selon la note saisie par l'utilisateur.
#  Il admet plusieurs notes en arguments 
#
#

function askscore {
echo "What is your score ?"
read score
if [[ $1 -eq 11 ]]
then
	runmessages $score
fi
return $score
}

function runmessages {
score=$1
while [ $score -gt 10 ]
do	
	echo "[Error] Your score is not in the rage 0 to 10 !"
	askscore
done
if [[ $score -le 10 && $score -ge 9 ]]
then
	echo "$score -> Perfect"
elif [[ $score -le 8 && $score -ge 7 ]]
then
	echo "$score -> Good"
elif [[ $score -le 6 && $score -ge 5 ]]
then
	echo "$score -> Not bad"
#elif [[ $score -le 5 && $score > 2.5 ]]
#then
#	echo "$score -> Not good"
#elif [[ $score -lt 2.5 ]]
#then 
#	echo "$score -> Bad"
fi
return 0
}
if [[ $# = 0 ]]
then
	askscore 11
else
	for i in $@
	do
	runmessages $i
done
fi
