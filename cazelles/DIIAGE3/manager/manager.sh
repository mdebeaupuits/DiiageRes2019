#!/bin/bash
##Code fantastique mais peu indenté, ni commenté
txt=./data.txt

##Ajouter une entrée dans le fichier
function add(){
	echo "IP=$ip:Hostname=$host:User=$user:Auth=$password:OS=$os:Role=$role:VLAN=$vlan:Environnement=$environnement" >> $txt
	return $?
	echo "serveur déjà existant"
}
##Pour supprimer une entrée du fichier
function remove(){
	sed -i "/Hostname=$hostrm/d" $txt
	return $?
}

#Test de la connection  SSH 
function testSsh(){
	hostnameSsh=$(ssh -o ConnectTimeout=5 $user@$ip "hostname")
	if [[ $hostnameSsh = $host ]]
	then
		return 1
	else
		return 0
	fi
}

##Test la presence de paramètres
if [ $# -eq 0 ]
	then
	exit
fi

if [ $1 = "add" ]
then
	read -p "@ IP:" ip
	if ! [[ $ip =~ ^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$ ]];
		then
			echo "Entrez une adresse IPV4"
			exit
	fi
	read -p "Hostname:" host
	check=$(cat $txt | grep "Hostname=$host")
        	
		if [[ "t$check" != "t" || $host = "" ]];
        	then
			echo "Le serveur est déjà présent dans le fichier ou vous n'avez pas entré de nom"
		exit
		fi
	
	read -p "User:" user
	read -p "Password:" password
	testSsh
	testSsh=$?
		
		if [ $testSsh -eq 0 ]
		then
		echo "le serveur n'est pas accessible"
		exit
		fi
read -p "OS:" os
read -p "Rôle :" role
read -p "VLAN :" vlan
read -p "Environnement :" environnement
add
fi

if [ $1 = "remove" ]
then
	read -p "Quelle machine supprimer:" hostrm
	remove
fi


if [ $1 = "edit" ]
then
	read -p "Quelle machine modifier" hostedit
	#MODIFY=$(grep "${HOST}" ${FIC} | awk -F ":" '{ print $2 }' | cut -d "=" -f2)
	#cat ${FIC} | awk -F ":" '/${HOST}/ { print $2}' | cut -d "=" -f2 |sed -i
	#sed -i "s/${MODIFY}/${VALUE}/g" ${FIC}
#sed -i "s/${MODIFY}/${VALUE}/g" ${FIC}
fi
