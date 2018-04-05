#!/bin/bash

#Description:Détecter le taux d'occupation du disque et afficher
#un message si ce dernier atteint plus de 80%.

#Récupération du seuil d'occupation du disque dur sda1:
espaceDisque=$(df -h | grep /dev/sda1 | awk {'print $5'} | sed 's/%//g')

#Maintenant on va vérifier la valeur du seuil. Si ce dernier est supérieur
#à 80%, alors on va afficher un message d'avertissement.
#Si l'espace disque occupé est en dessous du seuil, on va simplement afficher
#un message d'information:

if [[ $espaceDisque -gt 80 ]]
then
	echo "Attention votre disque dur sda1 présente un seuil d'occupation de $espaceDisque%!! Pensez à faire de la place!"
else
	echo "Votre disque dur sda1 est occupé à $espaceDisque%. Rien d'alarmant pour le moment."
fi
