#!/bin/bash
separateur=$1
str=$2

function separate()
{
	echo "Longueur = " ${#2}
	echo ${2} | tr "${1}" "\n"
}

separate ${separateur} "${str}"
