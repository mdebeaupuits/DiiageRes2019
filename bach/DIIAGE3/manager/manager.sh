#!/bin/bash

# Fonctions qui permet de créer, modifier, supprimer des entrées dans un fichier plat
FIC='data.txt'
echo " Do you want to add(1), modify (2), delete (3) a line?"
read CHOIX

# Fonction permettant d'ajouter une ligne dans le fichier ${FIC}
function add (){
	# This awk allows to check if the line already exists before ading it. If it exists the script stops itself.
	awk "BEGIN  {i=1} /${ADD}/ {i=0} END {exit i}" ${FIC}; 
	if [[ $? -eq 0 ]]
	then
		echo " the line already exists."
		return 1
	fi

	echo "${ADD}" >> ${FIC}
	
	if [[ $? -eq 1 ]]
	then
		echo "An error occured"
		return 1
	else
		return 0
	fi
}

# Fonction permettant de supprimer une ligne du fichier ${FIC}
function delete (){
	sed -i "/${DELETE}/d" ${FIC}
	if [[ $? -eq 1 ]]
	then
		echo "A problem occured while the suppression"
		return 1 
	else
		return 0
	fi
}

# Fonction permettant de modifier une ligne du fichier ${FIC}
function modify (){
	#MODIFY=$(grep "${HOST}" ${FIC} | awk -F ":" '{ print $2 }' | cut -d "=" -f2)
	#cat ${FIC} | awk -F ":" '/${HOST}/ { print $2}' | cut -d "=" -f2 |sed -i
	sed -i "s/${MODIFY}/${VALUE}/g" ${FIC}
	#sed -i "s/${MODIFY}/${VALUE}/g" ${FIC}

}
case $CHOIX in
	1)
		echo "Give the IP address"
        	read IP
		
		if [[ ${IP} =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]
		then
			echo "${IP} est une ip"
		else
			echo "cest pas le cas"
			exit 1
		fi	

        	echo "Give the hostname"
        	read HOSTNAME
        	echo "Give the user account"
        	read ACCOUNT
        	echo "Give the password to connect to the host"
        	read MDP
        	echo "Give the OS of the host"
        	read OS
        	echo "Give the role of the host"
        	read ROLE
        	echo "Give the environnment of the machine"
        	read ENVIRONNEMENT
		ADD="IP=$IP:HOSTNAME=$HOSTNAME:ACCOUNT=$ACCOUNT:MDP=$MDP:OS=$OS:ROLE=$ROLE:ENVIRONNEMENT=$ENVIRONNEMENT"
		add
		;;
	2)
		echo "which host do you want to modify"
		read HOST
		grep ${HOST} ${FIC}
		echo "copy the line above and modify what you want "
		read VALUE
		MODIFY=$(grep ${HOST} ${FIC})
		modify 
		
		;;
	3)
		cat ${FIC} |awk -F ":" '{ print $2 }'	
		echo "Which host do you want to delete? "
		read DELETE
		delete ${DELETE}
		;;
esac

case $1 in
	-a | --add)
		ADD=${2}
		add
		;;
	-m | --modify)
		${MODIFY}=${2}
		${VALUE}=${3}
		modify
		;;
	-d | --delete)
		${DELETE}=${2}
		;;
esac

