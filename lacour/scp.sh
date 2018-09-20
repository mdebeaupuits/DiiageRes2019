#!/bin/bash
#scp
#Description : permet d'envoyer un fichier de conf sur une autre machine

#Fonction qui va verifier l'existance du fichier en premier paramtètre
#function Verifier() {
#	if [[$# -ne 0]] then
#		if [[-f $1]] then
#			echo "fichier OK."
#		else
#			echo "Le fichier n'existe pas."
#		fi
#	else
#		echo "Veuillez saisir un paramètre."
#		return 1
#	fi
#	return 0
#}

#Fonction qui va envoyer le fichier de configuration
function Envoyer() {
	scp $1 $2:$3
	return 0
}
Envoyer $1 $2 $3
