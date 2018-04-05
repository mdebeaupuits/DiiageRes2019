#!/bin/bash

#Script permettant de détecter si /dev/sda1 est au dela de 80%
#Initialisation de la recherche avec df

placeDisque=$(df -h | grep /dev/sda1 | awk {'print $5'} | sed 's/%//g')

#traitement sur condition superieur ou egal à n. dans mon cas, 80%
if [[ $placeDisque -gt 80 ]]
then
	echo "Il n'y a plus de place sur filesystem /dev/sda1"
else
	echo "La place disque est inferieur a 80%, tout va bien"
fi
