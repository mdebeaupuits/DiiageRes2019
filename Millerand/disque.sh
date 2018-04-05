#!/bin/bash
#Auteur : Nathan Millerand
#Version : 1.0
#disque.sh
#Description  : Ce script permet d'envoyer une alerte si le disque /dev/sda
#est rempli a plus de 80%
#A placer dans le crontab toutes les heures 

usedDisk=$(df -h | grep /dev/sda1 | awk {'print $5'} | sed 's/\%//g')

if [[ ${usedDisk} -gt 80 ]]
then 
	echo "Le disque /dev/sda1 est utilisé à $usedDisk %, veuillez suivre la procédure d'ajout de stockage immédiatemment"
else 
	echo "Le disque /dev/sda1 est utilisé à $usedDisk %, tout est normal"
fi

