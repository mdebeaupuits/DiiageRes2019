#!/bin/bash
#process.sh
#Donne un processus qui utilise le plus de CPU de la machine

if [[ $1 -eq 1 ]]
then
	ps -Ao pid,pcpu,comm | sort -nrk 3,3 | head -n $1
else
	ps -Ao pid,pcpu,comm | sort -nrk 3,3 | head -n 2
fi
