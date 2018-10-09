#!/bin/bash
#
# Ce script permet de lister les processus qui consommes le plus de ressources CPU sur la machine
#
#
if [[ $# -eq 0 ]]
then
ps aux | sort -nrk 3,3 |head -n 2 |awk '{print $2,$3,$11}'
else
((i=$1+1))
ps aux | sort -nrk 3,3 |head -n $i |awk '{print $2,$3,$11}'
fi
