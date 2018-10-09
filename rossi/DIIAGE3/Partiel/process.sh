#!/bin/bash

#Script permettant de lister les disques durs de la machine

#Si pas de parametre alors on affiche le processus 1 (celui qui utilise le plus de CPU)
if [ $# -eq 0 ]
then
	echo "Le processus qui utilise le plus de CPU est :"
	ps -eo pid,%cpu,args | tail -n +2 | sort -rnk 2 | head -n1

#Si 1 param alors on affiche le nombre de processus egal au nombre passer en parametre (si parametre =5 alors on affiche les 5 premiers)
elif [ $# -eq 1 ]
then
	nbProcess=$1
	ps -eo pid,%cpu,args | tail -n +2 | sort -rnk 2 | head -n${nbProcess}
fi
