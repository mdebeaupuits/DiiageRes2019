#!/bin/bash

#Script permettant de réaliser des opérations mathématiques simple : Addition, soustratction, multiplication, division.

if [ $# -eq 0 ]
then
	echo "[ERROR] Please give me something to do !"
	echo "[USAGE] calc.sh 3 + 2"
fi

number1=$1
operation=$2
number2=$2

result=$(($number1 $operation $number2))

echo "$number1 $operation $number2= $result"
