#!/bin/bash
#Administration
#Permet ladministration des machines du parc
basemachine=data.txt

echo "Que souhaitez vous faire ? (Ajouter un hote(1), modifier un hote (2) ou supprimer (3)) ?"
read choice

function add () {
	echo "$host"":""$ip"":""$distribution"":""$os"":""$user"":""$envi" >> ${basemachine}

	#Retour erreur
	if [[ $? -eq 0 ]]
	then
		echo "Hote ajouté"
	else
		echo "Erreur non spécifiée"
	fi
}

function modify () {

	modify=$(grep ${host} ${basemachine})
        sed -i "s/${modify}/${newvaluech}/g" ${basemachine}

	#Retour erreur
	if [[ $? -eq 0 ]]
        then
                echo "Hote modifié"
        else
                echo "Erreur non spécifiée"
        fi
}

function delete () {
	sed -i "/${host}/d" ${basemachine}

	#Retour erreur
	if [[ $? -eq 0 ]]
	then
		echo "Hote supprimé"
	else
		echo "Erreur non spécifiée"
	fi
}

case $choice in
	1)
		echo "Veuillez saisir un nom d'hote :"
	        read host
	        echo "Veuillez saisir l'adresse IP de la machine :"
        	read ip
        	echo "Veuillez saisir le nom de la distribution :"
        	read distribution
        	echo "Veuillez saisir l'OS de la machine :"
        	read os
        	echo "Veuillez saisir le nom d'utilisateur de la machine :"
        	read user
        	echo "Environnement de la machine (prod, recette, developpement) ?"
        	read envi
		add
		;;
	2)
		echo "Quel machine souhaitez vous modifier ?"
		read host
		grep ${host} ${basemachine}
		echo "Copier l'ancienne ligne et changer la configuration :"
		read newvaluech
		modify
		;;

	3)
		echo "Veuillez saisir le nom de la machine :"
		read host
		delete
		;;
	*)
		echo "Erreur de choix"
esac
