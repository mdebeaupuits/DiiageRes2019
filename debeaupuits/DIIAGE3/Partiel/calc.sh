#!/bin/bash
#
# Script permettant de réaliser des calculs simple depuis un interpreteur de commandes bash 
#
if [[ $# = 0 ]]
then 
	echo -e "[Error] Please give me something to do !\n[Usage] $0 1+2"
else
	for param in $@
	do
	((i=$param))
	echo "$param = $i"
done
fi
