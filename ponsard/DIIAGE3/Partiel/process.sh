#!/bin/bash
#PAUL PONSARD
#SCRIPT LISTANT LE PARAMETRE UTILISANT LE PLUS DE CPU

if [ $# -eq 0 ]
#Si aucun nombre passé en parametre
then
    ps -eo user,command | sort -nrk 3,3| head -n 1
#Si un nombre est passé en parametre
else
    nb=$1
    ps -eo user,command | sort -nrk 3,3| head -n $nb

fi

