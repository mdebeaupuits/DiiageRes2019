#!/bin/bash
if [ $# -eq 0 ] 
then
	echo "[ERROR] Please give me something to do !"
	echo "[USAGE] \"$0 3 + 2\""
fi
first=$1
operation=$2
second=$3
result=$(( $first $operation $second))
echo "$first $operation $second = $result"
