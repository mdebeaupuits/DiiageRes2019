#!/bin/bash

#function which allow user to do calculation
function calculator {
	let result=$1
	echo $1" = "${result}
}

#testing if input is null
if [[ -z $1 ]]
then
	echo "[ERROR] Please give me something to do !"
	echo "[USAGE] calc.sh 3+2"
else
	#Bonus
	while [[ $# -ne 0 ]]
	do
		calculator $1
		shift
	done
fi
