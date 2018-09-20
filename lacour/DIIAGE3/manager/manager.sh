#!/bin/bash
#manager.sh
#Contient trois fonctions qui vont permettre d'ajouter, modifier et supprimer
#des lignes dans un fichier plat

#Ordre : Hote : IP : User : Password : VLAN : OS : Service : Role : Environement

#Variables
fic="data.txt";

#Fonction qui permet d'ajouter des lignes dans le fichier
function add() {
#       while read line
#	do
#		if [[ "$1" -eq "$line" ]]
#		then
#			echo "Ce nom d'hote exsite déjà !"
#		else
#			echo $1 >> ${fic}
#		fi
#	done < ${fic}
	
	echo $1 >> ${fic}
	return 0
}

#Fonction qui modifie une ligne du fichier
function mod() {
	echo " ";
}

#Fonction qui permet de supprimer une ligne dans le fichier
function del() {

	sed -i '/'$1'/d' ${fic}
	return 0
}

if [[ $# -ne 0 ]]
then
#	echo "Choisir la function : add | del | mod"
#	read func
	while getopts ":a:d:m:" func
	do
		case ${func} in
			a) shift; add $1;;
			d) shift; del $1;;
			m) shift; mod $1;;
			:) echo "L'option $OPTARG requiert un argument";;
			*) echo "Option invalide !";;
		esac
	done
else
	echo "Saisir un paramètre !";
fi


