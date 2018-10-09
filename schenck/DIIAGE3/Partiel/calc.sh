#!/bin/bash

if [ "$#" -lt 3 ]
then
	echo "[Error] Please Give me something to do" 
	echo "[Usage] calc.sh 3 + 2"
    elif  [[ "$1" =~ ^[0-9]+$ ]] && [[ "$3" =~ ^[0-9]+$ ]] 
    then 
    	if [[ "$2" =~ ^(\+|\-|\/|\*){1}$ ]] 
	then 
		if [ $3 -ne 0 ] || [ "$2" != "/" ] 
		then
			echo "Le résultat est : "$(( $1 $2 $3 )) 
		fi 
	 fi 
fi
