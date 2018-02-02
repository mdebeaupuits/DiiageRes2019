#!/bin/bash

#Script qui

function separer ()
{
	#echo $1 | awk -F ";" '{print $1,"\n" $2}'
	echo ${1} | awk -F "${2}" '{print $1,"\n" $2}'
	#echo ${1} | cut -d ";" -f1
	#echo ${1} | cut -d ";" -f2
}

separer "une phrase avec ;un caractere special" "$"

