#!/bin/bash

#Si pas de parametre alors on affiche le processus 1 (celui qui utilise le plus de CPU)
if [ $# -eq 0 ]
then
	echo "Le processus qui utilise le plus de CPU est :"
	ps -eo pid,%cpu,args | tail -n +2 | sort -rnk 2 | head -n1

#Si 1 param alors on affiche le nm de processus egal au nm passer en param
elif [ $# -eq 1 ]
then
	nbProcess=$1
	ps -eo pid,%cpu,args | tail -n +2 | sort -rnk 2 | head -n${nbProcess}
fi
