#!/bin/bash

if [[ $# -eq 1 ]]
then
	ps -aux|awk '{print $3"%" "\t" $11}'|grep -v %CPU|sort -n |tail -n ${1}
else
	if [[ $# -eq 0 ]]
	then	
		ps -aux|awk '{print $3"%" "\t" $11}'|grep -v %CPU|sort -n |tail -n 1 
	else
		echo "Usage : process.sh [number of process you want to see]"
		exit 1
	fi
fi

