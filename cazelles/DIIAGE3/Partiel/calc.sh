#!/bin/bash
#If no parameters
if [[ $# -lt 1 ]]
then
	echo "[Error] Please give me something to do !"
	echo "[Usage] calc.sh 3 + 2"
fi
#While there is one parameter, give the calculed expression of it
while [[ $# -ge 1 ]]
do
	echo "$1 = $(($1))"
	shift
done
