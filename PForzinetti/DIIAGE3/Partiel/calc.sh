#!/bin/bash
#Auteur : Pierre FORZINETTI
#Version : 1.0
#calc.sh
#Description  : Ce script permet de realiser des calculs simples

if [ -z $1 ] 
then
	echo "[Error] Please give me something to do !"
	echo "[Usage] \"$0 3 + 2\""
fi
val1=$1
val2=$2
ope=$3
cal=$(( $val1 $ope $val2))
echo "$val1 $ope $val2 = $cal"
