#!/bin/bash
#Administration
#Permet ladministration des machines du parc
basemachine=data.txt

echo "Que souhaitez vous faire ? (Ajouter un hote(1), modifier un hote (2) ou supprimer (3)) ?"
read choice

function verif_ip () {
	if [[ "$ip" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then
  		echo ""
	else
  		echo "fail, entrer une adresse IP valide"
		exit
	fi
}

function ssh_timeout () {
                ssh -o ConnectTimeout=10 ${user}@${ip}
                if [[ $? -gt 1 ]]; then
                	echo "fail, erreur dans l'adresse IP ou port non ouvert ?"
                	exit
                fi
}

function add () {
	awk "BEGIN  {i=1} /${ADD}/ {i=0} END {exit i}" ${basemachine};
	if [[ $? -eq 0 ]]
	then
		echo "La machine est deja presente dans la base"
		return 1
	fi

	echo "${ADD}" >> ${basemachine}

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

		#Verification de l'adresse IP
		verif_ip

        	echo "Veuillez saisir le nom d'utilisateur de la machine :"
        	read user

		#Initialisation de la connxion SSH
		echo "Verification des informations en cours... (Ctrl+D pour quitter la machine une fois connecté et continuer le script)"
		ssh_timeout

        	echo "Veuillez saisir le nom de la distribution :"
        	read distribution
        	echo "Veuillez saisir l'OS de la machine :"
        	read os
        	echo "Environnement de la machine (prod, recette, developpement) ?"
        	read envi
		ADD="$host"":""$ip"":""$distribution"":""$os"":""$user"":""$envi"
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
