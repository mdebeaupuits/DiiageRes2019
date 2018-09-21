#!/bin/bash

# Fonctions qui permet de créer, modifier, supprimer des entrées dans un fichier plat
FIC='data.txt'
echo " Do you want to add(1), modify (2), delete (3) a line?"
read CHOICE

# Fonction permettant d'ajouter une ligne dans le fichier ${FIC}
function add (){
	# This awk allows to check if the line already exists before ading it. If it exists the script stops itself.
	awk "BEGIN  {i=1} /${ADD}/ {i=0} END {exit i}" ${FIC};
	if [[ $? -eq 0 ]]
	then
		echo "The line already exists."
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
function check_ip (){
                if [[ ${IP} =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]
                then
                        awk "BEGIN  {i=1} /${IP}/ {i=0} END {exit i}" ${FIC};
                        if [[ $? -eq 0 ]]
                        then
	                        echo "Address ${IP} already exist !"
                                return 1
                        fi
                else
	                echo "Please enter the IP address."
                        return 1
                fi
}
function check_hostname (){
	awk "BEGIN  {i=1} /${HOSTNAME}/ {i=0} END {exit i}" ${FIC};
        if [[ $? -eq 0 ]]
        then
	        echo "${HOSTNAME} already exists in the file."
		return 1
	fi

}
function check_connectivity (){
	ssh -o ConnectTimeout=10 ${USER}@${IP}
	if [[ $? -ne 0 ]]
	then
		echo "connexion problem, check the account, the password or the IP address specified"
		return 1
	fi

}
case $CHOICE in
	1)
		echo "Give the IP address"
        	read IP

		#Verify IP address function
		check_ip
		if [[ $? -eq 1 ]]
                then
                        exit 1
                        echo "Invalide IP address"
                fi

        	echo "Give the hostname"
        	read HOSTNAME

		#Go to the function for test the hostname
		check_hostname
		if [[ $? -eq 1 ]]
		then
			exit 1
			echo "The hostname is already exist on database"
		fi

		#End of function verify hostname
        	echo "Give the user account"
        	read USER

		echo "Entrer the authentification methode"
		read AUTH
		echo "trying to connect to the remote machine"

		#Test the remote connexion
		check_connectivity
		if [[ $? -eq 1 ]]
                then
                        exit 1
                        echo "Cannot connect to the remote host"
                fi

		#End of verity connectivity
        	echo "Give the OS of the host"
        	read OS

        	echo "Give the role of the host"
        	read ROLE

		echo "Enter the VLAN ?"
		read VLAN

        	echo "Give the environnment of the machine"
        	read ENVIRONNEMENT

		ADD="IP=$IP:Hostname=$HOSTNAME:User=$USER:Auth=$AUTH:OS=$OS:Role=$ROLE:VLAN=$VLAN:Environnement=$ENVIRONNEMENT"
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
	*)
		echo "You have to enter a number between 1 and 3. Exit"
		exit 1
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
