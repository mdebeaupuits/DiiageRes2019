#!/bin/bash
#manager
#Permet d'ajouter, modifer et supprimer des lignes dans un fichier plat

#Variables
fic="data.txt"
re="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"

#Function qui permet l'ajout de ligne dans le fichier
function add() {
	#echo $(awk -F, '{print $1}' ${fic})
	if [[ $(awk "/$1/" ${fic}) ]]
	#if [[ $(awk -F, '{print $1}' $1) -eq $(awk -F, '{print $1}' ${fic}) ]]
	then
		echo "L'hôte existe déjà !" $1
		return 1
	else
		echo $1 >> ${fic}
                return 0
	fi
}

#Function qui permet la modification d'une ligne dans le fichier
function mod() {
	if [[ $(awk "/$1/" ${fic}) ]]
	then
                sed -i "s/^$1/^$2/g" ${fic}
		return 0
	else
                echo "La ligne $1 n'existe pas dans le fichier !"
                return 1
	fi
}

#Function qui permet de supprimer une ligne dans le fichier
function del() {
        if [[ $(awk "/$1/" ${fic}) ]]
        then
                sed -i "/"$1"/d" ${fic}
	        return 0

        else
                echo "La ligne $1 n'existe pas dans le fichier !"
                return 1
        fi
}

#Function qui va envoyer le fichier plat via ssh sur une autre machine
function send() {
	echo "coucou"
}

#Vérification de l existance d un paramètre
if [[ $# -ne 0 ]]
then
	#Options
	while getopts ":a:m:d:" option
	do
		case ${option} in
			a) shift; add $1;;
			m) shift; mod $1;;
			d) shift; del $1;;
			:) echo "Il faut un argument !";;
			*) echo "Option invalide !"
		esac
	done
else
	echo "Appel : ./manager.sh -a | -m | -d ARG"
	echo "-m : ./manager.sh -m ARG ARG2"
fi
