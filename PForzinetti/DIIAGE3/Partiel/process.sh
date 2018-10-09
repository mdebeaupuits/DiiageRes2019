#!/bin/bash
#Auteur : Pierre FORZINETTI
#Version : 1.0
#process.sh
#Description  : Ce script list les processus en cours d execution sur le system

if [ -z $1 ]
then
	ps aux | sort -nrk 3,3 | head -n 1
else
	ps aux | sort -nrk 3,3 | head -n $1
fi

