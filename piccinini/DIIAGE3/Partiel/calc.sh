#!/bin/bash
function calculate()		#Function to perform calcul
{
let "result = $1"
}

if [ $# -eq 0 ]			#Check if parameter exist
then
	echo "[Error] Please give me something to do !"
	echo "[Usage] calc.sh 3+2"
	exit
fi

while [[ $# != 0 ]]
do
	calculate $1
	echo $1 "=" $result
shift
done



